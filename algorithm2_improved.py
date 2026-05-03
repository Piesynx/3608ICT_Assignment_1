import time
from dataclasses import dataclass, field
from typing import Dict, FrozenSet, List, Optional, Set, Tuple, Union
from sys import setrecursionlimit

MAX_NODE_RECURSION = 1000
setrecursionlimit(MAX_NODE_RECURSION * 2 + 1000)

from tptp_parser import (
    And, Atom, Exists, Falsity, Formula, Forall,
    Implies, Iff, Not, Or, Term, Truth,
)


# ---------------------------------------------------------------------------
# Data structures
# ---------------------------------------------------------------------------

@dataclass
class Sequent:
    antecedent: List[Formula]
    succedent: List[Formula]

    def __str__(self) -> str:
        left = ', '.join(map(str, self.antecedent))
        right = ', '.join(map(str, self.succedent))
        return f"{left} ⊢ {right}"

    def canonical_key(self) -> FrozenSet:
        """Hashable representation for loop detection."""
        return (
            frozenset(str(f) for f in self.antecedent),
            frozenset(str(f) for f in self.succedent),
        )


@dataclass
class ProofNode:
    sequent: Sequent
    rule: str
    children: List['ProofNode']
    closed: bool = False
    source_index: Optional[int] = None

    def __str__(self) -> str:
        tag = ' (closed)' if self.closed else ''
        return f"[{self.rule}] {self.sequent}{tag}"


def print_proof_tree(node: ProofNode, depth: int = 0) -> None:
    print('  ' * depth + str(node))
    for child in node.children:
        print_proof_tree(child, depth + 1)


# ---------------------------------------------------------------------------
# Term / formula utilities
# ---------------------------------------------------------------------------

def _formula_matches(a: Formula, b: Formula) -> bool:
    return a == b


def _substitute_term(term: Term, var: str, replacement: Term) -> Term:
    if term.name == var:
        return replacement
    if not term.args:
        return term
    return Term(
        name=term.name,
        args=tuple(_substitute_term(arg, var, replacement) for arg in term.args),
    )


def _substitute(formula: Formula, var: str, replacement: Term) -> Formula:
    if isinstance(formula, Atom):
        new_terms = tuple(_substitute_term(t, var, replacement) for t in formula.terms)
        new_predicate = formula.predicate
        if formula.predicate == var and not formula.terms:
            new_predicate = replacement.name
        return Atom(predicate=new_predicate, terms=new_terms)
    if isinstance(formula, Not):
        return Not(formula=_substitute(formula.formula, var, replacement))
    if isinstance(formula, And):
        return And(
            left=_substitute(formula.left, var, replacement),
            right=_substitute(formula.right, var, replacement),
        )
    if isinstance(formula, Or):
        return Or(
            left=_substitute(formula.left, var, replacement),
            right=_substitute(formula.right, var, replacement),
        )
    if isinstance(formula, Implies):
        return Implies(
            left=_substitute(formula.left, var, replacement),
            right=_substitute(formula.right, var, replacement),
        )
    if isinstance(formula, Iff):
        return Iff(
            left=_substitute(formula.left, var, replacement),
            right=_substitute(formula.right, var, replacement),
        )
    if isinstance(formula, Forall):
        if formula.variable == var:
            return formula
        return Forall(
            variable=formula.variable,
            formula=_substitute(formula.formula, var, replacement),
        )
    if isinstance(formula, Exists):
        if formula.variable == var:
            return formula
        return Exists(
            variable=formula.variable,
            formula=_substitute(formula.formula, var, replacement),
        )
    if isinstance(formula, (Truth, Falsity)):
        return formula
    raise ValueError(f"Unsupported formula type: {type(formula).__name__}")


def _collect_terms(sequent: Sequent) -> List[Term]:
    """
    Return ground terms from the sequent, shortest (fewest nested args) first.
    Constants come before compound terms so the prover tries the simplest
    witnesses first when instantiating quantifiers.
    """
    seen: Set[str] = set()
    terms: List[Term] = []

    def _depth(t: Term) -> int:
        return 0 if not t.args else 1 + max(_depth(a) for a in t.args)

    def _visit_term(term: Term) -> None:
        key = str(term)
        if key in seen:
            return
        seen.add(key)
        terms.append(term)
        for arg in term.args:
            _visit_term(arg)

    def _visit_formula(formula: Formula) -> None:
        if isinstance(formula, Atom):
            for t in formula.terms:
                _visit_term(t)
        elif isinstance(formula, Not):
            _visit_formula(formula.formula)
        elif isinstance(formula, (And, Or, Implies, Iff)):
            _visit_formula(formula.left)
            _visit_formula(formula.right)
        elif isinstance(formula, (Forall, Exists)):
            _visit_formula(formula.formula)

    for f in sequent.antecedent + sequent.succedent:
        _visit_formula(f)

    terms.sort(key=_depth)
    return terms


def _fresh_term_name(sequent: Sequent) -> str:
    existing_names: Set[str] = set()

    def _visit_term(term: Term) -> None:
        existing_names.add(term.name)
        for arg in term.args:
            _visit_term(arg)

    def _visit_formula(formula: Formula) -> None:
        if isinstance(formula, Atom):
            for t in formula.terms:
                _visit_term(t)
        elif isinstance(formula, Not):
            _visit_formula(formula.formula)
        elif isinstance(formula, (And, Or, Implies, Iff)):
            _visit_formula(formula.left)
            _visit_formula(formula.right)
        elif isinstance(formula, (Forall, Exists)):
            _visit_formula(formula.formula)

    for f in sequent.antecedent + sequent.succedent:
        _visit_formula(f)

    index = 0
    while True:
        name = f"c{index}"
        if name not in existing_names:
            return name
        index += 1


def _copy_used_instantiations(used: Dict) -> Dict:
    return {key: set(values) for key, values in used.items()}


# ---------------------------------------------------------------------------
# Axiom / truth rules  (no premises)
# ---------------------------------------------------------------------------

def _apply_id_top_bot(sequent: Sequent) -> Optional[ProofNode]:
    """Identity, ⊤R, ⊥L — all close the goal immediately."""
    for left in sequent.antecedent:
        for right in sequent.succedent:
            if _formula_matches(left, right):
                return ProofNode(sequent=sequent, rule='id', children=[], closed=True)
    if any(isinstance(f, Truth) for f in sequent.succedent):
        return ProofNode(sequent=sequent, rule='⊤R', children=[], closed=True)
    if any(isinstance(f, Falsity) for f in sequent.antecedent):
        return ProofNode(sequent=sequent, rule='⊥L', children=[], closed=True)
    return None


# ---------------------------------------------------------------------------
# Invertible rules  (single premise, never lose information)
# ---------------------------------------------------------------------------

def _first_applicable_invertible(sequent: Sequent) -> Optional[ProofNode]:
    """
    Apply the first invertible rule found.  Invertible rules are always safe
    to apply eagerly because they cannot close a provable goal.

    Antecedent rules:  ∧L  ¬L  ⊥L(handled above)  IffL→(A→B)∧(B→A)
    Succedent rules:   ∨R  →R  ¬R  ∀R  IffR
    """
    # --- Antecedent ---
    for i, formula in enumerate(sequent.antecedent):
        rest_ant = sequent.antecedent[:i] + sequent.antecedent[i + 1:]

        if isinstance(formula, And):
            new_ant = rest_ant + [formula.left, formula.right]
            child = ProofNode(
                sequent=Sequent(antecedent=new_ant, succedent=sequent.succedent.copy()),
                rule='∧L', children=[],
            )
            return ProofNode(sequent=sequent, rule='∧L', children=[child], source_index=i)

        if isinstance(formula, Not):
            new_suc = sequent.succedent + [formula.formula]
            child = ProofNode(
                sequent=Sequent(antecedent=rest_ant, succedent=new_suc),
                rule='¬L', children=[],
            )
            return ProofNode(sequent=sequent, rule='¬L', children=[child], source_index=i)

        if isinstance(formula, Iff):
            # A↔B  ≡  (A→B)∧(B→A)  — decompose into two implications
            ab = Implies(left=formula.left, right=formula.right)
            ba = Implies(left=formula.right, right=formula.left)
            new_ant = rest_ant + [ab, ba]
            child = ProofNode(
                sequent=Sequent(antecedent=new_ant, succedent=sequent.succedent.copy()),
                rule='↔L', children=[],
            )
            return ProofNode(sequent=sequent, rule='↔L', children=[child], source_index=i)

    # --- Succedent ---
    for i, formula in enumerate(sequent.succedent):
        rest_suc = sequent.succedent[:i] + sequent.succedent[i + 1:]

        if isinstance(formula, Or):
            new_suc = rest_suc + [formula.left, formula.right]
            child = ProofNode(
                sequent=Sequent(antecedent=sequent.antecedent.copy(), succedent=new_suc),
                rule='∨R', children=[],
            )
            return ProofNode(sequent=sequent, rule='∨R', children=[child])

        if isinstance(formula, Implies):
            new_ant = sequent.antecedent.copy() + [formula.left]
            new_suc = rest_suc + [formula.right]
            child = ProofNode(
                sequent=Sequent(antecedent=new_ant, succedent=new_suc),
                rule='→R', children=[],
            )
            return ProofNode(sequent=sequent, rule='→R', children=[child])

        if isinstance(formula, Not):
            new_ant = sequent.antecedent + [formula.formula]
            child = ProofNode(
                sequent=Sequent(antecedent=new_ant, succedent=rest_suc),
                rule='¬R', children=[],
            )
            return ProofNode(sequent=sequent, rule='¬R', children=[child])

        if isinstance(formula, Forall):
            # ∀R is invertible: introduce a fresh eigenvariable
            fresh = Term(name=_fresh_term_name(sequent))
            instantiated = _substitute(formula.formula, formula.variable, fresh)
            new_suc = rest_suc + [instantiated]
            child = ProofNode(
                sequent=Sequent(antecedent=sequent.antecedent.copy(), succedent=new_suc),
                rule='∀R', children=[],
            )
            return ProofNode(sequent=sequent, rule='∀R', children=[child])

        if isinstance(formula, Iff):
            # A↔B on right: prove both A→B and B→A
            ab = Implies(left=formula.left, right=formula.right)
            ba = Implies(left=formula.right, right=formula.left)
            new_suc = rest_suc + [ab, ba]
            child = ProofNode(
                sequent=Sequent(antecedent=sequent.antecedent.copy(), succedent=new_suc),
                rule='↔R', children=[],
            )
            return ProofNode(sequent=sequent, rule='↔R', children=[child])

    return None


# ---------------------------------------------------------------------------
# Branching rules  (two premises)
# ---------------------------------------------------------------------------

def _first_applicable_branching(sequent: Sequent) -> Optional[ProofNode]:
    """
    Apply the first branching (non-invertible) rule.
    These split the goal into two sub-goals that must both be closed.

    Antecedent: ∨L  →L
    Succedent:  ∧R
    """
    # Succedent ∧R first — both sub-goals share the same antecedent
    for i, formula in enumerate(sequent.succedent):
        rest_suc = sequent.succedent[:i] + sequent.succedent[i + 1:]
        if isinstance(formula, And):
            left_child = ProofNode(
                sequent=Sequent(
                    antecedent=sequent.antecedent.copy(),
                    succedent=rest_suc + [formula.left],
                ),
                rule='∧R', children=[],
            )
            right_child = ProofNode(
                sequent=Sequent(
                    antecedent=sequent.antecedent.copy(),
                    succedent=rest_suc + [formula.right],
                ),
                rule='∧R', children=[],
            )
            return ProofNode(sequent=sequent, rule='∧R', children=[left_child, right_child])

    # Antecedent ∨L and →L
    for i, formula in enumerate(sequent.antecedent):
        rest_ant = sequent.antecedent[:i] + sequent.antecedent[i + 1:]

        if isinstance(formula, Or):
            left_child = ProofNode(
                sequent=Sequent(
                    antecedent=rest_ant + [formula.left],
                    succedent=sequent.succedent.copy(),
                ),
                rule='∨L', children=[],
            )
            right_child = ProofNode(
                sequent=Sequent(
                    antecedent=rest_ant + [formula.right],
                    succedent=sequent.succedent.copy(),
                ),
                rule='∨L', children=[],
            )
            return ProofNode(
                sequent=sequent, rule='∨L',
                children=[left_child, right_child], source_index=i,
            )

        if isinstance(formula, Implies):
            # Γ, A→B ⊢ Δ  splits into  Γ ⊢ A, Δ  and  Γ, B ⊢ Δ
            left_child = ProofNode(
                sequent=Sequent(
                    antecedent=rest_ant,
                    succedent=sequent.succedent.copy() + [formula.left],
                ),
                rule='→L', children=[],
            )
            right_child = ProofNode(
                sequent=Sequent(
                    antecedent=rest_ant + [formula.right],
                    succedent=sequent.succedent.copy(),
                ),
                rule='→L', children=[],
            )
            return ProofNode(
                sequent=sequent, rule='→L',
                children=[left_child, right_child], source_index=i,
            )

    return None


# ---------------------------------------------------------------------------
# Quantifier instantiation
# ---------------------------------------------------------------------------

def _instantiate_quantifier_with_existing_term(
    sequent: Sequent, used: Dict
) -> Optional[ProofNode]:
    """
    Try to instantiate a quantifier with an already-present ground term.

    ∀L  and  ∃R  keep the original quantified formula (weakening) so it
              can be instantiated again with different terms.
    ∃L  introduces a fresh eigenvariable (invertible rule, handled below).
    """
    terms = _collect_terms(sequent)
    if not terms:
        return None

    for i, formula in enumerate(sequent.antecedent):
        if isinstance(formula, Forall):
            key = (str(formula), formula.variable)
            known: Set[str] = used.setdefault(key, set())
            for term in terms:
                tk = str(term)
                if tk in known:
                    continue
                known.add(tk)
                instantiated = _substitute(formula.formula, formula.variable, term)
                new_ant = (
                    sequent.antecedent[:i]
                    + [formula, instantiated]
                    + sequent.antecedent[i + 1:]
                )
                child = ProofNode(
                    sequent=Sequent(antecedent=new_ant, succedent=sequent.succedent.copy()),
                    rule='∀L', children=[],
                )
                return ProofNode(
                    sequent=sequent, rule='∀L', children=[child], source_index=i
                )

    for i, formula in enumerate(sequent.succedent):
        if isinstance(formula, Exists):
            key = (str(formula), formula.variable)
            known = used.setdefault(key, set())
            for term in terms:
                tk = str(term)
                if tk in known:
                    continue
                known.add(tk)
                instantiated = _substitute(formula.formula, formula.variable, term)
                new_suc = (
                    sequent.succedent[:i]
                    + [formula, instantiated]
                    + sequent.succedent[i + 1:]
                )
                child = ProofNode(
                    sequent=Sequent(antecedent=sequent.antecedent.copy(), succedent=new_suc),
                    rule='∃R', children=[],
                )
                return ProofNode(sequent=sequent, rule='∃R', children=[child])

    return None


def _instantiate_existential_left_fresh(
    sequent: Sequent, used: Dict
) -> Optional[ProofNode]:
    """
    ∃L is invertible: Γ, ∃x.A ⊢ Δ  iff  Γ, A[c/x] ⊢ Δ  for a fresh constant c.
    The original ∃x.A formula is consumed (replaced) because c is fresh and
    does not appear anywhere else, so re-instantiating would give the same result.
    """
    for i, formula in enumerate(sequent.antecedent):
        if isinstance(formula, Exists):
            key = (str(formula), formula.variable)
            if key in used:
                continue  # already introduced an eigenvariable for this formula
            fresh = Term(name=_fresh_term_name(sequent))
            used[key] = {str(fresh)}
            instantiated = _substitute(formula.formula, formula.variable, fresh)
            # Remove the ∃ formula and replace with instantiation (eigenvariable rule)
            new_ant = (
                sequent.antecedent[:i]
                + [instantiated]
                + sequent.antecedent[i + 1:]
            )
            child = ProofNode(
                sequent=Sequent(antecedent=new_ant, succedent=sequent.succedent.copy()),
                rule='∃L', children=[],
            )
            return ProofNode(
                sequent=sequent, rule='∃L', children=[child], source_index=i
            )
    return None


def _instantiate_quantifier_with_fresh_term(
    sequent: Sequent, used: Dict
) -> Optional[ProofNode]:
    """
    Last resort: introduce a completely new constant and try ∀L / ∃R with it.
    This triggers when no existing term works, pumping new witnesses into scope.
    """
    for i, formula in enumerate(sequent.antecedent):
        if isinstance(formula, Forall):
            fresh = Term(name=_fresh_term_name(sequent))
            key = (str(formula), formula.variable)
            used.setdefault(key, set()).add(str(fresh))
            instantiated = _substitute(formula.formula, formula.variable, fresh)
            new_ant = (
                sequent.antecedent[:i]
                + [formula, instantiated]
                + sequent.antecedent[i + 1:]
            )
            child = ProofNode(
                sequent=Sequent(antecedent=new_ant, succedent=sequent.succedent.copy()),
                rule='∀L', children=[],
            )
            return ProofNode(
                sequent=sequent, rule='∀L', children=[child], source_index=i
            )

    for i, formula in enumerate(sequent.succedent):
        if isinstance(formula, Exists):
            fresh = Term(name=_fresh_term_name(sequent))
            key = (str(formula), formula.variable)
            used.setdefault(key, set()).add(str(fresh))
            instantiated = _substitute(formula.formula, formula.variable, fresh)
            new_suc = (
                sequent.succedent[:i]
                + [formula, instantiated]
                + sequent.succedent[i + 1:]
            )
            child = ProofNode(
                sequent=Sequent(antecedent=sequent.antecedent.copy(), succedent=new_suc),
                rule='∃R', children=[],
            )
            return ProofNode(sequent=sequent, rule='∃R', children=[child])

    return None


# ---------------------------------------------------------------------------
# Main proof search
# ---------------------------------------------------------------------------

def _build_proof_and_attempt(
    sequent: Sequent,
    deadline: float,
    used_instantiations: Optional[Dict] = None,
    depth: int = 0,
    visited: Optional[Set] = None,
) -> Tuple[Optional[ProofNode], ProofNode]:
    """
    Returns (proof, attempt) where proof is None if the sequent is not provable
    (or the search gave up) and attempt is the partial derivation tree.
    """
    if depth > MAX_NODE_RECURSION:
        failed = ProofNode(sequent=sequent, rule='recursion-limit', children=[])
        return None, failed

    if time.time() > deadline:
        failed = ProofNode(sequent=sequent, rule='timeout', children=[])
        return None, failed

    if used_instantiations is None:
        used_instantiations = {}
    if visited is None:
        visited = set()

    # --- Loop detection ---
    canon = sequent.canonical_key()
    # if canon in visited:
    #     failed = ProofNode(sequent=sequent, rule='loop', children=[])
    #     return None, failed
    visited = visited | {canon}   # immutable update per branch

    # --- Axiom rules ---
    closed = _apply_id_top_bot(sequent)
    if closed is not None:
        return closed, closed

    # --- Invertible rules (always safe) ---
    node = _first_applicable_invertible(sequent)
    if node is not None:
        proof_child, attempt_child = _build_proof_and_attempt(
            node.children[0].sequent, deadline, used_instantiations, depth + 1, visited
        )
        node.children[0] = attempt_child
        if proof_child is None:
            return None, node
        node.closed = all(c.closed for c in node.children)
        return node, node

    # --- ∃L with fresh eigenvariable (also invertible) ---
    node = _instantiate_existential_left_fresh(sequent, used_instantiations)
    if node is not None:
        proof_child, attempt_child = _build_proof_and_attempt(
            node.children[0].sequent, deadline, used_instantiations, depth + 1, visited
        )
        node.children[0] = attempt_child
        if proof_child is None:
            return None, node
        node.closed = True
        return node, node

    # --- Branching rules ---
    node = _first_applicable_branching(sequent)
    if node is not None:
        proof_children: List[Optional[ProofNode]] = []
        attempt_children: List[ProofNode] = []
        for child_node in node.children:
            child_used = _copy_used_instantiations(used_instantiations)
            proof_child, attempt_child = _build_proof_and_attempt(
                child_node.sequent, deadline, child_used, depth + 1, visited
            )
            proof_children.append(proof_child)
            attempt_children.append(attempt_child)
        node.children = attempt_children
        if any(c is None for c in proof_children):
            return None, node
        node.closed = True
        return node, node

    # --- ∀L / ∃R with existing terms ---
    node = _instantiate_quantifier_with_existing_term(sequent, used_instantiations)
    if node is not None:
        proof_child, attempt_child = _build_proof_and_attempt(
            node.children[0].sequent, deadline, used_instantiations, depth + 1, visited
        )
        node.children[0] = attempt_child
        if proof_child is None:
            return None, node
        node.closed = True
        return node, node

    # --- ∀L / ∃R with a fresh constant (last resort) ---
    node = _instantiate_quantifier_with_fresh_term(sequent, used_instantiations)
    if node is not None:
        proof_child, attempt_child = _build_proof_and_attempt(
            node.children[0].sequent, deadline, used_instantiations, depth + 1, visited
        )
        node.children[0] = attempt_child
        if proof_child is None:
            return None, node
        node.closed = True
        return node, node

    failed = ProofNode(sequent=sequent, rule='fail', children=[])
    return None, failed


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def run_with_timeout(function, *args, timeout_seconds: float = 5.0, **kwargs):
    deadline = time.time() + timeout_seconds
    result = function(*args, timeout_seconds=timeout_seconds, **kwargs)
    if time.time() > deadline:
        raise TimeoutError("Wrapped function exceeded timeout")
    return result


def _collect_used_axiom_indices(proof: ProofNode) -> Set[int]:
    used: Set[int] = set()

    def visit(node: ProofNode) -> None:
        if node.source_index is not None:
            used.add(node.source_index)
        for child in node.children:
            visit(child)

    visit(proof)
    return used


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

if __name__ == '__main__':
    import argparse
    import sys
    from tptp_parser import FormulaEntry, parse_tptp_file
    from isabelle_parser import parse_isabelle_file

    parser = argparse.ArgumentParser(
        description='Apply proof-search to first-order logic sequents.'
    )
    parser.add_argument('file', help='Path to the input file (.fof or .p)')
    parser.add_argument(
        '--parser', choices=['tptp', 'isabelle'], default=None,
        help='Parser type. Inferred from file extension if omitted.',
    )
    parser.add_argument('--timeout', type=float, default=5.0,
                        help='Timeout in seconds (default: 5.0)')
    parser.add_argument(
        '--verbose', action='store_true',
        help='Print the attempted derivation tree even for unprovable conjectures',
    )

    args = parser.parse_args()
    path = args.file
    timeout = args.timeout
    verbose = args.verbose

    if args.parser == 'tptp' or (args.parser is None and not path.lower().endswith('.p')):
        entries = parse_tptp_file(path)
    else:
        entries = parse_isabelle_file(path)

    conjecture_positions = [
        (i, entry) for i, entry in enumerate(entries)
        if entry.role.lower() == 'conjecture'
    ]

    if not conjecture_positions:
        print('No conjectures found in the file.')
        sys.exit(0)

    last_conjecture_index = -1
    for conj_index, conjecture in conjecture_positions:
        axiom_entries = [
            entry for entry in entries[last_conjecture_index + 1:conj_index]
            if entry.role.lower() == 'axiom'
        ]
        axioms = [entry.formula for entry in axiom_entries]
        sequent = Sequent(antecedent=axioms.copy(), succedent=[conjecture.formula])
        try:
            proof, attempt = _build_proof_and_attempt(sequent, time.time() + timeout)
            if proof is not None:
                label = 'is provable'
            elif attempt.rule == 'recursion-limit':
                label = f'exceeded recursion limit ({MAX_NODE_RECURSION} nodes)'
            elif attempt.rule == 'timeout':
                label = 'timed out'
            elif attempt.rule == 'loop':
                label = 'detected a proof-search loop'
            else:
                label = 'is unprovable'
        except RecursionError:
            proof = None
            attempt = ProofNode(sequent=sequent, rule='recursion-error', children=[])
            label = 'exceeded Python recursion limit'

        print(f"Conjecture {conjecture.name} {label}.")
        if verbose:
            print('Derivation tree:')
            print_proof_tree(proof if proof is not None else attempt)

        last_conjecture_index = conj_index
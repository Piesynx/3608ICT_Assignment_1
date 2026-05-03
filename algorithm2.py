import time
from dataclasses import dataclass
from typing import Dict, List, Optional, Set, Tuple, Union
from sys import setrecursionlimit
MAX_NODE_RECURSION = 1000
setrecursionlimit(MAX_NODE_RECURSION * 2 + 1000)  # Allow deeper recursion for proof search
from tptp_parser import (
    And,
    Atom,
    Exists,
    Falsity,
    Formula,
    Forall,
    Implies,
    Iff,
    Not,
    Or,
    Term,
    Truth,
)


@dataclass
class Sequent:
    antecedent: List[Formula]
    succedent: List[Formula]

    def __str__(self) -> str:
        left = ', '.join(map(str, self.antecedent))
        right = ', '.join(map(str, self.succedent))
        return f"{left} ⊢ {right}"


@dataclass
class ProofNode:
    sequent: Sequent
    rule: str
    children: List['ProofNode']
    closed: bool = False
    source_index: Optional[int] = None

    def __str__(self) -> str:
        if self.closed:
            return f"[{self.rule}] {self.sequent} (closed)"
        return f"[{self.rule}] {self.sequent}"


def print_proof_tree(node: ProofNode, depth: int = 0) -> None:
    indent = '  ' * depth
    print(f"{indent}{node}")
    for child in node.children:
        print_proof_tree(child, depth + 1)


def _formula_matches(a: Formula, b: Formula) -> bool:
    return a == b


def _substitute_term(term: Term, var: str, replacement: Term) -> Term:
    if term.name == var:
        return replacement
    if not term.args:
        return term
    return Term(name=term.name, args=tuple(_substitute_term(arg, var, replacement) for arg in term.args))


def _substitute(formula: Formula, var: str, replacement: Term) -> Formula:
    if isinstance(formula, Atom):
        # Substitute terms as usual
        new_terms = tuple(_substitute_term(t, var, replacement) for t in formula.terms)
        # Also substitute the predicate if it's a variable matching var
        new_predicate = formula.predicate
        if formula.predicate == var and not formula.terms:
            # Atom with no terms and predicate is the variable being substituted
            # Replace predicate with the replacement term's name
            new_predicate = replacement.name
        return Atom(predicate=new_predicate, terms=new_terms)
    if isinstance(formula, Not):
        return Not(formula=_substitute(formula.formula, var, replacement))
    if isinstance(formula, And):
        return And(left=_substitute(formula.left, var, replacement), right=_substitute(formula.right, var, replacement))
    if isinstance(formula, Or):
        return Or(left=_substitute(formula.left, var, replacement), right=_substitute(formula.right, var, replacement))
    if isinstance(formula, Implies):
        return Implies(left=_substitute(formula.left, var, replacement), right=_substitute(formula.right, var, replacement))
    if isinstance(formula, Iff):
        return Iff(left=_substitute(formula.left, var, replacement), right=_substitute(formula.right, var, replacement))
    if isinstance(formula, Forall):
        if formula.variable == var:
            return formula
        return Forall(variable=formula.variable, formula=_substitute(formula.formula, var, replacement))
    if isinstance(formula, Exists):
        if formula.variable == var:
            return formula
        return Exists(variable=formula.variable, formula=_substitute(formula.formula, var, replacement))
    if isinstance(formula, Truth) or isinstance(formula, Falsity):
        return formula
    raise ValueError(f"Unsupported formula type for substitution: {type(formula).__name__}")


def _collect_terms(sequent: Sequent) -> Set[Term]:
    terms: Set[Term] = set()

    def _visit_term(term: Term) -> None:
        terms.add(term)
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
    return terms


def _copy_used_instantiations(used: Dict) -> Dict:
    return {key: set(values) for key, values in used.items()}


def _apply_id_top_bot(sequent: Sequent) -> Optional[ProofNode]:
    for left in sequent.antecedent:
        for right in sequent.succedent:
            if _formula_matches(left, right):
                return ProofNode(sequent=sequent, rule='id', children=[], closed=True)
    if any(isinstance(f, Truth) for f in sequent.succedent):
        return ProofNode(sequent=sequent, rule='topR', children=[], closed=True)
    if any(isinstance(f, Falsity) for f in sequent.antecedent):
        return ProofNode(sequent=sequent, rule='botL', children=[], closed=True)
    return None


def _first_applicable_invertible(sequent: Sequent) -> Optional[ProofNode]:
    for i, formula in enumerate(sequent.antecedent):
        if isinstance(formula, And):
            new_ant = sequent.antecedent[:i] + [formula.left, formula.right] + sequent.antecedent[i + 1:]
            child = ProofNode(sequent=Sequent(antecedent=new_ant, succedent=sequent.succedent.copy()), rule='∧L', children=[])
            return ProofNode(sequent=sequent, rule='∧L', children=[child], source_index=i)
        if isinstance(formula, Not):
            new_ant = sequent.antecedent[:i] + sequent.antecedent[i + 1:]
            new_suc = sequent.succedent + [formula.formula]
            child = ProofNode(sequent=Sequent(antecedent=new_ant, succedent=new_suc), rule='¬L', children=[])
            return ProofNode(sequent=sequent, rule='¬L', children=[child], source_index=i)
    for i, formula in enumerate(sequent.succedent):
        if isinstance(formula, Or):
            new_suc = sequent.succedent[:i] + [formula.left, formula.right] + sequent.succedent[i + 1:]
            child = ProofNode(sequent=Sequent(antecedent=sequent.antecedent.copy(), succedent=new_suc), rule='∨R', children=[])
            return ProofNode(sequent=sequent, rule='∨R', children=[child])
        if isinstance(formula, Implies):
            new_ant = sequent.antecedent.copy() + [formula.left]
            new_suc = sequent.succedent[:i] + [formula.right] + sequent.succedent[i + 1:]
            child = ProofNode(sequent=Sequent(antecedent=new_ant, succedent=new_suc), rule='→R', children=[])
            return ProofNode(sequent=sequent, rule='→R', children=[child])
        if isinstance(formula, Not):
            new_suc = sequent.succedent[:i] + sequent.succedent[i + 1:]
            new_ant = sequent.antecedent + [formula.formula]
            child = ProofNode(sequent=Sequent(antecedent=new_ant, succedent=new_suc), rule='¬R', children=[])
            return ProofNode(sequent=sequent, rule='¬R', children=[child])
        if isinstance(formula, Forall):
            fresh = Term(name=_fresh_term_name(sequent))
            instantiated = _substitute(formula.formula, formula.variable, fresh)
            new_suc = sequent.succedent[:i] + [instantiated] + sequent.succedent[i + 1:]
            child = ProofNode(sequent=Sequent(antecedent=sequent.antecedent.copy(), succedent=new_suc), rule='∀R', children=[])
            return ProofNode(sequent=sequent, rule='∀R', children=[child])
    return None


def _first_applicable_branching(sequent: Sequent) -> Optional[ProofNode]:
    for i, formula in enumerate(sequent.succedent):
        if isinstance(formula, And):
            left = ProofNode(sequent=Sequent(antecedent=sequent.antecedent.copy(), succedent=sequent.succedent[:i] + [formula.left] + sequent.succedent[i + 1:]), rule='∧R', children=[])
            right = ProofNode(sequent=Sequent(antecedent=sequent.antecedent.copy(), succedent=sequent.succedent[:i] + [formula.right] + sequent.succedent[i + 1:]), rule='∧R', children=[])
            return ProofNode(sequent=sequent, rule='∧R', children=[left, right])
        if isinstance(formula, Or):
            left = ProofNode(sequent=Sequent(antecedent=sequent.antecedent[:i] + [formula.left] + sequent.antecedent[i + 1:], succedent=sequent.succedent.copy()), rule='∨L', children=[])
            right = ProofNode(sequent=Sequent(antecedent=sequent.antecedent[:i] + [formula.right] + sequent.antecedent[i + 1:], succedent=sequent.succedent.copy()), rule='∨L', children=[])
            return ProofNode(sequent=sequent, rule='∨L', children=[left, right])
    for i, formula in enumerate(sequent.antecedent):
        if isinstance(formula, Or):
            left = ProofNode(sequent=Sequent(antecedent=sequent.antecedent[:i] + [formula.left] + sequent.antecedent[i + 1:], succedent=sequent.succedent.copy()), rule='∨L', children=[])
            right = ProofNode(sequent=Sequent(antecedent=sequent.antecedent[:i] + [formula.right] + sequent.antecedent[i + 1:], succedent=sequent.succedent.copy()), rule='∨L', children=[])
            return ProofNode(sequent=sequent, rule='∨L', children=[left, right], source_index=i)
        if isinstance(formula, Implies):
            left = ProofNode(sequent=Sequent(antecedent=sequent.antecedent[:i] + sequent.antecedent[i + 1:], succedent=sequent.succedent.copy() + [formula.left]), rule='→L', children=[])
            right = ProofNode(sequent=Sequent(antecedent=sequent.antecedent[:i] + [formula.right] + sequent.antecedent[i + 1:], succedent=sequent.succedent.copy()), rule='→L', children=[])
            return ProofNode(sequent=sequent, rule='→L', children=[left, right], source_index=i)
    return None


def _instantiate_quantifier_with_existing_term(sequent: Sequent, used: Dict) -> Optional[ProofNode]:
    terms = _collect_terms(sequent)
    if not terms:
        return None
    for i, formula in enumerate(sequent.antecedent):
        if isinstance(formula, Forall):
            # Use formula itself as key (not id()) so it stays stable
            # across sequent copies where object identity changes.
            key = (formula, formula.variable)
            known = used.setdefault(key, set())
            for term in terms:
                if term in known:
                    continue
                # Mark term as used before constructing child
                known.add(term)
                instantiated = _substitute(formula.formula, formula.variable, term)
                new_ant = sequent.antecedent[:i] + [formula, instantiated] + sequent.antecedent[i + 1:]
                child = ProofNode(sequent=Sequent(antecedent=new_ant, succedent=sequent.succedent.copy()), rule='∀L', children=[])
                return ProofNode(sequent=sequent, rule='∀L', children=[child], source_index=i)
        if isinstance(formula, Exists):
            # Track ∃L instantiations to prevent re-instantiating with the same term
            key = (formula, formula.variable)
            known = used.setdefault(key, set())
            for term in terms:
                if term in known:
                    continue
                # Mark term as used before constructing child
                known.add(term)
                instantiated = _substitute(formula.formula, formula.variable, term)
                # Keep the original Exists formula so it can be re-instantiated
                # with other terms, but prevent using the same term twice
                new_ant = sequent.antecedent[:i] + [formula, instantiated] + sequent.antecedent[i + 1:]
                child = ProofNode(sequent=Sequent(antecedent=new_ant, succedent=sequent.succedent.copy()), rule='∃L', children=[])
                return ProofNode(sequent=sequent, rule='∃L', children=[child], source_index=i)
    for i, formula in enumerate(sequent.succedent):
        if isinstance(formula, Exists):
            # Use formula itself as key (not id()) so it stays stable
            # across sequent copies where object identity changes, mirroring ∀L fix.
            key = (formula, formula.variable)
            known = used.setdefault(key, set())
            for term in terms:
                if term in known:
                    continue
                # Mark term as used before constructing child
                known.add(term)
                instantiated = _substitute(formula.formula, formula.variable, term)
                # Keep the original Exists formula so it can be re-instantiated
                # with other terms, mirroring how ∀L retains the Forall formula.
                new_suc = sequent.succedent[:i] + [formula, instantiated] + sequent.succedent[i + 1:]
                child = ProofNode(sequent=Sequent(antecedent=sequent.antecedent.copy(), succedent=new_suc), rule='∃R', children=[])
                return ProofNode(sequent=sequent, rule='∃R', children=[child])
    return None


def _instantiate_quantifier_with_fresh_term(sequent: Sequent, used: Dict) -> Optional[ProofNode]:
    for i, formula in enumerate(sequent.antecedent):
        if isinstance(formula, Forall):
            fresh = Term(name=_fresh_term_name(sequent))
            key = (formula, formula.variable)
            used.setdefault(key, set()).add(fresh)
            instantiated = _substitute(formula.formula, formula.variable, fresh)
            new_ant = sequent.antecedent[:i] + [formula, instantiated] + sequent.antecedent[i + 1:]
            child = ProofNode(sequent=Sequent(antecedent=new_ant, succedent=sequent.succedent.copy()), rule='∀L', children=[])
            return ProofNode(sequent=sequent, rule='∀L', children=[child], source_index=i)
    for i, formula in enumerate(sequent.succedent):
        if isinstance(formula, Exists):
            fresh = Term(name=_fresh_term_name(sequent))
            key = (formula, formula.variable)
            # Track fresh term instantiations to prevent re-instantiation with same term
            used.setdefault(key, set()).add(fresh)
            instantiated = _substitute(formula.formula, formula.variable, fresh)
            new_suc = sequent.succedent[:i] + [formula, instantiated] + sequent.succedent[i + 1:]
            child = ProofNode(sequent=Sequent(antecedent=sequent.antecedent.copy(), succedent=new_suc), rule='∃R', children=[])
            return ProofNode(sequent=sequent, rule='∃R', children=[child])
    return None


def _fresh_term_name(sequent: Sequent) -> str:
    terms = _collect_terms(sequent)
    index = 0
    while True:
        name = f"c{index}"
        if name not in terms:
            return name
        index += 1


def _build_proof_and_attempt(sequent: Sequent, deadline: float, used_instantiations: Optional[Dict] = None, depth: int = 0) -> Tuple[Optional[ProofNode], ProofNode]:
    if depth > MAX_NODE_RECURSION:
        return None, ProofNode(sequent=sequent, rule='recursion-limit', children=[])
    if used_instantiations is None:
        used_instantiations = {}
    if time.time() > deadline:
        return None, ProofNode(sequent=sequent, rule='timeout', children=[])
    closed = _apply_id_top_bot(sequent)
    if closed is not None:
        return closed, closed
    node = _first_applicable_invertible(sequent)
    if node is not None:
        proof_child, attempt_child = _build_proof_and_attempt(node.children[0].sequent, deadline, used_instantiations, depth + 1)
        node.children[0] = attempt_child
        if proof_child is None:
            return None, node
        return node, node
    node = _first_applicable_branching(sequent)
    if node is not None:
        proof_children: List[ProofNode] = []
        attempt_children: List[ProofNode] = []
        for child_node in node.children:
            child_used = _copy_used_instantiations(used_instantiations)
            proof_child, attempt_child = _build_proof_and_attempt(child_node.sequent, deadline, child_used, depth + 1)
            proof_children.append(proof_child)
            attempt_children.append(attempt_child)
        node.children = attempt_children
        if any(child is None for child in proof_children):
            return None, node
        return node, node
    node = _instantiate_quantifier_with_existing_term(sequent, used_instantiations)
    if node is not None:
        proof_child, attempt_child = _build_proof_and_attempt(node.children[0].sequent, deadline, used_instantiations, depth + 1)
        node.children[0] = attempt_child
        if proof_child is None:
            return None, node
        return node, node
    node = _instantiate_quantifier_with_fresh_term(sequent, used_instantiations)
    if node is not None:
        proof_child, attempt_child = _build_proof_and_attempt(node.children[0].sequent, deadline, used_instantiations, depth + 1)
        node.children[0] = attempt_child
        if proof_child is None:
            return None, node
        return node, node
    failed_node = ProofNode(sequent=sequent, rule='fail', children=[])
    return None, failed_node


# def _build_proof(sequent: Sequent, deadline: float, used_instantiations: Optional[Dict[Tuple[int, str], Set[str]]] = None) -> Optional[ProofNode]:
#     return proof


# def apply_algorithm2_sequent(antecedent: List[Formula], succedent: List[Formula], timeout_seconds: float = 5.0) -> Union[ProofNode, str]:
#     sequent = Sequent(antecedent=antecedent.copy(), succedent=succedent.copy())
#     deadline = time.time() + timeout_seconds
#     proof = _build_proof(sequent, deadline)
#     if proof is None:
#         return 'unprovable'
#     return proof


# def apply_algorithm2(formula: Formula, timeout_seconds: float = 5.0) -> Union[ProofNode, str]:
#     return apply_algorithm2_sequent([], [formula], timeout_seconds=timeout_seconds)


# def apply_algorithm2_to_formulas(formulas: List[Formula], timeout_seconds: float = 5.0) -> Union[ProofNode, str]:
#     if not formulas:
#         return 'unprovable'
#     formula = formulas[0]
#     for next_formula in formulas[1:]:
#         formula = And(left=formula, right=next_formula)
#     return apply_algorithm2(formula, timeout_seconds=timeout_seconds)


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


if __name__ == '__main__':
    import argparse
    import sys
    from tptp_parser import FormulaEntry, parse_tptp_file
    from isabelle_parser import parse_isabelle_file

    parser = argparse.ArgumentParser(description='Apply Algorithm 2 to first-order logic formulas.')
    parser.add_argument('file', help='Path to the input file (.fof or .p)')
    parser.add_argument('--parser', choices=['tptp', 'isabelle'], default=None,
                        help='Parser type: tptp for TPTP .fof files, isabelle for .p files. '
                             'If not specified, inferred from file extension.')
    parser.add_argument('--timeout', type=float, default=5.0,
                        help='Timeout in seconds (default: 5.0)')
    parser.add_argument('--verbose', action='store_true', help='Print the attempted derivation tree, even for unprovable conjectures')

    args = parser.parse_args()

    path = args.file
    timeout = args.timeout
    verbose = args.verbose

    if args.parser == 'tptp' or (args.parser is None and not path.lower().endswith('.p')):
        entries = parse_tptp_file(path)
    else:
        entries = parse_isabelle_file(path)

    conjecture_positions = [(i, entry) for i, entry in enumerate(entries) if entry.role.lower() == 'conjecture']

    if not conjecture_positions:
        print('No conjectures found in the file.')
        sys.exit(0)

    last_conjecture_index = -1
    for conj_index, conjecture in conjecture_positions:
        axiom_entries = [entry for entry in entries[last_conjecture_index + 1:conj_index] if entry.role.lower() == 'axiom']
        axioms = [entry.formula for entry in axiom_entries]
        sequent = Sequent(antecedent=axioms.copy(), succedent=[conjecture.formula])
        try:
            proof, attempt = _build_proof_and_attempt(sequent, time.time() + timeout)
            if proof is not None:
                label = 'is provable'
            elif attempt.rule == 'recursion-limit':
                label = f'exceeded recursion limit {MAX_NODE_RECURSION} nodes'
            elif attempt.rule == 'timeout':
                label = 'timed out'
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
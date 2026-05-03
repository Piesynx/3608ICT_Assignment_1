%--------------------------------------------------------------------
% TPTP FOF Conjecture Set
% 75 conjectures with up to 3 axioms each
% Domains: propositional logic, arithmetic, set theory,
%          relations, graph theory, order theory, combinatorics
%--------------------------------------------------------------------

%====================================================================
% SECTION 1: PROPOSITIONAL / BOOLEAN LOGIC
%====================================================================

%--------------------------------------------------------------------
% Problem 001: Modus Ponens
%--------------------------------------------------------------------
fof(ax001_1, axiom, p).
fof(ax001_2, axiom, (p => q)).
fof(con001, conjecture, q).

%--------------------------------------------------------------------
% Problem 002: Hypothetical Syllogism
%--------------------------------------------------------------------
fof(ax002_1, axiom, (p => q)).
fof(ax002_2, axiom, (q => r)).
fof(con002, conjecture, (p => r)).

%--------------------------------------------------------------------
% Problem 003: Disjunctive Syllogism
%--------------------------------------------------------------------
fof(ax003_1, axiom, (p | q)).
fof(ax003_2, axiom, (~p)).
fof(con003, conjecture, q).

%--------------------------------------------------------------------
% Problem 004: Constructive Dilemma
%--------------------------------------------------------------------
fof(ax004_1, axiom, ((p => q) & (r => s))).
fof(ax004_2, axiom, (p | r)).
fof(con004, conjecture, (q | s)).

%--------------------------------------------------------------------
% Problem 005: De Morgan (conjunction)
%--------------------------------------------------------------------
fof(ax005_1, axiom, ~(p & q)).
fof(con005, conjecture, (~p | ~q)).

%--------------------------------------------------------------------
% Problem 006: De Morgan (disjunction)
%--------------------------------------------------------------------
fof(ax006_1, axiom, ~(p | q)).
fof(con006, conjecture, (~p & ~q)).

%--------------------------------------------------------------------
% Problem 007: Double Negation Elimination
%--------------------------------------------------------------------
fof(ax007_1, axiom, ~~p).
fof(con007, conjecture, p).

%--------------------------------------------------------------------
% Problem 008: Contrapositive
%--------------------------------------------------------------------
fof(ax008_1, axiom, (p => q)).
fof(con008, conjecture, (~q => ~p)).

%--------------------------------------------------------------------
% Problem 009: Biconditional forward
%--------------------------------------------------------------------
fof(ax009_1, axiom, (p <=> q)).
fof(ax009_2, axiom, p).
fof(con009, conjecture, q).

%--------------------------------------------------------------------
% Problem 010: Biconditional backward
%--------------------------------------------------------------------
fof(ax010_1, axiom, (p <=> q)).
fof(ax010_2, axiom, q).
fof(con010, conjecture, p).

%--------------------------------------------------------------------
% Problem 011: Law of Excluded Middle does not require axioms
%--------------------------------------------------------------------
fof(con011, conjecture, (p | ~p)).

%--------------------------------------------------------------------
% Problem 012: Absorption
%--------------------------------------------------------------------
fof(ax012_1, axiom, p).
fof(con012, conjecture, (p & (p | q))).

%--------------------------------------------------------------------
% Problem 013: Exportation (Currying)
%--------------------------------------------------------------------
fof(ax013_1, axiom, ((p & q) => r)).
fof(con013, conjecture, (p => (q => r))).

%--------------------------------------------------------------------
% Problem 014: Addition (Weakening left)
%--------------------------------------------------------------------
fof(ax014_1, axiom, p).
fof(con014, conjecture, (p | q)).

%--------------------------------------------------------------------
% Problem 015: Simplification (Conjunction elimination)
%--------------------------------------------------------------------
fof(ax015_1, axiom, (p & q)).
fof(con015, conjecture, p).

%====================================================================
% SECTION 2: FIRST-ORDER PREDICATE LOGIC
%====================================================================

%--------------------------------------------------------------------
% Problem 016: Universal Instantiation
%--------------------------------------------------------------------
fof(ax016_1, axiom, ![X] : mortal(X)).
fof(ax016_2, axiom, man(socrates)).
fof(con016, conjecture, mortal(socrates)).

%--------------------------------------------------------------------
% Problem 017: Existential Generalisation
%--------------------------------------------------------------------
fof(ax017_1, axiom, happy(alice)).
fof(con017, conjecture, ?[X] : happy(X)).

%--------------------------------------------------------------------
% Problem 018: Universal to Existential
%--------------------------------------------------------------------
fof(ax018_1, axiom, ![X] : (bird(X) => animal(X))).
fof(ax018_2, axiom, ?[X] : bird(X)).
fof(con018, conjecture, ?[X] : animal(X)).

%--------------------------------------------------------------------
% Problem 019: Transitivity of predicate
%--------------------------------------------------------------------
fof(ax019_1, axiom, ![X,Y,Z] : ((parent(X,Y) & parent(Y,Z)) => ancestor(X,Z))).
fof(ax019_2, axiom, parent(alice, bob)).
fof(ax019_3, axiom, parent(bob, carol)).
fof(con019, conjecture, ancestor(alice, carol)).

%--------------------------------------------------------------------
% Problem 020: Function application
%--------------------------------------------------------------------
fof(ax020_1, axiom, ![X] : (human(X) => mortal(f(X)))).
fof(ax020_2, axiom, human(plato)).
fof(con020, conjecture, mortal(f(plato))).

%--------------------------------------------------------------------
% Problem 021: Prenex – pushing quantifier inside negation
%--------------------------------------------------------------------
fof(ax021_1, axiom, ~(![X] : p(X))).
fof(con021, conjecture, ?[X] : ~p(X)).

%--------------------------------------------------------------------
% Problem 022: Prenex – pulling existential out
%--------------------------------------------------------------------
fof(ax022_1, axiom, ?[X] : (q(X) & r(X))).
fof(con022, conjecture, (?[X] : q(X))).

%--------------------------------------------------------------------
% Problem 023: Russell-style: non-self-membership vacuous
%--------------------------------------------------------------------
fof(ax023_1, axiom, ![X] : ~elem(X,X)).
fof(ax023_2, axiom, elem(a,s)).
fof(con023, conjecture, ~elem(s,s)).

%--------------------------------------------------------------------
% Problem 024: Leibniz equality – substitution
%--------------------------------------------------------------------
%fof(ax024_1, axiom, a = b).
%fof(ax024_2, axiom, p(a)).
%fof(con024, conjecture, p(b)).

%--------------------------------------------------------------------
% Problem 025: Symmetry of equality
%--------------------------------------------------------------------
%fof(ax025_1, axiom, a = b).
%fof(con025, conjecture, b = a).

%====================================================================
% SECTION 3: ARITHMETIC / NUMBER THEORY
%====================================================================

%--------------------------------------------------------------------
% Problem 026: Zero is not a successor
%--------------------------------------------------------------------
%fof(ax026_1, axiom, ![X] : (s(X) != zero)).
%fof(con026, conjecture, s(zero) != zero).

%--------------------------------------------------------------------
% Problem 027: Successor is injective
%--------------------------------------------------------------------
%fof(ax027_1, axiom, ![X,Y] : ((s(X) = s(Y)) => (X = Y))).
%fof(ax027_2, axiom, s(a) = s(b)).
%fof(con027, conjecture, a = b).
%
%--------------------------------------------------------------------
% Problem 028: Addition identity (left)
%--------------------------------------------------------------------
%fof(ax028_1, axiom, ![X] : add(zero, X) = X).
%fof(con028, conjecture, add(zero, s(zero)) = s(zero)).

%--------------------------------------------------------------------
% Problem 029: Addition with successor
%--------------------------------------------------------------------
%fof(ax029_1, axiom, ![X,Y] : add(s(X), Y) = s(add(X, Y))).
%fof(ax029_2, axiom, ![X] : add(zero, X) = X).
%fof(con029, conjecture, add(s(zero), s(zero)) = s(s(zero))).

%--------------------------------------------------------------------
% Problem 030: Multiplication by zero
%--------------------------------------------------------------------
%fof(ax030_1, axiom, ![X] : mul(zero, X) = zero).
%fof(con030, conjecture, mul(zero, s(s(zero))) = zero).

%--------------------------------------------------------------------
% Problem 031: Multiplication identity
%--------------------------------------------------------------------
%fof(ax031_1, axiom, ![X] : mul(s(zero), X) = X).
%fof(con031, conjecture, mul(s(zero), s(s(zero))) = s(s(zero))).


%--------------------------------------------------------------------
% Problem 033: Strictly less than is irreflexive
%--------------------------------------------------------------------
fof(ax033_1, axiom, ![X] : ~lt(X, X)).
fof(con033, conjecture, ~lt(a, a)).

%--------------------------------------------------------------------
% Problem 034: lt transitive
%--------------------------------------------------------------------
fof(ax034_1, axiom, ![X,Y,Z] : ((lt(X,Y) & lt(Y,Z)) => lt(X,Z))).
fof(ax034_2, axiom, lt(a, b)).
fof(ax034_3, axiom, lt(b, c)).
fof(con034, conjecture, lt(a, c)).

%--------------------------------------------------------------------
% Problem 035: Divisibility is reflexive
%--------------------------------------------------------------------
fof(ax035_1, axiom, ![X] : divides(X, X)).
fof(con035, conjecture, divides(k, k)).

%====================================================================
% SECTION 4: SET THEORY
%====================================================================

%--------------------------------------------------------------------
% Problem 036: Subset reflexivity
%--------------------------------------------------------------------
fof(ax036_1, axiom, ![X,S] : (in(X,S) => in(X,S))).
fof(ax036_2, axiom, ![A,B] : (subset(A,B) <=> (![X] : (in(X,A) => in(X,B))))).
fof(con036, conjecture, subset(s, s)).

%--------------------------------------------------------------------
% Problem 037: Subset transitivity
%--------------------------------------------------------------------
fof(ax037_1, axiom, ![A,B,C] : ((subset(A,B) & subset(B,C)) => subset(A,C))).
fof(ax037_2, axiom, subset(a, b)).
fof(ax037_3, axiom, subset(b, c)).
fof(con037, conjecture, subset(a, c)).

%--------------------------------------------------------------------
% Problem 038: Empty set has no members
%--------------------------------------------------------------------
fof(ax038_1, axiom, ![X] : ~in(X, empty)).
fof(con038, conjecture, ~in(a, empty)).

%--------------------------------------------------------------------
% Problem 039: Union membership (left)
%--------------------------------------------------------------------
fof(ax039_1, axiom, ![X,A,B] : (in(X,A) => in(X, union(A,B)))).
fof(ax039_2, axiom, in(x, a)).
fof(con039, conjecture, in(x, union(a, b))).

%--------------------------------------------------------------------
% Problem 040: Intersection membership
%--------------------------------------------------------------------
fof(ax040_1, axiom, ![X,A,B] : (in(X, inter(A,B)) <=> (in(X,A) & in(X,B)))).
fof(ax040_2, axiom, in(x, a)).
fof(ax040_3, axiom, in(x, b)).
fof(con040, conjecture, in(x, inter(a, b))).

%--------------------------------------------------------------------
% Problem 041: Complement membership
%--------------------------------------------------------------------
fof(ax041_1, axiom, ![X,A] : (in(X, comp(A)) <=> ~in(X, A))).
fof(ax041_2, axiom, ~in(x, a)).
fof(con041, conjecture, in(x, comp(a))).

%--------------------------------------------------------------------
% Problem 042: Power set contains empty set
%--------------------------------------------------------------------
fof(ax042_1, axiom, ![A,B] : (subset(A,B) => in(A, power(B)))).
fof(ax042_2, axiom, ![A] : (![X] : ~in(X, empty))).
fof(ax042_3, axiom, ![B,X] : ((![Y] : ~in(Y, X)) => subset(X, B))).
fof(con042, conjecture, in(empty, power(s))).

%--------------------------------------------------------------------
% Problem 043: Set equality from mutual subset
%--------------------------------------------------------------------
%fof(ax043_1, axiom, ![A,B] : ((subset(A,B) & subset(B,A)) => A = B)).
%fof(ax043_2, axiom, subset(a, b)).
%fof(ax043_3, axiom, subset(b, a)).
%fof(con043, conjecture, a = b).

%--------------------------------------------------------------------
% Problem 044: Union is commutative (membership)
%--------------------------------------------------------------------
fof(ax044_1, axiom, ![X,A,B] : (in(X, union(A,B)) <=> (in(X,A) | in(X,B)))).
fof(ax044_2, axiom, in(x, union(a, b))).
fof(con044, conjecture, in(x, union(b, a))).

%--------------------------------------------------------------------
% Problem 045: Singleton membership
%--------------------------------------------------------------------
%fof(ax045_1, axiom, ![X,Y] : (in(X, singleton(Y)) <=> X = Y)).
%fof(con045, conjecture, in(a, singleton(a))).

%====================================================================
% SECTION 5: RELATIONS
%====================================================================

%--------------------------------------------------------------------
% Problem 046: Reflexive relation
%--------------------------------------------------------------------
fof(ax046_1, axiom, ![X] : rel(X, X)).
fof(con046, conjecture, rel(a, a)).

%--------------------------------------------------------------------
% Problem 047: Symmetric relation
%--------------------------------------------------------------------
fof(ax047_1, axiom, ![X,Y] : (rel(X,Y) => rel(Y,X))).
fof(ax047_2, axiom, rel(a, b)).
fof(con047, conjecture, rel(b, a)).

%--------------------------------------------------------------------
% Problem 048: Transitive closure one step
%--------------------------------------------------------------------
fof(ax048_1, axiom, ![X,Y] : (edge(X,Y) => reach(X,Y))).
fof(ax048_2, axiom, ![X,Y,Z] : ((reach(X,Y) & reach(Y,Z)) => reach(X,Z))).
fof(ax048_3, axiom, edge(a, b)).
fof(con048, conjecture, reach(a, b)).

%--------------------------------------------------------------------
% Problem 049: Transitive closure two steps
%--------------------------------------------------------------------
fof(ax049_1, axiom, ![X,Y] : (edge(X,Y) => reach(X,Y))).
fof(ax049_2, axiom, ![X,Y,Z] : ((reach(X,Y) & reach(Y,Z)) => reach(X,Z))).
fof(ax049_3, axiom, (edge(a,b) & edge(b,c))).
fof(con049, conjecture, reach(a, c)).

%--------------------------------------------------------------------
% Problem 050: Equivalence relation: reflexive
%--------------------------------------------------------------------
fof(ax050_1, axiom, ![X] : equiv(X,X)).
fof(con050, conjecture, equiv(x, x)).

%--------------------------------------------------------------------
% Problem 051: Equivalence relation: symmetric
%--------------------------------------------------------------------
fof(ax051_1, axiom, ![X,Y] : (equiv(X,Y) => equiv(Y,X))).
fof(ax051_2, axiom, equiv(a, b)).
fof(con051, conjecture, equiv(b, a)).

%--------------------------------------------------------------------
% Problem 052: Equivalence relation: transitive
%--------------------------------------------------------------------
fof(ax052_1, axiom, ![X,Y,Z] : ((equiv(X,Y) & equiv(Y,Z)) => equiv(X,Z))).
fof(ax052_2, axiom, equiv(a, b)).
fof(ax052_3, axiom, equiv(b, c)).
fof(con052, conjecture, equiv(a, c)).

%--------------------------------------------------------------------
% Problem 053: Antisymmetric and equal
%--------------------------------------------------------------------
%fof(ax053_1, axiom, ![X,Y] : ((leq(X,Y) & leq(Y,X)) => X = Y)).
%fof(ax053_2, axiom, leq(a, b)).
%fof(ax053_3, axiom, leq(b, a)).
%fof(con053, conjecture, a = b).

%--------------------------------------------------------------------
% Problem 054: Partial order – no strict descent loop of length 2
%--------------------------------------------------------------------
fof(ax054_1, axiom, ![X,Y] : (lt(X,Y) => ~lt(Y,X))).
fof(ax054_2, axiom, lt(a, b)).
fof(con054, conjecture, ~lt(b, a)).

%--------------------------------------------------------------------
% Problem 055: Total order: comparable elements
%--------------------------------------------------------------------
fof(ax055_1, axiom, ![X,Y] : (leq(X,Y) | leq(Y,X))).
fof(con055, conjecture, (leq(a, b) | leq(b, a))).

%====================================================================
% SECTION 6: GRAPH THEORY
%====================================================================

%--------------------------------------------------------------------
% Problem 056: Undirected edge symmetry
%--------------------------------------------------------------------
fof(ax056_1, axiom, ![X,Y] : (edge(X,Y) => edge(Y,X))).
fof(ax056_2, axiom, edge(u, v)).
fof(con056, conjecture, edge(v, u)).

%--------------------------------------------------------------------
% Problem 057: Path of length 2
%--------------------------------------------------------------------
fof(ax057_1, axiom, ![X,Y,Z] : ((edge(X,Y) & edge(Y,Z)) => path2(X,Z))).
fof(ax057_2, axiom, edge(a, b)).
fof(ax057_3, axiom, edge(b, c)).
fof(con057, conjecture, path2(a, c)).

%--------------------------------------------------------------------
% Problem 058: Vertex in edge is in graph
%--------------------------------------------------------------------
fof(ax058_1, axiom, ![X,Y] : (edge(X,Y) => (vertex(X) & vertex(Y)))).
fof(ax058_2, axiom, edge(p, q)).
fof(con058, conjecture, vertex(p)).

%--------------------------------------------------------------------
% Problem 059: No self-loop in simple graph
%--------------------------------------------------------------------
fof(ax059_1, axiom, ![X] : ~edge(X, X)).
fof(con059, conjecture, ~edge(v, v)).

%--------------------------------------------------------------------
% Problem 060: Reachability is reflexive for vertices
%--------------------------------------------------------------------
fof(ax060_1, axiom, ![X] : (vertex(X) => reach(X,X))).
fof(ax060_2, axiom, vertex(a)).
fof(con060, conjecture, reach(a, a)).

%====================================================================
% SECTION 7: FUNCTIONS AND MAPPINGS
%====================================================================

%--------------------------------------------------------------------
% Problem 061: Injective: equals input when output equal
%--------------------------------------------------------------------
%fof(ax061_1, axiom, ![X,Y] : ((f(X) = f(Y)) => X = Y)).
%fof(ax061_2, axiom, f(a) = f(b)).
%fof(con061, conjecture, a = b).

%--------------------------------------------------------------------
% Problem 062: Surjective: every element is in range
%--------------------------------------------------------------------
%fof(ax062_1, axiom, ![Y] : ?[X] : f(X) = Y).
%fof(con062, conjecture, ?[X] : f(X) = c).

%--------------------------------------------------------------------
% Problem 063: Fixed point exists (stated)
%--------------------------------------------------------------------
%fof(ax063_1, axiom, ?[X] : f(X) = X).
%fof(con063, conjecture, ?[X] : f(X) = X).

%--------------------------------------------------------------------
% Problem 064: Function composition associativity (pointwise)
%--------------------------------------------------------------------
%fof(ax064_1, axiom, ![X] : h(g(f(X))) = h(g(f(X)))).
%fof(con064, conjecture, h(g(f(a))) = h(g(f(a)))).

%--------------------------------------------------------------------
% Problem 065: Identity function
%--------------------------------------------------------------------
%fof(ax065_1, axiom, ![X] : id(X) = X).
%fof(con065, conjecture, id(a) = a).

%====================================================================
% SECTION 8: ORDER THEORY
%====================================================================

%--------------------------------------------------------------------
% Problem 066: Least element is leq to all
%--------------------------------------------------------------------
fof(ax066_1, axiom, ![X] : leq(bot, X)).
fof(con066, conjecture, leq(bot, a)).

%--------------------------------------------------------------------
% Problem 067: Greatest element is leq-above all
%--------------------------------------------------------------------
fof(ax067_1, axiom, ![X] : leq(X, top)).
fof(con067, conjecture, leq(a, top)).

%--------------------------------------------------------------------
% Problem 068: Lower bound definition
%--------------------------------------------------------------------
fof(ax068_1, axiom, ![X] : (lb(X) <=> (leq(X,a) & leq(X,b)))).
fof(ax068_2, axiom, leq(c, a)).
fof(ax068_3, axiom, leq(c, b)).
fof(con068, conjecture, lb(c)).

%--------------------------------------------------------------------
% Problem 069: Upper bound definition
%--------------------------------------------------------------------
fof(ax069_1, axiom, ![X] : (ub(X) <=> (leq(a,X) & leq(b,X)))).
fof(ax069_2, axiom, leq(a, c)).
fof(ax069_3, axiom, leq(b, c)).
fof(con069, conjecture, ub(c)).

%--------------------------------------------------------------------
% Problem 070: Meet (infimum) is a lower bound
%--------------------------------------------------------------------
%fof(ax070_1, axiom, ![X,Y] : (leq(meet(X,Y), X) & leq(meet(X,Y), Y))).
%fof(con070, conjecture, leq(meet(a,b), a)).

%====================================================================
% SECTION 9: MODALITY AND KNOWLEDGE (ENCODED IN FOF)
%====================================================================

%--------------------------------------------------------------------
% Problem 071: Knowledge axiom T (what is known is true)
%--------------------------------------------------------------------
%fof(ax071_1, axiom, ![P] : (knows(agent, P) => P)).
%fof(ax071_2, axiom, knows(agent, happy(alice))).
%fof(con071, conjecture, happy(alice)).

%--------------------------------------------------------------------
% Problem 072: Belief closed under implication
%--------------------------------------------------------------------
%fof(ax072_1, axiom, believes(agent, (p => q))).
%fof(ax072_2, axiom, believes(agent, p)).
%fof(ax072_3, axiom, ![A,X,Y] : ((believes(A, (X => Y)) & believes(A, X)) => believes(A, Y))).
%fof(con072, conjecture, believes(agent, q)).

%--------------------------------------------------------------------
% Problem 073: Common knowledge (two agents agree)
%--------------------------------------------------------------------
fof(ax073_1, axiom, knows(alice, phi)).
fof(ax073_2, axiom, knows(bob, phi)).
fof(ax073_3, axiom, ![X] : ((knows(alice,X) & knows(bob,X)) => common(X))).
fof(con073, conjecture, common(phi)).

%====================================================================
% SECTION 10: MISCELLANEOUS / COMBINATORIAL
%====================================================================

%--------------------------------------------------------------------
% Problem 074: Pigeonhole (2 pigeons, 1 hole)
%--------------------------------------------------------------------
%fof(ax074_1, axiom, in_hole(pigeon1, hole1) | in_hole(pigeon1, hole2)).
%fof(ax074_2, axiom, in_hole(pigeon2, hole1) | in_hole(pigeon2, hole2)).
%fof(ax074_3, axiom, ![X,Y] : ((in_hole(X,hole1) & in_hole(Y,hole1)) => X = Y)).
%fof(con074, conjecture, in_hole(pigeon1, hole2) | in_hole(pigeon2, hole2)).

%--------------------------------------------------------------------
% Problem 075: Colorability: if not red then blue
%--------------------------------------------------------------------
fof(ax075_1, axiom, ![X] : (vertex(X) => (color(X, red) | color(X, blue)))).
fof(ax075_2, axiom, vertex(v1)).
fof(ax075_3, axiom, ~color(v1, red)).
fof(con075, conjecture, color(v1, blue)).

%====================================================================
% END OF FILE
%====================================================================

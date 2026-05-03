%--------------------------------------------------------------------------
% File     : LCL421+1 : TPTP v9.2.1. Released v9.1.0.
% Domain   : Logic Calculi (Many valued sentential)
% Problem  : Prove KA1 from MV1--MV4
% Version  : [EF+02] axioms.
% English  :

% Refs     : [FH01]  Fitelson and Harris (2001), Distributivity in LN0 and
%          : [Ver01] Veroff (2001), A Strategy for Proving Theorems in Many
%          : [EF+02] Ernst et al. (2002), More First-order Test Problems in
%          : [RW+23] Rawson et al. (2023), Lemmas: Generation, Selection, A
% Source   : [EF+02]
% Names    : mv-dist-star [EF+02]

% Status   : Theorem
% Rating   : 1.00 v9.1.0
% Syntax   : Number of formulae    :    6 (   5 unt;   0 def)
%            Number of atoms       :    8 (   0 equ)
%            Maximal formula atoms :    3 (   1 avg)
%            Number of connectives :    2 (   0   ~;   0   |;   1   &)
%                                         (   0 <=>;   1  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    5 (   3 avg)
%            Maximal term depth    :    8 (   2 avg)
%            Number of predicates  :    1 (   1 usr;   0 prp; 1-1 aty)
%            Number of functors    :    5 (   5 usr;   3 con; 0-2 aty)
%            Number of variables   :   11 (  11   !;   0   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%--------------------------------------------------------------------------
%----Condensed detachment
fof(condensed_detachment,axiom,
    ! [A,B] :
      ( ( is_a_theorem(implies(A,B))
        & is_a_theorem(A) )
     => is_a_theorem(B) ) ).

fof(mv1,axiom,
    ! [A,B] : is_a_theorem(implies(A,implies(B,A))) ).

fof(mv2,axiom,
    ! [A,B,C] : is_a_theorem(implies(implies(A,B),implies(implies(B,C),implies(A,C)))) ).

fof(mv3,axiom,
    ! [A,B] : is_a_theorem(implies(implies(implies(A,B),B),implies(implies(B,A),A))) ).

fof(mv4,axiom,
    ! [A,B] : is_a_theorem(implies(implies(not(A),not(B)),implies(B,A))) ).

%----KA1
fof(prove_ka1,conjecture,
    is_a_theorem(implies(not(implies(implies(not(a),not(implies(implies(b,c),c))),not(implies(implies(b,c),c)))),implies(implies(not(implies(implies(not(a),not(b)),not(b))),not(implies(implies(not(a),not(c)),not(c)))),not(implies(implies(not(a),not(c)),not(c)))))) ).

%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% File     : LCL375+1 : TPTP v9.2.1. Released v9.1.0.
% Domain   : Logic Calculi (Implication/Negation 2 valued sentential)
% Problem  : CN-32 depends on the Lukasiewicz system
% Version  : [Wos96] axioms.
% English  : An axiomatisation of the Implication/Negation 2 valued
%            sentential calculus is {CN-1,CN-2,CN-3} by Lukasiewicz.
%            Show that CN-32 depends on the Lukasiewicz system.

% Refs     : [Wos96] Wos (1996), Combining Resonance with Heat
%          : [RW+23] Rawson et al. (2023), Lemmas: Generation, Selection, A
% Source   : [Wos96]
% Names    : thesis_32 [Wos96]

% Status   : Theorem
% Rating   : 0.80 v9.1.0
% Syntax   : Number of formulae    :    5 (   4 unt;   0 def)
%            Number of atoms       :    7 (   0 equ)
%            Maximal formula atoms :    3 (   1 avg)
%            Number of connectives :    2 (   0   ~;   0   |;   1   &)
%                                         (   0 <=>;   1  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    5 (   3 avg)
%            Maximal term depth    :    5 (   2 avg)
%            Number of predicates  :    1 (   1 usr;   0 prp; 1-1 aty)
%            Number of functors    :    6 (   6 usr;   4 con; 0-2 aty)
%            Number of variables   :    8 (   8   !;   0   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%--------------------------------------------------------------------------
fof(condensed_detachment,axiom,
    ! [X,Y] :
      ( ( is_a_theorem(implies(X,Y))
        & is_a_theorem(X) )
     => is_a_theorem(Y) ) ).

fof(cn_1,axiom,
    ! [X,Y,Z] : is_a_theorem(implies(implies(X,Y),implies(implies(Y,Z),implies(X,Z)))) ).

fof(cn_2,axiom,
    ! [X] : is_a_theorem(implies(implies(not(X),X),X)) ).

fof(cn_3,axiom,
    ! [X,Y] : is_a_theorem(implies(X,implies(not(X),Y))) ).

fof(prove_cn_32,conjecture,
    is_a_theorem(implies(implies(implies(x,y),z),implies(implies(x,u),implies(implies(u,z),z)))) ).

%--------------------------------------------------------------------------

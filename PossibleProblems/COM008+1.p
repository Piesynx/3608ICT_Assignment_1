%------------------------------------------------------------------------------
% File     : COM008+1 : TPTP v9.2.1. Released v3.2.0.
% Domain   : Computing Theory
% Problem  : Induction step in Newman's Lemma
% Version  : Especial > Reduced > Especial.
% English  :

% Refs     : [Bez05] Bezem (2005), Email to Geoff Sutcliffe
% Source   : [Bez05]
% Names    : nl [Bez05]

% Status   : Theorem
% Rating   : 0.35 v9.1.0, 0.27 v9.0.0, 0.19 v8.2.0, 0.13 v8.1.0, 0.29 v7.5.0, 0.43 v7.4.0, 0.12 v7.3.0, 0.14 v7.2.0, 0.17 v7.1.0, 0.25 v7.0.0, 0.29 v6.3.0, 0.31 v6.2.0, 0.36 v6.1.0, 0.56 v6.0.0, 0.50 v5.5.0, 0.62 v5.4.0, 0.61 v5.3.0, 0.70 v5.2.0, 0.43 v5.0.0, 0.60 v4.1.0, 0.61 v4.0.1, 0.58 v4.0.0, 0.60 v3.7.0, 0.00 v3.5.0, 0.25 v3.4.0, 0.58 v3.3.0, 0.67 v3.2.0

% Syntax   : Number of formulae    :   11 (   2 unt;   0 def)
%            Number of atoms       :   29 (   0 equ)
%            Maximal formula atoms :    5 (   2 avg)
%            Number of connectives :   18 (   0   ~;   1   |;   9   &)
%                                         (   0 <=>;   8  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    7 (   4 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    4 (   4 usr;   1 prp; 0-2 aty)
%            Number of functors    :    3 (   3 usr;   3 con; 0-0 aty)
%            Number of variables   :   22 (  19   !;   3   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%------------------------------------------------------------------------------
fof(found,axiom,
    ! [A] :
      ( ( transitive_reflexive_rewrite(b,A)
        & transitive_reflexive_rewrite(c,A) )
     => goal ) ).

fof(assumption,axiom,
    ( transitive_reflexive_rewrite(a,b)
    & transitive_reflexive_rewrite(a,c) ) ).

fof(reflexivity,axiom,
    ! [A] : equalish(A,A) ).

fof(symmetry,axiom,
    ! [A,B] :
      ( equalish(A,B)
     => equalish(B,A) ) ).

fof(equality_in_transitive_reflexive_rewrite,axiom,
    ! [A,B] :
      ( equalish(A,B)
     => transitive_reflexive_rewrite(A,B) ) ).

fof(rewrite_in_transitive_reflexive_rewrite,axiom,
    ! [A,B] :
      ( rewrite(A,B)
     => transitive_reflexive_rewrite(A,B) ) ).

fof(transitivity_of_transitive_reflexive_rewrite,axiom,
    ! [A,B,C] :
      ( ( transitive_reflexive_rewrite(A,B)
        & transitive_reflexive_rewrite(B,C) )
     => transitive_reflexive_rewrite(A,C) ) ).

fof(lo_cfl,axiom,
    ! [A,B,C] :
      ( ( rewrite(A,B)
        & rewrite(A,C) )
     => ? [D] :
          ( transitive_reflexive_rewrite(B,D)
          & transitive_reflexive_rewrite(C,D) ) ) ).

fof(ih_cfl,axiom,
    ! [A,B,C] :
      ( ( rewrite(a,A)
        & transitive_reflexive_rewrite(A,B)
        & transitive_reflexive_rewrite(A,C) )
     => ? [D] :
          ( transitive_reflexive_rewrite(B,D)
          & transitive_reflexive_rewrite(C,D) ) ) ).

fof(equalish_or_rewrite,axiom,
    ! [A,B] :
      ( transitive_reflexive_rewrite(A,B)
     => ( equalish(A,B)
        | ? [C] :
            ( rewrite(A,C)
            & transitive_reflexive_rewrite(C,B) ) ) ) ).

fof(goal_to_be_proved,conjecture,
    goal ).

%------------------------------------------------------------------------------

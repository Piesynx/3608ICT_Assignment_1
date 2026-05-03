%------------------------------------------------------------------------------
% File     : SEV515+1 : TPTP v9.2.1. Released v7.0.0.
% Domain   : Set Theory
% Problem  : The conclusion of Russell's paradox
% Version  : Especial.
% English  :

% Refs     : [Pel16] Pelletier (2016), Email to Geoff Sutcliffe
%          : [PSH17] Pelletier et al. (2017), Automated Reasoning for the D
% Source   : [Pel16]
% Names    : 15 [PSH17]
%          : n01.p [Pel16]

% Status   : Theorem
% Rating   : 0.05 v9.1.0, 0.07 v9.0.0, 0.00 v7.0.0
% Syntax   : Number of formulae    :    5 (   0 unt;   0 def)
%            Number of atoms       :   36 (   0 equ)
%            Maximal formula atoms :   24 (   7 avg)
%            Number of connectives :   35 (   4   ~;  14   |;  14   &)
%                                         (   3 <=>;   0  =>;   0  <=;   0 <~>)
%            Maximal formula depth :   11 (   7 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    5 (   5 usr;   0 prp; 2-2 aty)
%            Number of functors    :    0 (   0 usr;   0 con; --- aty)
%            Number of variables   :   15 (  10   !;   5   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments : Translated from RM3 using the truth evaluation approach [PSH17].
%------------------------------------------------------------------------------
fof(nc1,conjecture,
    ( ! [A] :
      ? [B] :
        ( ( g_true_only(B,A)
          & ( g_both(B,B)
            | g_true_only(B,B) ) )
        | ( g_both(B,A)
          & ( g_false_only(B,B)
            | g_true_only(B,B) ) )
        | ( g_false_only(B,A)
          & ( g_false_only(B,B)
            | g_both(B,B) ) ) )
    | ( ? [A] :
          ( ? [B] :
              ( g_both(B,A)
              & g_both(B,B) )
          & ~ ? [B] :
                ( ( g_true_only(B,A)
                  & ( g_both(B,B)
                    | g_true_only(B,B) ) )
                | ( g_both(B,A)
                  & ( g_false_only(B,B)
                    | g_true_only(B,B) ) )
                | ( g_false_only(B,A)
                  & ( g_false_only(B,B)
                    | g_both(B,B) ) ) ) )
      & ~ ? [A] :
          ! [B] :
            ( ( g_true_only(B,A)
              & g_false_only(B,B) )
            | ( g_false_only(B,A)
              & g_true_only(B,B) ) ) ) ) ).

fof(true_only_g,axiom,
    ! [X_2,X_1] :
      ( g_true_only(X_2,X_1)
    <=> ( g_true(X_2,X_1)
        & ~ g_false(X_2,X_1) ) ) ).

fof(both_g,axiom,
    ! [X_2,X_1] :
      ( g_both(X_2,X_1)
    <=> ( g_true(X_2,X_1)
        & g_false(X_2,X_1) ) ) ).

fof(false_only_g,axiom,
    ! [X_2,X_1] :
      ( g_false_only(X_2,X_1)
    <=> ( g_false(X_2,X_1)
        & ~ g_true(X_2,X_1) ) ) ).

fof(exhaustion_g,axiom,
    ! [X_2,X_1] :
      ( g_true_only(X_2,X_1)
      | g_both(X_2,X_1)
      | g_false_only(X_2,X_1) ) ).

%------------------------------------------------------------------------------

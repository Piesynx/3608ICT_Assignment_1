%------------------------------------------------------------------------------
% File     : MSC012+1 : TPTP v9.2.1. Released v3.2.0.
% Domain   : Miscellaneous
% Problem  : A serial and transitive relation inconsistent for non-empty domain
% Version  : Especial.
% English  :

% Refs     : [Bez05] Bezem (2005), Email to Geoff Sutcliffe
% Source   : [Bez05]
% Names    : ser [Bez05]

% Status   : Theorem
% Rating   : 0.05 v9.1.0, 0.13 v9.0.0, 0.00 v6.3.0, 0.08 v6.2.0, 0.00 v6.1.0, 0.04 v6.0.0, 0.25 v5.5.0, 0.12 v5.4.0, 0.09 v5.3.0, 0.17 v5.2.0, 0.07 v5.0.0, 0.10 v4.1.0, 0.11 v4.0.1, 0.16 v4.0.0, 0.15 v3.7.0, 0.33 v3.5.0, 0.12 v3.4.0, 0.08 v3.3.0, 0.00 v3.2.0

% Syntax   : Number of formulae    :    5 (   2 unt;   0 def)
%            Number of atoms       :   12 (   0 equ)
%            Maximal formula atoms :    4 (   2 avg)
%            Number of connectives :    7 (   0   ~;   1   |;   4   &)
%                                         (   0 <=>;   2  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    6 (   4 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    3 (   3 usr;   1 prp; 0-2 aty)
%            Number of functors    :    0 (   0 usr;   0 con; --- aty)
%            Number of variables   :    9 (   7   !;   2   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%------------------------------------------------------------------------------
fof(left_to_right,axiom,
    ! [A,B] :
      ( ( p(A)
        & less(A,B)
        & p(B) )
     => goal ) ).

fof(right_to_left,axiom,
    ! [A] :
      ( p(A)
      | ? [B] :
          ( less(A,B)
          & p(B) ) ) ).

fof(transitive_less,axiom,
    ! [A,B,C] :
      ( ( less(A,B)
        & less(B,C) )
     => less(A,C) ) ).

fof(serial_less,axiom,
    ! [A] :
    ? [B] : less(A,B) ).

fof(goal_to_be_proved,conjecture,
    goal ).

%------------------------------------------------------------------------------

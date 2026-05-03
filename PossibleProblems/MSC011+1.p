%------------------------------------------------------------------------------
% File     : MSC011+1 : TPTP v9.2.1. Released v3.2.0.
% Domain   : Miscellaneous
% Problem  : Drinker paradox
% Version  : Especial.
% English  :

% Refs     : [Bez05] Bezem (2005), Email to Geoff Sutcliffe
% Source   : [Bez05]
% Names    : drinker [Bez05]

% Status   : Theorem
% Rating   : 0.00 v5.3.0, 0.09 v5.2.0, 0.00 v3.2.0

% Syntax   : Number of formulae    :    4 (   1 unt;   0 def)
%            Number of atoms       :    8 (   0 equ)
%            Maximal formula atoms :    3 (   2 avg)
%            Number of connectives :    4 (   0   ~;   0   |;   2   &)
%                                         (   0 <=>;   2  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    4 (   3 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    4 (   4 usr;   2 prp; 0-1 aty)
%            Number of functors    :    0 (   0 usr;   0 con; --- aty)
%            Number of variables   :    3 (   2   !;   1   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%------------------------------------------------------------------------------
fof(d_cons,axiom,
    ! [A] :
      ( ( drunk(A)
        & not_drunk(A) )
     => goal ) ).

fof(neg_phi,axiom,
    ! [A] :
      ( drunk(A)
      & neg_psi ) ).

fof(neg_psi_ax,axiom,
    ( neg_psi
   => ? [A] : not_drunk(A) ) ).

fof(goal_to_be_proved,conjecture,
    goal ).

%------------------------------------------------------------------------------

%--------------------------------------------------------------------------
% File     : SET045+1 : TPTP v9.2.1. Released v2.0.0.
% Domain   : Set Theory
% Problem  : No Universal Set
% Version  : Especial.
% English  : The restricted comprehension axiom says : given a set
%            z, there is a set all of whose members are drawn from z and
%            which satisfy some property. If there were a universal set,
%            then the Russell set could be formed, using this axiom.
%            So given the appropriate instance of this axiom, there
%            is no universal set.

% Refs     : [KM64]  Kalish & Montegue (1964), Logic: Techniques of Formal
%          : [Pel86] Pelletier (1986), Seventy-five Problems for Testing Au
%          : [Hah94] Haehnle (1994), Email to G. Sutcliffe
% Source   : [Hah94]
% Names    : Pelletier 41 [Pel86]

% Status   : Theorem
% Rating   : 0.05 v9.1.0, 0.07 v9.0.0, 0.06 v8.2.0, 0.00 v6.1.0, 0.04 v6.0.0, 0.25 v5.5.0, 0.04 v5.3.0, 0.17 v5.2.0, 0.00 v3.3.0, 0.11 v3.1.0, 0.00 v2.1.0
% Syntax   : Number of formulae    :    2 (   1 unt;   0 def)
%            Number of atoms       :    4 (   0 equ)
%            Maximal formula atoms :    3 (   2 avg)
%            Number of connectives :    4 (   2   ~;   0   |;   1   &)
%                                         (   1 <=>;   0  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    7 (   6 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    1 (   1 usr;   0 prp; 2-2 aty)
%            Number of functors    :    0 (   0 usr;   0 con; --- aty)
%            Number of variables   :    5 (   3   !;   2   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%--------------------------------------------------------------------------
fof(pel41_1,axiom,
    ! [Z] :
    ? [Y] :
    ! [X] :
      ( element(X,Y)
    <=> ( element(X,Z)
        & ~ element(X,X) ) ) ).

fof(pel41,conjecture,
    ~ ? [Z] :
      ! [X] : element(X,Z) ).

%--------------------------------------------------------------------------

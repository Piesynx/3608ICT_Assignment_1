%--------------------------------------------------------------------------
% File     : SET046+1 : TPTP v9.2.1. Released v2.0.0.
% Domain   : Set Theory
% Problem  : No set of non-circular sets
% Version  : Especial.
% English  : A set is circular if it is a member of another set which
%            in turn is a member of the orginal. Intuitively all sets are
%            non-circular. Prove there is no set of non-circular sets.

% Refs     : [KM64]  Kalish & Montegue (1964), Logic: Techniques of Formal
%          : [Pel86] Pelletier (1986), Seventy-five Problems for Testing Au
%          : [Hah94] Haehnle (1994), Email to G. Sutcliffe
% Source   : [Hah94]
% Names    : Pelletier 42 [Pel86]

% Status   : Theorem
% Rating   : 0.00 v5.3.0, 0.09 v5.2.0, 0.00 v2.1.0
% Syntax   : Number of formulae    :    1 (   0 unt;   0 def)
%            Number of atoms       :    3 (   0 equ)
%            Maximal formula atoms :    3 (   3 avg)
%            Number of connectives :    4 (   2   ~;   0   |;   1   &)
%                                         (   1 <=>;   0  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    8 (   8 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    1 (   1 usr;   0 prp; 2-2 aty)
%            Number of functors    :    0 (   0 usr;   0 con; --- aty)
%            Number of variables   :    3 (   1   !;   2   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%--------------------------------------------------------------------------
fof(pel42,conjecture,
    ~ ? [Y] :
      ! [X] :
        ( element(X,Y)
      <=> ~ ? [Z] :
              ( element(X,Z)
              & element(Z,X) ) ) ).

%--------------------------------------------------------------------------

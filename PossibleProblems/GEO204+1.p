%------------------------------------------------------------------------------
% File     : GEO204+1 : TPTP v9.2.1. Released v3.3.0.
% Domain   : Geometry (Constructive)
% Problem  : Distinct points and equal lines
% Version  : [vPl95] axioms : Especial.
% English  : If the points X and Y are distinct, and the points Y and Z are
%            equal, then X and Z are distinct, and the line connecting X
%            and Y is equivalent to the line connecting X and Z.

% Refs     : [vPl95] von Plato (1995), The Axioms of Constructive Geometry
%          : [ROK06] Raths et al. (2006), The ILTP Problem Library for Intu
% Source   : [ILTP]
% Names    : Theorem 5.5 [vPl95]

% Status   : Theorem
% Rating   : 0.00 v9.1.0, 0.07 v9.0.0, 0.00 v6.1.0, 0.04 v6.0.0, 0.25 v5.5.0, 0.12 v5.4.0, 0.13 v5.3.0, 0.26 v5.2.0, 0.29 v5.0.0, 0.15 v4.1.0, 0.17 v4.0.1, 0.21 v4.0.0, 0.20 v3.7.0, 0.14 v3.5.0, 0.00 v3.3.0
% Syntax   : Number of formulae    :   15 (   3 unt;   0 def)
%            Number of atoms       :   39 (   0 equ)
%            Maximal formula atoms :    6 (   2 avg)
%            Number of connectives :   33 (   9   ~;   9   |;   3   &)
%                                         (   0 <=>;  12  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    9 (   5 avg)
%            Maximal term depth    :    2 (   1 avg)
%            Number of predicates  :    4 (   4 usr;   0 prp; 2-2 aty)
%            Number of functors    :    2 (   2 usr;   0 con; 2-2 aty)
%            Number of variables   :   36 (  36   !;   0   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments : Definitions unfolded, hence Especial.
%------------------------------------------------------------------------------
include('Axioms/GEO006+0.ax').
%------------------------------------------------------------------------------
fof(con,conjecture,
    ! [X,Y,Z] :
      ( ( distinct_points(X,Y)
        & ~ distinct_points(Y,Z) )
     => ( distinct_points(X,Z)
        & ~ distinct_lines(line_connecting(X,Y),line_connecting(X,Z)) ) ) ).

%------------------------------------------------------------------------------

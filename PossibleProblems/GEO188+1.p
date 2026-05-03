%------------------------------------------------------------------------------
% File     : GEO188+1 : TPTP v9.2.1. Released v3.3.0.
% Domain   : Geometry (Constructive)
% Problem  : Collary to symmetry of incidence
% Version  : [vPl95] axioms : Especial.
% English  : If X, Y, and Z are pairwise distinct, and Z is incident with
%            the line connecting X and Y, then X is incident with the line
%            connecting Z and Y.

% Refs     : [vPl95] von Plato (1995), The Axioms of Constructive Geometry
%          : [ROK06] Raths et al. (2006), The ILTP Problem Library for Intu
% Source   : [ILTP]
% Names    : Corollary 4.7.i [vPl95]

% Status   : Theorem
% Rating   : 0.00 v9.1.0, 0.07 v9.0.0, 0.00 v6.1.0, 0.04 v6.0.0, 0.25 v5.5.0, 0.17 v5.3.0, 0.22 v5.2.0, 0.29 v5.0.0, 0.15 v4.1.0, 0.17 v4.0.1, 0.26 v4.0.0, 0.25 v3.7.0, 0.29 v3.5.0, 0.00 v3.3.0
% Syntax   : Number of formulae    :   15 (   3 unt;   0 def)
%            Number of atoms       :   40 (   0 equ)
%            Maximal formula atoms :    6 (   2 avg)
%            Number of connectives :   34 (   9   ~;   9   |;   4   &)
%                                         (   0 <=>;  12  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    9 (   6 avg)
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
        & distinct_points(X,Z)
        & distinct_points(Y,Z)
        & ~ apart_point_and_line(Z,line_connecting(X,Y)) )
     => ~ apart_point_and_line(X,line_connecting(Z,Y)) ) ).

%------------------------------------------------------------------------------

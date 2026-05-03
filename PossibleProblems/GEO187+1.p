%------------------------------------------------------------------------------
% File     : GEO187+1 : TPTP v9.2.1. Released v3.3.0.
% Domain   : Geometry (Constructive)
% Problem  : Symmetry of incidence
% Version  : [vPl95] axioms : Especial.
% English  : If X and Y are distinct points, U and V are distinct points,
%            X and Y are incident with the line connecting U and V, then
%            U and V are incident with the line connecting X and Y.

% Refs     : [vPl95] von Plato (1995), The Axioms of Constructive Geometry
%          : [ROK06] Raths et al. (2006), The ILTP Problem Library for Intu
% Source   : [ILTP]
% Names    : Theorem 4.6 [vPl95]

% Status   : Theorem
% Rating   : 0.00 v9.1.0, 0.07 v9.0.0, 0.00 v7.3.0, 0.14 v7.2.0, 0.17 v7.1.0, 0.25 v7.0.0, 0.00 v6.1.0, 0.08 v6.0.0, 0.50 v5.5.0, 0.21 v5.4.0, 0.22 v5.3.0, 0.30 v5.2.0, 0.29 v5.0.0, 0.15 v4.1.0, 0.17 v4.0.1, 0.26 v4.0.0, 0.25 v3.7.0, 0.14 v3.5.0, 0.00 v3.3.0
% Syntax   : Number of formulae    :   15 (   3 unt;   0 def)
%            Number of atoms       :   41 (   0 equ)
%            Maximal formula atoms :    6 (   2 avg)
%            Number of connectives :   37 (  11   ~;   9   |;   5   &)
%                                         (   0 <=>;  12  =>;   0  <=;   0 <~>)
%            Maximal formula depth :   10 (   6 avg)
%            Maximal term depth    :    2 (   1 avg)
%            Number of predicates  :    4 (   4 usr;   0 prp; 2-2 aty)
%            Number of functors    :    2 (   2 usr;   0 con; 2-2 aty)
%            Number of variables   :   37 (  37   !;   0   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments : Definitions unfolded, hence Especial.
%------------------------------------------------------------------------------
include('Axioms/GEO006+0.ax').
%------------------------------------------------------------------------------
fof(con,conjecture,
    ! [X,Y,U,V] :
      ( ( distinct_points(X,Y)
        & distinct_points(U,V)
        & ~ apart_point_and_line(X,line_connecting(U,V))
        & ~ apart_point_and_line(Y,line_connecting(U,V)) )
     => ( ~ apart_point_and_line(U,line_connecting(X,Y))
        & ~ apart_point_and_line(V,line_connecting(X,Y)) ) ) ).

%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
% File     : GEO183+1 : TPTP v9.2.1. Released v3.3.0.
% Domain   : Geometry (Constructive)
% Problem  : Lemma on symmetry and apartness
% Version  : [vPl95] axioms : Especial.
% English  : If X and Y are distinct points, then they are incident with
%            the line that is equal to the line connecting the points.

% Refs     : [vPl95] von Plato (1995), The Axioms of Constructive Geometry
%          : [ROK06] Raths et al. (2006), The ILTP Problem Library for Intu
% Source   : [ILTP]
% Names    : Lemma 4.5.i [vPl95]

% Status   : Theorem
% Rating   : 0.00 v9.1.0, 0.07 v9.0.0, 0.00 v6.1.0, 0.08 v6.0.0, 0.25 v5.5.0, 0.08 v5.4.0, 0.09 v5.3.0, 0.22 v5.2.0, 0.14 v5.0.0, 0.05 v4.1.0, 0.06 v4.0.1, 0.11 v4.0.0, 0.10 v3.7.0, 0.00 v3.3.0
% Syntax   : Number of formulae    :   15 (   3 unt;   0 def)
%            Number of atoms       :   40 (   0 equ)
%            Maximal formula atoms :    6 (   2 avg)
%            Number of connectives :   35 (  10   ~;   9   |;   4   &)
%                                         (   0 <=>;  12  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    9 (   6 avg)
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
        & convergent_lines(U,V)
        & ~ distinct_lines(U,line_connecting(X,Y)) )
     => ( ~ apart_point_and_line(X,U)
        & ~ apart_point_and_line(Y,U) ) ) ).

%------------------------------------------------------------------------------

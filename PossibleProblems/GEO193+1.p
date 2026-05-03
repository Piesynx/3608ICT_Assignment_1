%------------------------------------------------------------------------------
% File     : GEO193+1 : TPTP v9.2.1. Released v3.3.0.
% Domain   : Geometry (Constructive)
% Problem  : Corollary to symmetry of apartness
% Version  : [vPl95] axioms : Especial.
% English  : If the lines X, Y, and Z are pairwise convergent, and the
%            intersection point of X and Y is apart from a line Z, then
%            the intersection point of Y and Z is apart from X.

% Refs     : [vPl95] von Plato (1995), The Axioms of Constructive Geometry
%          : [ROK06] Raths et al. (2006), The ILTP Problem Library for Intu
% Source   : [ILTP]
% Names    : Corollary 4.10.i [vPl95]

% Status   : Theorem
% Rating   : 0.05 v9.1.0, 0.13 v9.0.0, 0.06 v8.2.0, 0.00 v6.4.0, 0.07 v6.3.0, 0.08 v6.2.0, 0.09 v6.1.0, 0.12 v6.0.0, 0.25 v5.5.0, 0.21 v5.4.0, 0.22 v5.3.0, 0.30 v5.2.0, 0.29 v5.0.0, 0.20 v4.1.0, 0.22 v4.0.1, 0.26 v4.0.0, 0.30 v3.7.0, 0.29 v3.5.0, 0.25 v3.4.0, 0.00 v3.3.0
% Syntax   : Number of formulae    :   15 (   3 unt;   0 def)
%            Number of atoms       :   40 (   0 equ)
%            Maximal formula atoms :    6 (   2 avg)
%            Number of connectives :   32 (   7   ~;   9   |;   3   &)
%                                         (   0 <=>;  13  =>;   0  <=;   0 <~>)
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
      ( ( convergent_lines(X,Y)
        & convergent_lines(Z,Y)
        & convergent_lines(X,Z) )
     => ( apart_point_and_line(intersection_point(X,Y),Z)
       => apart_point_and_line(intersection_point(Z,Y),X) ) ) ).

%------------------------------------------------------------------------------

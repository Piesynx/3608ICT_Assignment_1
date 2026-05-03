%------------------------------------------------------------------------------
% File     : GEO201+2 : TPTP v9.2.1. Released v3.3.0.
% Domain   : Geometry (Constructive)
% Problem  : Distinct ends means distinct lines
% Version  : [vPl95] axioms : Reduced > Especial.
% English  : If the lines X and Y are convergent, then the intersection
%            point of X and Y is equal to the intersection point of X and Y.

% Refs     : [vPl95] von Plato (1995), The Axioms of Constructive Geometry
%          : [Li97]  Li (1997), Replacing the Axioms for Connecting Lines a
%          : [Li98]  Li (1998), A Shorter and Intuitive Axiom to Replace th
%          : [ROK06] Raths et al. (2006), The ILTP Problem Library for Intu
% Source   : [ILTP]
% Names    :

% Status   : Theorem
% Rating   : 0.00 v9.1.0, 0.07 v9.0.0, 0.00 v8.1.0, 0.07 v7.5.0, 0.05 v7.4.0, 0.00 v6.1.0, 0.04 v6.0.0, 0.25 v5.5.0, 0.12 v5.4.0, 0.09 v5.3.0, 0.17 v5.2.0, 0.14 v5.0.0, 0.05 v4.1.0, 0.06 v4.0.1, 0.05 v4.0.0, 0.10 v3.7.0, 0.14 v3.5.0, 0.00 v3.3.0
% Syntax   : Number of formulae    :   13 (   3 unt;   0 def)
%            Number of atoms       :   36 (   0 equ)
%            Maximal formula atoms :    6 (   2 avg)
%            Number of connectives :   27 (   4   ~;   9   |;   2   &)
%                                         (   0 <=>;  12  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    9 (   5 avg)
%            Maximal term depth    :    2 (   1 avg)
%            Number of predicates  :    4 (   4 usr;   0 prp; 2-2 aty)
%            Number of functors    :    2 (   2 usr;   0 con; 2-2 aty)
%            Number of variables   :   32 (  32   !;   0   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :  Definitions unfolded, hence Especial.
%------------------------------------------------------------------------------
include('Axioms/GEO008+0.ax').
%------------------------------------------------------------------------------
fof(con,conjecture,
    ! [X,Y] :
      ( convergent_lines(X,Y)
     => ~ distinct_points(intersection_point(X,Y),intersection_point(Y,X)) ) ).

%------------------------------------------------------------------------------

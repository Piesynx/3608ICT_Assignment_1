%------------------------------------------------------------------------------
% File     : GEO200+2 : TPTP v9.2.1. Released v3.3.0.
% Domain   : Geometry (Constructive)
% Problem  : Line equals its converse
% Version  : [vPl95] axioms : Reduced > Especial.
% English  : If the points X and Y are distinct, then the line connecting
%            X and Y is equal to the line connecting Y and X.

% Refs     : [vPl95] von Plato (1995), The Axioms of Constructive Geometry
%          : [Li97]  Li (1997), Replacing the Axioms for Connecting Lines a
%          : [Li98]  Li (1998), A Shorter and Intuitive Axiom to Replace th
%          : [ROK06] Raths et al. (2006), The ILTP Problem Library for Intu
% Source   : [ILTP]
% Names    :

% Status   : Theorem
% Rating   : 0.00 v9.1.0, 0.07 v9.0.0, 0.00 v5.5.0, 0.04 v5.3.0, 0.13 v5.2.0, 0.14 v5.0.0, 0.05 v4.1.0, 0.06 v4.0.1, 0.05 v3.7.0, 0.14 v3.5.0, 0.00 v3.3.0
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
      ( distinct_points(X,Y)
     => ~ distinct_lines(line_connecting(X,Y),line_connecting(Y,X)) ) ).

%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
% File     : GEO207+2 : TPTP v9.2.1. Released v3.3.0.
% Domain   : Geometry (Constructive)
% Problem  : Irreflexivity of line convergence
% Version  : [vPl95] axioms : Reduced > Especial.
% English  : A line is not convergent to itself.

% Refs     : [vPl95] von Plato (1995), The Axioms of Constructive Geometry
%          : [Li97]  Li (1997), Replacing the Axioms for Connecting Lines a
%          : [Li98]  Li (1998), A Shorter and Intuitive Axiom to Replace th
%          : [ROK06] Raths et al. (2006), The ILTP Problem Library for Intu
% Source   : [ILTP]
% Names    :

% Status   : Theorem
% Rating   : 0.00 v6.1.0, 0.04 v6.0.0, 0.25 v5.5.0, 0.04 v5.3.0, 0.09 v5.2.0, 0.07 v5.0.0, 0.00 v3.3.0
% Syntax   : Number of formulae    :   16 (   6 unt;   0 def)
%            Number of atoms       :   41 (   0 equ)
%            Maximal formula atoms :    6 (   2 avg)
%            Number of connectives :   31 (   6   ~;  11   |;   2   &)
%                                         (   0 <=>;  12  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    9 (   5 avg)
%            Maximal term depth    :    2 (   1 avg)
%            Number of predicates  :    4 (   4 usr;   0 prp; 2-2 aty)
%            Number of functors    :    3 (   3 usr;   0 con; 2-2 aty)
%            Number of variables   :   38 (  38   !;   0   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :  Definitions unfolded, hence Especial.
%------------------------------------------------------------------------------
include('Axioms/GEO008+0.ax').
include('Axioms/GEO006+2.ax').
%------------------------------------------------------------------------------
fof(con,conjecture,
    ! [X] : ~ convergent_lines(X,X) ).

%------------------------------------------------------------------------------

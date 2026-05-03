%------------------------------------------------------------------------------
% File     : GEO216+2 : TPTP v9.2.1. Released v3.3.0.
% Domain   : Geometry (Constructive)
% Problem  : A line is not orthogonal to itself
% Version  : [vPl95] axioms : Reduced > Especial.
% English  : A Line is not orthogonal to itself.

% Refs     : [P95] J. von Plato. The Axioms of Constructive Geometry. Annals
%          : [Li97]  Li (1997), Replacing the Axioms for Connecting Lines a
%          : [Li98]  Li (1998), A Shorter and Intuitive Axiom to Replace th
%          : [ROK06] Raths et al. (2006), The ILTP Problem Library for Intu
%                  of Pure and Applied Logic 76 (2): 169-200, 1995.
% Source   : [P95]
% Names    :

% Status   : Theorem
% Rating   : 0.00 v6.1.0, 0.04 v6.0.0, 0.25 v5.5.0, 0.04 v5.3.0, 0.13 v5.2.0, 0.07 v5.0.0, 0.00 v3.3.0
% Syntax   : Number of formulae    :   16 (   4 unt;   0 def)
%            Number of atoms       :   46 (   0 equ)
%            Maximal formula atoms :    6 (   2 avg)
%            Number of connectives :   47 (  17   ~;  12   |;   5   &)
%                                         (   0 <=>;  13  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    9 (   6 avg)
%            Maximal term depth    :    2 (   1 avg)
%            Number of predicates  :    5 (   5 usr;   0 prp; 2-2 aty)
%            Number of functors    :    2 (   2 usr;   0 con; 2-2 aty)
%            Number of variables   :   39 (  39   !;   0   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :  Definitions unfolded, hence Especial.
%------------------------------------------------------------------------------
include('Axioms/GEO008+0.ax').
include('Axioms/GEO006+4.ax').
%------------------------------------------------------------------------------
fof(con,conjecture,
    ! [L] :
      ~ ~ unorthogonal_lines(L,L) ).

%------------------------------------------------------------------------------

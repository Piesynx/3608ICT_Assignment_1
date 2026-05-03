%------------------------------------------------------------------------------
% File     : GEO219+2 : TPTP v9.2.1. Released v3.3.0.
% Domain   : Geometry (Constructive)
% Problem  : Transitivity of orthogonal and parallel
% Version  : [vPl95] axioms : Reduced > Especial.
% English  : If line L is orthogonal to M and a line N is parallel to L,
%            then M is orthogonal to N.

% Refs     : [vPl95] von Plato (1995), The Axioms of Constructive Geometry
%          : [Li97]  Li (1997), Replacing the Axioms for Connecting Lines a
%          : [Li98]  Li (1998), A Shorter and Intuitive Axiom to Replace th
%          : [ROK06] Raths et al. (2006), The ILTP Problem Library for Intu
% Source   : [ILTP]
% Names    :

% Status   : Theorem
% Rating   : 0.00 v9.1.0, 0.07 v9.0.0, 0.00 v5.5.0, 0.04 v5.3.0, 0.13 v5.2.0, 0.14 v5.0.0, 0.05 v4.1.0, 0.06 v4.0.1, 0.05 v3.7.0, 0.00 v3.3.0
% Syntax   : Number of formulae    :   16 (   3 unt;   0 def)
%            Number of atoms       :   48 (   0 equ)
%            Maximal formula atoms :    6 (   3 avg)
%            Number of connectives :   50 (  18   ~;  12   |;   6   &)
%                                         (   0 <=>;  14  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    9 (   6 avg)
%            Maximal term depth    :    2 (   1 avg)
%            Number of predicates  :    5 (   5 usr;   0 prp; 2-2 aty)
%            Number of functors    :    2 (   2 usr;   0 con; 2-2 aty)
%            Number of variables   :   41 (  41   !;   0   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :  Definitions unfolded, hence Especial.
%------------------------------------------------------------------------------
include('Axioms/GEO008+0.ax').
include('Axioms/GEO006+4.ax').
%------------------------------------------------------------------------------
fof(con,conjecture,
    ! [L,M,N] :
      ( ( ~ unorthogonal_lines(L,M)
        & ~ convergent_lines(L,N) )
     => ~ unorthogonal_lines(M,N) ) ).

%------------------------------------------------------------------------------

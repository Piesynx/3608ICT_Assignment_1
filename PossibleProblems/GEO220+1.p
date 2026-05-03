%------------------------------------------------------------------------------
% File     : GEO220+1 : TPTP v9.2.1. Released v3.3.0.
% Domain   : Geometry (Constructive)
% Problem  : Transitivity of orthogonal
% Version  : [vPl95] axioms : Especial.
% English  : If a line L is orthogonal to line M and line N is orthogonal
%            to L, then M and N are parallel.

% Refs     : [vPl95] von Plato (1995), The Axioms of Constructive Geometry
%          : [ROK06] Raths et al. (2006), The ILTP Problem Library for Intu
% Source   : [ILTP]
% Names    : Theorem 8.7.iv [vPl95]

% Status   : Theorem
% Rating   : 0.00 v6.1.0, 0.04 v6.0.0, 0.25 v5.5.0, 0.04 v5.3.0, 0.13 v5.2.0, 0.07 v5.0.0, 0.00 v3.3.0
% Syntax   : Number of formulae    :   18 (   3 unt;   0 def)
%            Number of atoms       :   49 (   0 equ)
%            Maximal formula atoms :    6 (   2 avg)
%            Number of connectives :   53 (  22   ~;  12   |;   5   &)
%                                         (   0 <=>;  14  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    9 (   6 avg)
%            Maximal term depth    :    2 (   1 avg)
%            Number of predicates  :    5 (   5 usr;   0 prp; 2-2 aty)
%            Number of functors    :    2 (   2 usr;   0 con; 2-2 aty)
%            Number of variables   :   44 (  44   !;   0   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments : Definitions unfolded, hence Especial.
%------------------------------------------------------------------------------
include('Axioms/GEO006+0.ax').
include('Axioms/GEO006+4.ax').
%------------------------------------------------------------------------------
fof(con,conjecture,
    ! [L,M,N] :
      ( ( ~ unorthogonal_lines(L,M)
        & ~ unorthogonal_lines(L,N) )
     => ~ convergent_lines(M,N) ) ).

%------------------------------------------------------------------------------

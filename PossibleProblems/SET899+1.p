%------------------------------------------------------------------------------
% File     : SET899+1 : TPTP v9.2.1. Released v3.2.0.
% Domain   : Set theory
% Problem  : subset(A,B) => ( in(C,A) | subset(A,difference(B,singleton(C))) )
% Version  : [Urb06] axioms : Especial.
% English  :

% Refs     : [Byl90] Bylinski (1990), Some Basic Properties of Sets
%          : [Urb06] Urban (2006), Email to G. Sutcliffe
% Source   : [Urb06]
% Names    : zfmisc_1__t40_zfmisc_1 [Urb06]

% Status   : Theorem
% Rating   : 0.00 v5.3.0, 0.09 v5.2.0, 0.00 v3.2.0
% Syntax   : Number of formulae    :    6 (   3 unt;   0 def)
%            Number of atoms       :   11 (   0 equ)
%            Maximal formula atoms :    3 (   1 avg)
%            Number of connectives :    7 (   2   ~;   2   |;   0   &)
%                                         (   0 <=>;   3  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    6 (   4 avg)
%            Maximal term depth    :    3 (   1 avg)
%            Number of predicates  :    3 (   3 usr;   0 prp; 1-2 aty)
%            Number of functors    :    2 (   2 usr;   0 con; 1-2 aty)
%            Number of variables   :   12 (  10   !;   2   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments : Translated by MPTP 0.2 from the original problem in the Mizar
%            library, www.mizar.org
%------------------------------------------------------------------------------
fof(reflexivity_r1_tarski,axiom,
    ! [A,B] : subset(A,A) ).

fof(antisymmetry_r2_hidden,axiom,
    ! [A,B] :
      ( in(A,B)
     => ~ in(B,A) ) ).

fof(rc1_xboole_0,axiom,
    ? [A] : empty(A) ).

fof(rc2_xboole_0,axiom,
    ? [A] : ~ empty(A) ).

fof(t40_zfmisc_1,conjecture,
    ! [A,B,C] :
      ( subset(A,B)
     => ( in(C,A)
        | subset(A,set_difference(B,singleton(C))) ) ) ).

fof(l3_zfmisc_1,axiom,
    ! [A,B,C] :
      ( subset(A,B)
     => ( in(C,A)
        | subset(A,set_difference(B,singleton(C))) ) ) ).

%------------------------------------------------------------------------------

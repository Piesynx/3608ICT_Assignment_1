%------------------------------------------------------------------------------
% File     : SEU263+1 : TPTP v9.2.1. Released v3.3.0.
% Domain   : Set theory
% Problem  : MPTP bushy problem t14_relset_1
% Version  : [Urb07] axioms : Especial.
% English  :

% Refs     : [Ban01] Bancerek et al. (2001), On the Characterizations of Co
%          : [Urb07] Urban (2006), Email to G. Sutcliffe
% Source   : [Urb07]
% Names    : bushy-t14_relset_1 [Urb07]

% Status   : Theorem
% Rating   : 0.10 v9.1.0, 0.13 v9.0.0, 0.06 v8.2.0, 0.00 v8.1.0, 0.07 v7.5.0, 0.10 v7.4.0, 0.00 v7.0.0, 0.07 v6.3.0, 0.15 v6.2.0, 0.09 v6.1.0, 0.16 v6.0.0, 0.25 v5.5.0, 0.21 v5.4.0, 0.26 v5.3.0, 0.30 v5.2.0, 0.07 v5.0.0, 0.15 v4.1.0, 0.17 v4.0.1, 0.26 v4.0.0, 0.25 v3.7.0, 0.14 v3.5.0, 0.25 v3.4.0, 0.00 v3.3.0
% Syntax   : Number of formulae    :   20 (  10 unt;   0 def)
%            Number of atoms       :   34 (   0 equ)
%            Maximal formula atoms :    3 (   1 avg)
%            Number of connectives :   14 (   0   ~;   0   |;   3   &)
%                                         (   3 <=>;   8  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    7 (   4 avg)
%            Maximal term depth    :    3 (   1 avg)
%            Number of predicates  :    6 (   5 usr;   1 prp; 0-3 aty)
%            Number of functors    :    4 (   4 usr;   0 con; 1-2 aty)
%            Number of variables   :   39 (  36   !;   3   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments : Translated by MPTP 0.2 from the original problem in the Mizar
%            library, www.mizar.org
%------------------------------------------------------------------------------
fof(cc1_relset_1,axiom,
    ! [A,B,C] :
      ( element(C,powerset(cartesian_product2(A,B)))
     => relation(C) ) ).

fof(d1_relset_1,axiom,
    ! [A,B,C] :
      ( relation_of2(C,A,B)
    <=> subset(C,cartesian_product2(A,B)) ) ).

fof(dt_k1_relat_1,axiom,
    $true ).

fof(dt_k1_zfmisc_1,axiom,
    $true ).

fof(dt_k2_relat_1,axiom,
    $true ).

fof(dt_k2_zfmisc_1,axiom,
    $true ).

fof(dt_m1_relset_1,axiom,
    $true ).

fof(dt_m1_subset_1,axiom,
    $true ).

fof(dt_m2_relset_1,axiom,
    ! [A,B,C] :
      ( relation_of2_as_subset(C,A,B)
     => element(C,powerset(cartesian_product2(A,B))) ) ).

fof(existence_m1_relset_1,axiom,
    ! [A,B] :
    ? [C] : relation_of2(C,A,B) ).

fof(existence_m1_subset_1,axiom,
    ! [A] :
    ? [B] : element(B,A) ).

fof(existence_m2_relset_1,axiom,
    ! [A,B] :
    ? [C] : relation_of2_as_subset(C,A,B) ).

fof(redefinition_m2_relset_1,axiom,
    ! [A,B,C] :
      ( relation_of2_as_subset(C,A,B)
    <=> relation_of2(C,A,B) ) ).

fof(reflexivity_r1_tarski,axiom,
    ! [A,B] : subset(A,A) ).

fof(t119_zfmisc_1,axiom,
    ! [A,B,C,D] :
      ( ( subset(A,B)
        & subset(C,D) )
     => subset(cartesian_product2(A,C),cartesian_product2(B,D)) ) ).

fof(t12_relset_1,axiom,
    ! [A,B,C] :
      ( relation_of2_as_subset(C,A,B)
     => ( subset(relation_dom(C),A)
        & subset(relation_rng(C),B) ) ) ).

fof(t14_relset_1,conjecture,
    ! [A,B,C,D] :
      ( relation_of2_as_subset(D,C,A)
     => ( subset(relation_rng(D),B)
       => relation_of2_as_subset(D,C,B) ) ) ).

fof(t1_xboole_1,axiom,
    ! [A,B,C] :
      ( ( subset(A,B)
        & subset(B,C) )
     => subset(A,C) ) ).

fof(t21_relat_1,axiom,
    ! [A] :
      ( relation(A)
     => subset(A,cartesian_product2(relation_dom(A),relation_rng(A))) ) ).

fof(t3_subset,axiom,
    ! [A,B] :
      ( element(A,powerset(B))
    <=> subset(A,B) ) ).

%------------------------------------------------------------------------------

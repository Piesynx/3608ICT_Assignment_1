%------------------------------------------------------------------------------
% File     : SEU261+1 : TPTP v9.2.1. Released v3.3.0.
% Domain   : Set theory
% Problem  : MPTP bushy problem t54_wellord1
% Version  : [Urb07] axioms : Especial.
% English  :

% Refs     : [Ban01] Bancerek et al. (2001), On the Characterizations of Co
%          : [Urb07] Urban (2006), Email to G. Sutcliffe
% Source   : [Urb07]
% Names    : bushy-t54_wellord1 [Urb07]

% Status   : Theorem
% Rating   : 0.00 v5.3.0, 0.09 v5.2.0, 0.00 v3.3.0
% Syntax   : Number of formulae    :    4 (   0 unt;   0 def)
%            Number of atoms       :   31 (   0 equ)
%            Maximal formula atoms :   15 (   7 avg)
%            Number of connectives :   27 (   0   ~;   0   |;  12   &)
%                                         (   1 <=>;  14  =>;   0  <=;   0 <~>)
%            Maximal formula depth :   13 (   8 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    9 (   9 usr;   0 prp; 1-3 aty)
%            Number of functors    :    0 (   0 usr;   0 con; --- aty)
%            Number of variables   :    8 (   7   !;   1   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments : Translated by MPTP 0.2 from the original problem in the Mizar
%            library, www.mizar.org
%------------------------------------------------------------------------------
fof(d4_wellord1,axiom,
    ! [A] :
      ( relation(A)
     => ( well_ordering(A)
      <=> ( reflexive(A)
          & transitive(A)
          & antisymmetric(A)
          & connected(A)
          & well_founded_relation(A) ) ) ) ).

fof(rc1_funct_1,axiom,
    ? [A] :
      ( relation(A)
      & function(A) ) ).

fof(t53_wellord1,axiom,
    ! [A] :
      ( relation(A)
     => ! [B] :
          ( relation(B)
         => ! [C] :
              ( ( relation(C)
                & function(C) )
             => ( relation_isomorphism(A,B,C)
               => ( ( reflexive(A)
                   => reflexive(B) )
                  & ( transitive(A)
                   => transitive(B) )
                  & ( connected(A)
                   => connected(B) )
                  & ( antisymmetric(A)
                   => antisymmetric(B) )
                  & ( well_founded_relation(A)
                   => well_founded_relation(B) ) ) ) ) ) ) ).

fof(t54_wellord1,conjecture,
    ! [A] :
      ( relation(A)
     => ! [B] :
          ( relation(B)
         => ! [C] :
              ( ( relation(C)
                & function(C) )
             => ( ( well_ordering(A)
                  & relation_isomorphism(A,B,C) )
               => well_ordering(B) ) ) ) ) ).

%------------------------------------------------------------------------------

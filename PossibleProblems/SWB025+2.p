%------------------------------------------------------------------------------
% File     : SWB025+2 : TPTP v9.2.1. Released v5.2.0.
% Domain   : Semantic Web
% Problem  : Cyclic Dependencies between Complex Properties
% Version  : [Sch11] axioms : Reduced > Incomplete.
% English  :

% Refs     : [Sch11] Schneider, M. (2011), Email to G. Sutcliffe
% Source   : [Sch11]
% Names    : 025_Cyclic_Dependencies_between_Complex_Properties [Sch11]

% Status   : Theorem
% Rating   : 0.05 v9.1.0, 0.07 v9.0.0, 0.00 v8.2.0, 0.07 v7.5.0, 0.05 v7.4.0, 0.06 v7.3.0, 0.14 v7.2.0, 0.17 v7.1.0, 0.25 v7.0.0, 0.14 v6.3.0, 0.08 v6.2.0, 0.09 v6.1.0, 0.12 v6.0.0, 0.50 v5.5.0, 0.17 v5.3.0, 0.22 v5.2.0
% Syntax   : Number of formulae    :    4 (   0 unt;   0 def)
%            Number of atoms       :   33 (   0 equ)
%            Maximal formula atoms :   15 (   8 avg)
%            Number of connectives :   29 (   0   ~;   0   |;  24   &)
%                                         (   3 <=>;   2  =>;   0  <=;   0 <~>)
%            Maximal formula depth :   20 (  12 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    2 (   2 usr;   0 prp; 1-3 aty)
%            Number of functors    :   12 (  12 usr;  12 con; 0-0 aty)
%            Number of variables   :   17 (  12   !;   5   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%------------------------------------------------------------------------------
fof(owl_chain_002,axiom,
    ! [P,S1,P1,S2,P2] :
      ( ( iext(uri_rdf_first,S1,P1)
        & iext(uri_rdf_rest,S1,S2)
        & iext(uri_rdf_first,S2,P2)
        & iext(uri_rdf_rest,S2,uri_rdf_nil) )
     => ( iext(uri_owl_propertyChainAxiom,P,S1)
      <=> ( ip(P)
          & ip(P1)
          & ip(P2)
          & ! [Y0,Y1,Y2] :
              ( ( iext(P1,Y0,Y1)
                & iext(P2,Y1,Y2) )
             => iext(P,Y0,Y2) ) ) ) ) ).

fof(owl_inv,axiom,
    ! [P1,P2] :
      ( iext(uri_owl_inverseOf,P1,P2)
    <=> ( ip(P1)
        & ip(P2)
        & ! [X,Y] :
            ( iext(P1,X,Y)
          <=> iext(P2,Y,X) ) ) ) ).

fof(testcase_conclusion_fullish_025_Cyclic_Dependencies_between_Complex_Properties,conjecture,
    ( iext(uri_ex_hasUncle,uri_ex_alice,uri_ex_charly)
    & iext(uri_ex_hasCousin,uri_ex_bob,uri_ex_alice) ) ).

fof(testcase_premise_fullish_025_Cyclic_Dependencies_between_Complex_Properties,axiom,
    ? [BNODE_l11,BNODE_l12,BNODE_l21,BNODE_l22,BNODE_l3] :
      ( iext(uri_owl_propertyChainAxiom,uri_ex_hasUncle,BNODE_l11)
      & iext(uri_rdf_first,BNODE_l11,uri_ex_hasCousin)
      & iext(uri_rdf_rest,BNODE_l11,BNODE_l12)
      & iext(uri_rdf_first,BNODE_l12,uri_ex_hasFather)
      & iext(uri_rdf_rest,BNODE_l12,uri_rdf_nil)
      & iext(uri_owl_propertyChainAxiom,uri_ex_hasCousin,BNODE_l21)
      & iext(uri_rdf_first,BNODE_l21,uri_ex_hasUncle)
      & iext(uri_rdf_rest,BNODE_l21,BNODE_l22)
      & iext(uri_rdf_first,BNODE_l22,BNODE_l3)
      & iext(uri_rdf_rest,BNODE_l22,uri_rdf_nil)
      & iext(uri_owl_inverseOf,BNODE_l3,uri_ex_hasFather)
      & iext(uri_ex_hasFather,uri_ex_alice,uri_ex_dave)
      & iext(uri_ex_hasCousin,uri_ex_alice,uri_ex_bob)
      & iext(uri_ex_hasFather,uri_ex_bob,uri_ex_charly)
      & iext(uri_ex_hasUncle,uri_ex_bob,uri_ex_dave) ) ).

%------------------------------------------------------------------------------

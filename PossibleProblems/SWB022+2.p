%------------------------------------------------------------------------------
% File     : SWB022+2 : TPTP v9.2.1. Released v5.2.0.
% Domain   : Semantic Web
% Problem  : List Member Access
% Version  : [Sch11] axioms : Reduced > Incomplete.
% English  :

% Refs     : [Sch11] Schneider, M. (2011), Email to G. Sutcliffe
% Source   : [Sch11]
% Names    : 022_List_Member_Access [Sch11]

% Status   : Theorem
% Rating   : 0.10 v9.1.0, 0.07 v9.0.0, 0.06 v8.2.0, 0.13 v8.1.0, 0.14 v7.5.0, 0.10 v7.4.0, 0.12 v7.3.0, 0.14 v7.2.0, 0.17 v7.1.0, 0.25 v7.0.0, 0.21 v6.3.0, 0.15 v6.2.0, 0.18 v6.1.0, 0.16 v6.0.0, 0.50 v5.5.0, 0.21 v5.4.0, 0.13 v5.3.0, 0.22 v5.2.0
% Syntax   : Number of formulae    :    4 (   0 unt;   0 def)
%            Number of atoms       :   38 (   0 equ)
%            Maximal formula atoms :   19 (   9 avg)
%            Number of connectives :   34 (   0   ~;   0   |;  29   &)
%                                         (   1 <=>;   4  =>;   0  <=;   0 <~>)
%            Maximal formula depth :   27 (  14 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    2 (   2 usr;   0 prp; 1-3 aty)
%            Number of functors    :   13 (  13 usr;  13 con; 0-0 aty)
%            Number of variables   :   20 (  12   !;   8   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%------------------------------------------------------------------------------
fof(rdfs_subpropertyof_main,axiom,
    ! [P,Q] :
      ( iext(uri_rdfs_subPropertyOf,P,Q)
     => ( ip(P)
        & ip(Q)
        & ! [X,Y] :
            ( iext(P,X,Y)
           => iext(Q,X,Y) ) ) ) ).

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

fof(testcase_conclusion_fullish_022_List_Member_Access,conjecture,
    ( iext(uri_skos_member,uri_ex_MyOrderedCollection,uri_ex_X)
    & iext(uri_skos_member,uri_ex_MyOrderedCollection,uri_ex_Y)
    & iext(uri_skos_member,uri_ex_MyOrderedCollection,uri_ex_Z) ) ).

fof(testcase_premise_fullish_022_List_Member_Access,axiom,
    ? [BNODE_pL,BNODE_l11,BNODE_l12,BNODE_l21,BNODE_l22,BNODE_l31,BNODE_l32,BNODE_l33] :
      ( iext(uri_rdfs_subPropertyOf,uri_skos_memberList,BNODE_pL)
      & iext(uri_owl_propertyChainAxiom,uri_skos_member,BNODE_l11)
      & iext(uri_rdf_first,BNODE_l11,BNODE_pL)
      & iext(uri_rdf_rest,BNODE_l11,BNODE_l12)
      & iext(uri_rdf_first,BNODE_l12,uri_rdf_first)
      & iext(uri_rdf_rest,BNODE_l12,uri_rdf_nil)
      & iext(uri_owl_propertyChainAxiom,BNODE_pL,BNODE_l21)
      & iext(uri_rdf_first,BNODE_l21,BNODE_pL)
      & iext(uri_rdf_rest,BNODE_l21,BNODE_l22)
      & iext(uri_rdf_first,BNODE_l22,uri_rdf_rest)
      & iext(uri_rdf_rest,BNODE_l22,uri_rdf_nil)
      & iext(uri_rdf_type,uri_ex_MyOrderedCollection,uri_skos_OrderedCollection)
      & iext(uri_skos_memberList,uri_ex_MyOrderedCollection,BNODE_l31)
      & iext(uri_rdf_first,BNODE_l31,uri_ex_X)
      & iext(uri_rdf_rest,BNODE_l31,BNODE_l32)
      & iext(uri_rdf_first,BNODE_l32,uri_ex_Y)
      & iext(uri_rdf_rest,BNODE_l32,BNODE_l33)
      & iext(uri_rdf_first,BNODE_l33,uri_ex_Z)
      & iext(uri_rdf_rest,BNODE_l33,uri_rdf_nil) ) ).

%------------------------------------------------------------------------------

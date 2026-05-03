%------------------------------------------------------------------------------
% File     : SWB024+2 : TPTP v9.2.1. Released v5.2.0.
% Domain   : Semantic Web
% Problem  : Cardinality Restrictions on Complex Properties
% Version  : [Sch11] axioms : Reduced > Incomplete.
% English  :

% Refs     : [Sch11] Schneider, M. (2011), Email to G. Sutcliffe
% Source   : [Sch11]
% Names    : 024_Cardinality_Restrictions_on_Complex_Properties [Sch11]

% Status   : Theorem
% Rating   : 0.10 v9.1.0, 0.00 v7.5.0, 0.05 v7.4.0, 0.00 v7.0.0, 0.07 v6.4.0, 0.00 v6.3.0, 0.08 v6.2.0, 0.00 v6.1.0, 0.08 v6.0.0, 0.00 v5.5.0, 0.04 v5.3.0, 0.13 v5.2.0
% Syntax   : Number of formulae    :    6 (   0 unt;   0 def)
%            Number of atoms       :   26 (   0 equ)
%            Maximal formula atoms :    8 (   4 avg)
%            Number of connectives :   20 (   0   ~;   0   |;  13   &)
%                                         (   4 <=>;   3  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    9 (   7 avg)
%            Maximal term depth    :    2 (   1 avg)
%            Number of predicates  :    4 (   4 usr;   0 prp; 1-3 aty)
%            Number of functors    :   13 (  13 usr;  12 con; 0-2 aty)
%            Number of variables   :   15 (  12   !;   3   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%------------------------------------------------------------------------------
fof(rdfs_cext_def,axiom,
    ! [X,C] :
      ( iext(uri_rdf_type,X,C)
    <=> icext(C,X) ) ).

fof(owl_restrict_mincard_001,axiom,
    ! [Z,P] :
      ( ( iext(uri_owl_minCardinality,Z,literal_typed(dat_str_1,uri_xsd_nonNegativeInteger))
        & iext(uri_owl_onProperty,Z,P) )
     => ! [X] :
          ( icext(Z,X)
        <=> ? [Y] : iext(P,X,Y) ) ) ).

fof(owl_rdfsext_subclassof,axiom,
    ! [C1,C2] :
      ( iext(uri_rdfs_subClassOf,C1,C2)
    <=> ( ic(C1)
        & ic(C2)
        & ! [X] :
            ( icext(C1,X)
           => icext(C2,X) ) ) ) ).

fof(owl_char_transitive,axiom,
    ! [P] :
      ( icext(uri_owl_TransitiveProperty,P)
    <=> ( ip(P)
        & ! [X,Y,Z] :
            ( ( iext(P,X,Y)
              & iext(P,Y,Z) )
           => iext(P,X,Z) ) ) ) ).

fof(testcase_conclusion_fullish_024_Cardinality_Restrictions_on_Complex_Properties,conjecture,
    ? [BNODE_x] :
      ( iext(uri_ex_hasAncestor,uri_ex_bob,BNODE_x)
      & iext(uri_ex_hasAncestor,uri_ex_alice,BNODE_x) ) ).

fof(testcase_premise_fullish_024_Cardinality_Restrictions_on_Complex_Properties,axiom,
    ? [BNODE_z] :
      ( iext(uri_rdf_type,uri_ex_hasAncestor,uri_owl_TransitiveProperty)
      & iext(uri_rdfs_subClassOf,uri_ex_Person,BNODE_z)
      & iext(uri_rdf_type,BNODE_z,uri_owl_Restriction)
      & iext(uri_owl_onProperty,BNODE_z,uri_ex_hasAncestor)
      & iext(uri_owl_minCardinality,BNODE_z,literal_typed(dat_str_1,uri_xsd_nonNegativeInteger))
      & iext(uri_rdf_type,uri_ex_alice,uri_ex_Person)
      & iext(uri_rdf_type,uri_ex_bob,uri_ex_Person)
      & iext(uri_ex_hasAncestor,uri_ex_alice,uri_ex_bob) ) ).

%------------------------------------------------------------------------------

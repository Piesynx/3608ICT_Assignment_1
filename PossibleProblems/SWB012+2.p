%------------------------------------------------------------------------------
% File     : SWB012+2 : TPTP v9.2.1. Released v5.2.0.
% Domain   : Semantic Web
% Problem  : Template Class
% Version  : [Sch11] axioms : Reduced > Incomplete.
% English  :

% Refs     : [Sch11] Schneider, M. (2011), Email to G. Sutcliffe
% Source   : [Sch11]
% Names    : 012_Template_Class [Sch11]

% Status   : Theorem
% Rating   : 0.10 v9.1.0, 0.07 v9.0.0, 0.06 v8.2.0, 0.13 v8.1.0, 0.07 v7.5.0, 0.14 v7.4.0, 0.06 v7.3.0, 0.14 v7.2.0, 0.17 v7.1.0, 0.25 v7.0.0, 0.07 v6.4.0, 0.00 v6.3.0, 0.08 v6.2.0, 0.18 v6.1.0, 0.16 v6.0.0, 0.50 v5.5.0, 0.21 v5.4.0, 0.13 v5.3.0, 0.22 v5.2.0
% Syntax   : Number of formulae    :    6 (   0 unt;   0 def)
%            Number of atoms       :   39 (   0 equ)
%            Maximal formula atoms :   15 (   6 avg)
%            Number of connectives :   33 (   0   ~;   0   |;  26   &)
%                                         (   4 <=>;   3  =>;   0  <=;   0 <~>)
%            Maximal formula depth :   18 (   9 avg)
%            Maximal term depth    :    2 (   1 avg)
%            Number of predicates  :    3 (   3 usr;   0 prp; 1-3 aty)
%            Number of functors    :   18 (  18 usr;  17 con; 0-1 aty)
%            Number of variables   :   22 (  18   !;   4   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%------------------------------------------------------------------------------
fof(rdfs_cext_def,axiom,
    ! [X,C] :
      ( iext(uri_rdf_type,X,C)
    <=> icext(C,X) ) ).

fof(rdfs_domain_main,axiom,
    ! [P,C,X,Y] :
      ( ( iext(uri_rdfs_domain,P,C)
        & iext(P,X,Y) )
     => icext(C,X) ) ).

fof(owl_bool_intersectionof_class_003,axiom,
    ! [Z,S1,C1,S2,C2,S3,C3] :
      ( ( iext(uri_rdf_first,S1,C1)
        & iext(uri_rdf_rest,S1,S2)
        & iext(uri_rdf_first,S2,C2)
        & iext(uri_rdf_rest,S2,S3)
        & iext(uri_rdf_first,S3,C3)
        & iext(uri_rdf_rest,S3,uri_rdf_nil) )
     => ( iext(uri_owl_intersectionOf,Z,S1)
      <=> ( ic(Z)
          & ic(C1)
          & ic(C2)
          & ic(C3)
          & ! [X] :
              ( icext(Z,X)
            <=> ( icext(C1,X)
                & icext(C2,X)
                & icext(C3,X) ) ) ) ) ) ).

fof(owl_restrict_hasvalue,axiom,
    ! [Z,P,A] :
      ( ( iext(uri_owl_hasValue,Z,A)
        & iext(uri_owl_onProperty,Z,P) )
     => ! [X] :
          ( icext(Z,X)
        <=> iext(P,X,A) ) ) ).

fof(testcase_conclusion_fullish_012_Template_Class,conjecture,
    ( iext(uri_rdf_type,uri_ex_name,uri_owl_FunctionalProperty)
    & iext(uri_rdf_type,uri_ex_alice,uri_foaf_Person) ) ).

fof(testcase_premise_fullish_012_Template_Class,axiom,
    ? [BNODE_l1,BNODE_l2,BNODE_l3,BNODE_r] :
      ( iext(uri_rdf_type,uri_foaf_Person,uri_owl_Class)
      & iext(uri_owl_intersectionOf,uri_ex_PersonAttribute,BNODE_l1)
      & iext(uri_rdf_first,BNODE_l1,uri_owl_DatatypeProperty)
      & iext(uri_rdf_rest,BNODE_l1,BNODE_l2)
      & iext(uri_rdf_first,BNODE_l2,uri_owl_FunctionalProperty)
      & iext(uri_rdf_rest,BNODE_l2,BNODE_l3)
      & iext(uri_rdf_first,BNODE_l3,BNODE_r)
      & iext(uri_rdf_rest,BNODE_l3,uri_rdf_nil)
      & iext(uri_rdf_type,BNODE_r,uri_owl_Restriction)
      & iext(uri_owl_onProperty,BNODE_r,uri_rdfs_domain)
      & iext(uri_owl_hasValue,BNODE_r,uri_foaf_Person)
      & iext(uri_rdf_type,uri_ex_name,uri_ex_PersonAttribute)
      & iext(uri_ex_name,uri_ex_alice,literal_plain(dat_str_alice)) ) ).

%------------------------------------------------------------------------------

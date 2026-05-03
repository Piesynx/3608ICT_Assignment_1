%------------------------------------------------------------------------------
% File     : SWB016+2 : TPTP v9.2.1. Released v5.2.0.
% Domain   : Semantic Web
% Problem  : Reflective Tautologies II
% Version  : [Sch11] axioms : Reduced > Incomplete.
% English  :

% Refs     : [Sch11] Schneider, M. (2011), Email to G. Sutcliffe
% Source   : [Sch11]
% Names    : 016_Reflective_Tautologies_II [Sch11]

% Status   : Theorem
% Rating   : 0.10 v9.1.0, 0.13 v9.0.0, 0.06 v8.2.0, 0.07 v8.1.0, 0.14 v7.5.0, 0.10 v7.4.0, 0.06 v7.3.0, 0.00 v7.0.0, 0.07 v6.3.0, 0.00 v6.1.0, 0.12 v6.0.0, 0.25 v5.5.0, 0.08 v5.4.0, 0.09 v5.3.0, 0.17 v5.2.0
% Syntax   : Number of formulae    :   11 (   4 unt;   0 def)
%            Number of atoms       :   29 (   0 equ)
%            Maximal formula atoms :    5 (   2 avg)
%            Number of connectives :   18 (   0   ~;   0   |;   8   &)
%                                         (   6 <=>;   4  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    9 (   4 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    4 (   4 usr;   0 prp; 1-3 aty)
%            Number of functors    :    7 (   7 usr;   7 con; 0-0 aty)
%            Number of variables   :   19 (  19   !;   0   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%------------------------------------------------------------------------------
fof(rdf_type_ip,axiom,
    ! [P] :
      ( iext(uri_rdf_type,P,uri_rdf_Property)
    <=> ip(P) ) ).

fof(rdfs_cext_def,axiom,
    ! [X,C] :
      ( iext(uri_rdf_type,X,C)
    <=> icext(C,X) ) ).

fof(rdfs_domain_main,axiom,
    ! [P,C,X,Y] :
      ( ( iext(uri_rdfs_domain,P,C)
        & iext(P,X,Y) )
     => icext(C,X) ) ).

fof(rdfs_domain_domain,axiom,
    iext(uri_rdfs_domain,uri_rdfs_domain,uri_rdf_Property) ).

fof(rdfs_subclassof_domain,axiom,
    iext(uri_rdfs_domain,uri_rdfs_subClassOf,uri_rdfs_Class) ).

fof(owl_prop_equivalentclass_type,axiom,
    ip(uri_owl_equivalentClass) ).

fof(owl_prop_equivalentclass_ext,axiom,
    ! [X,Y] :
      ( iext(uri_owl_equivalentClass,X,Y)
     => ( ic(X)
        & ic(Y) ) ) ).

fof(owl_rdfsext_subclassof,axiom,
    ! [C1,C2] :
      ( iext(uri_rdfs_subClassOf,C1,C2)
    <=> ( ic(C1)
        & ic(C2)
        & ! [X] :
            ( icext(C1,X)
           => icext(C2,X) ) ) ) ).

fof(owl_rdfsext_subpropertyof,axiom,
    ! [P1,P2] :
      ( iext(uri_rdfs_subPropertyOf,P1,P2)
    <=> ( ip(P1)
        & ip(P2)
        & ! [X,Y] :
            ( iext(P1,X,Y)
           => iext(P2,X,Y) ) ) ) ).

fof(owl_eqdis_equivalentclass,axiom,
    ! [C1,C2] :
      ( iext(uri_owl_equivalentClass,C1,C2)
    <=> ( ic(C1)
        & ic(C2)
        & ! [X] :
            ( icext(C1,X)
          <=> icext(C2,X) ) ) ) ).

fof(testcase_conclusion_fullish_016_Reflective_Tautologies_II,conjecture,
    iext(uri_rdfs_subPropertyOf,uri_owl_equivalentClass,uri_rdfs_subClassOf) ).

%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
% File     : SWB009+2 : TPTP v9.2.1. Released v5.2.0.
% Domain   : Semantic Web
% Problem  : Existential Restriction Entailments
% Version  : [Sch11] axioms : Reduced > Incomplete.
% English  :

% Refs     : [Sch11] Schneider, M. (2011), Email to G. Sutcliffe
% Source   : [Sch11]
% Names    : 009_Existential_Restriction_Entailments [Sch11]

% Status   : Theorem
% Rating   : 0.05 v9.1.0, 0.00 v7.5.0, 0.05 v7.4.0, 0.00 v7.0.0, 0.07 v6.3.0, 0.00 v6.1.0, 0.08 v6.0.0, 0.00 v5.5.0, 0.04 v5.3.0, 0.13 v5.2.0
% Syntax   : Number of formulae    :    4 (   0 unt;   0 def)
%            Number of atoms       :   15 (   0 equ)
%            Maximal formula atoms :    6 (   3 avg)
%            Number of connectives :   11 (   0   ~;   0   |;   8   &)
%                                         (   2 <=>;   1  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    9 (   6 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    2 (   2 usr;   0 prp; 2-3 aty)
%            Number of functors    :    9 (   9 usr;   9 con; 0-0 aty)
%            Number of variables   :    9 (   6   !;   3   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%------------------------------------------------------------------------------
fof(rdfs_cext_def,axiom,
    ! [X,C] :
      ( iext(uri_rdf_type,X,C)
    <=> icext(C,X) ) ).

fof(owl_restrict_somevaluesfrom,axiom,
    ! [Z,P,C] :
      ( ( iext(uri_owl_someValuesFrom,Z,C)
        & iext(uri_owl_onProperty,Z,P) )
     => ! [X] :
          ( icext(Z,X)
        <=> ? [Y] :
              ( iext(P,X,Y)
              & icext(C,Y) ) ) ) ).

fof(testcase_conclusion_fullish_009_Existential_Restriction_Entailments,conjecture,
    ? [BNODE_x] :
      ( iext(uri_ex_p,uri_ex_s,BNODE_x)
      & iext(uri_rdf_type,BNODE_x,uri_ex_c) ) ).

fof(testcase_premise_fullish_009_Existential_Restriction_Entailments,axiom,
    ? [BNODE_z] :
      ( iext(uri_rdf_type,uri_ex_p,uri_owl_ObjectProperty)
      & iext(uri_rdf_type,uri_ex_c,uri_owl_Class)
      & iext(uri_rdf_type,uri_ex_s,BNODE_z)
      & iext(uri_rdf_type,BNODE_z,uri_owl_Restriction)
      & iext(uri_owl_onProperty,BNODE_z,uri_ex_p)
      & iext(uri_owl_someValuesFrom,BNODE_z,uri_ex_c) ) ).

%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
% File     : KRS137+1 : TPTP v9.2.1. Released v3.1.0.
% Domain   : Knowledge Representation (Semantic Web)
% Problem  : A variation of equivalentClass-001
% Version  : Especial.
% English  : This is a variation of equivalentClass-001, showing the use of
%            owl:Ontology triples in the premises and conclusions.

% Refs     : [Bec03] Bechhofer (2003), Email to G. Sutcliffe
%          : [TR+04] Tsarkov et al. (2004), Using Vampire to Reason with OW
% Source   : [Bec03]
% Names    : positive_Ontology-Manifest001 [Bec03]

% Status   : Theorem
% Rating   : 0.00 v5.3.0, 0.09 v5.2.0, 0.00 v3.1.0
% Syntax   : Number of formulae    :    8 (   4 unt;   0 def)
%            Number of atoms       :   18 (   0 equ)
%            Maximal formula atoms :    8 (   2 avg)
%            Number of connectives :   14 (   4   ~;   0   |;   7   &)
%                                         (   3 <=>;   0  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    6 (   3 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    6 (   6 usr;   0 prp; 1-1 aty)
%            Number of functors    :    2 (   2 usr;   2 con; 0-0 aty)
%            Number of variables   :    5 (   5   !;   0   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments : Sean Bechhofer says there are some errors in the encoding of
%            datatypes, so this problem may not be perfect. At least it's
%            still representative of the type of reasoning required for OWL.
%------------------------------------------------------------------------------
%----Thing and Nothing
fof(axiom_0,axiom,
    ! [X] :
      ( cowlThing(X)
      & ~ cowlNothing(X) ) ).

%----String and Integer disjoint
fof(axiom_1,axiom,
    ! [X] :
      ( xsd_string(X)
    <=> ~ xsd_integer(X) ) ).

%----Equality cCar
fof(axiom_2,axiom,
    ! [X] :
      ( cCar(X)
    <=> cAutomobile(X) ) ).

%----iauto
fof(axiom_3,axiom,
    cowlThing(iauto) ).

%----iauto
fof(axiom_4,axiom,
    cAutomobile(iauto) ).

%----icar
fof(axiom_5,axiom,
    cowlThing(icar) ).

%----icar
fof(axiom_6,axiom,
    cCar(icar) ).

%----Thing and Nothing
%----String and Integer disjoint
%----iauto
%----iauto
%----icar
%----icar
fof(the_axiom,conjecture,
    ( ! [X] :
        ( cowlThing(X)
        & ~ cowlNothing(X) )
    & ! [X] :
        ( xsd_string(X)
      <=> ~ xsd_integer(X) )
    & cCar(iauto)
    & cowlThing(iauto)
    & cowlThing(icar)
    & cAutomobile(icar) ) ).

%------------------------------------------------------------------------------

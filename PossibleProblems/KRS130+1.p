%------------------------------------------------------------------------------
% File     : KRS130+1 : TPTP v9.2.1. Released v3.1.0.
% Domain   : Knowledge Representation (Semantic Web)
% Problem  : owl:Nothing can be defined using OWL Lite restrictions
% Version  : Especial.
% English  : A class like owl:Nothing can be defined using OWL Lite
%            restrictions.

% Refs     : [Bec03] Bechhofer (2003), Email to G. Sutcliffe
%          : [TR+04] Tsarkov et al. (2004), Using Vampire to Reason with OW
% Source   : [Bec03]
% Names    : positive_I5.2-Manifest002 [Bec03]

% Status   : Theorem
% Rating   : 0.00 v6.1.0, 0.04 v6.0.0, 0.25 v5.5.0, 0.12 v5.4.0, 0.04 v5.3.0, 0.13 v5.2.0, 0.00 v3.2.0, 0.11 v3.1.0
% Syntax   : Number of formulae    :    5 (   0 unt;   0 def)
%            Number of atoms       :   14 (   0 equ)
%            Maximal formula atoms :    6 (   2 avg)
%            Number of connectives :   14 (   5   ~;   0   |;   4   &)
%                                         (   3 <=>;   2  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    6 (   5 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    6 (   6 usr;   0 prp; 1-2 aty)
%            Number of functors    :    0 (   0 usr;   0 con; --- aty)
%            Number of variables   :    9 (   7   !;   2   ?)
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

%----Super cNothing
fof(axiom_2,axiom,
    ! [X] :
      ( cNothing(X)
     => ~ ? [Y] : rp(X,Y) ) ).

%----Super cNothing
fof(axiom_3,axiom,
    ! [X] :
      ( cNothing(X)
     => ? [Y0] : rp(X,Y0) ) ).

%----Thing and Nothing
%----String and Integer disjoint
%----Equality cNothing
fof(the_axiom,conjecture,
    ( ! [X] :
        ( cowlThing(X)
        & ~ cowlNothing(X) )
    & ! [X] :
        ( xsd_string(X)
      <=> ~ xsd_integer(X) )
    & ! [X] :
        ( cNothing(X)
      <=> cowlNothing(X) ) ) ).

%------------------------------------------------------------------------------

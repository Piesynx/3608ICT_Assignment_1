%------------------------------------------------------------------------------
% File     : KRS171+1 : TPTP v9.2.1. Released v3.1.0.
% Domain   : Knowledge Representation (Semantic Web)
% Problem  : The inverse entailment of test 002 also holds
% Version  : Especial.
% English  :

% Refs     : [Bec03] Bechhofer (2003), Email to G. Sutcliffe
%          : [TR+04] Tsarkov et al. (2004), Using Vampire to Reason with OW
% Source   : [Bec03]
% Names    : positive_equivalentProperty-Manifest003 [Bec03]

% Status   : Theorem
% Rating   : 0.00 v3.1.0
% Syntax   : Number of formulae    :    5 (   0 unt;   0 def)
%            Number of atoms       :   14 (   0 equ)
%            Maximal formula atoms :    6 (   2 avg)
%            Number of connectives :   13 (   4   ~;   0   |;   4   &)
%                                         (   3 <=>;   2  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    6 (   4 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    6 (   6 usr;   0 prp; 1-2 aty)
%            Number of functors    :    0 (   0 usr;   0 con; --- aty)
%            Number of variables   :   10 (  10   !;   0   ?)
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

fof(axiom_2,axiom,
    ! [X,Y] :
      ( rhasHead(X,Y)
     => rhasLeader(X,Y) ) ).

fof(axiom_3,axiom,
    ! [X,Y] :
      ( rhasLeader(X,Y)
     => rhasHead(X,Y) ) ).

%----Thing and Nothing
%----String and Integer disjoint
fof(the_axiom,conjecture,
    ( ! [X] :
        ( cowlThing(X)
        & ~ cowlNothing(X) )
    & ! [X] :
        ( xsd_string(X)
      <=> ~ xsd_integer(X) )
    & ! [X,Y] :
        ( rhasLeader(X,Y)
      <=> rhasHead(X,Y) ) ) ).

%------------------------------------------------------------------------------

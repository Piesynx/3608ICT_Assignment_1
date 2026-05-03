%------------------------------------------------------------------------------
% File     : KRS131+1 : TPTP v9.2.1. Released v3.1.0.
% Domain   : Knowledge Representation (Semantic Web)
% Problem  : The complement of a class can be defined
% Version  : Especial.
% English  : The complement of a class can be defined using OWL Lite
%            restrictions.

% Refs     : [Bec03] Bechhofer (2003), Email to G. Sutcliffe
%          : [TR+04] Tsarkov et al. (2004), Using Vampire to Reason with OW
% Source   : [Bec03]
% Names    : positive_I5.2-Manifest004 [Bec03]

% Status   : Theorem
% Rating   : 0.00 v9.1.0, 0.13 v9.0.0, 0.00 v8.2.0, 0.07 v8.1.0, 0.00 v6.3.0, 0.08 v6.2.0, 0.00 v6.1.0, 0.04 v6.0.0, 0.25 v5.5.0, 0.12 v5.4.0, 0.13 v5.2.0, 0.07 v5.0.0, 0.05 v4.1.0, 0.06 v4.0.1, 0.05 v3.7.0, 0.33 v3.5.0, 0.12 v3.4.0, 0.08 v3.3.0, 0.00 v3.2.0, 0.22 v3.1.0
% Syntax   : Number of formulae    :    7 (   0 unt;   0 def)
%            Number of atoms       :   20 (   0 equ)
%            Maximal formula atoms :    6 (   2 avg)
%            Number of connectives :   19 (   6   ~;   0   |;   5   &)
%                                         (   5 <=>;   3  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    6 (   5 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    9 (   9 usr;   0 prp; 1-2 aty)
%            Number of functors    :    0 (   0 usr;   0 con; --- aty)
%            Number of variables   :   13 (  10   !;   3   ?)
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

%----Equality cA
fof(axiom_2,axiom,
    ! [X] :
      ( cA(X)
    <=> ? [Y] :
          ( rq(X,Y)
          & cowlThing(Y) ) ) ).

%----Super cNothing
fof(axiom_3,axiom,
    ! [X] :
      ( cNothing(X)
     => ~ ? [Y] : rp(X,Y) ) ).

%----Super cNothing
fof(axiom_4,axiom,
    ! [X] :
      ( cNothing(X)
     => ? [Y0] : rp(X,Y0) ) ).

%----Equality cnotA
fof(axiom_5,axiom,
    ! [X] :
      ( cnotA(X)
    <=> ! [Y] :
          ( rq(X,Y)
         => cNothing(Y) ) ) ).

%----Thing and Nothing
%----String and Integer disjoint
%----Equality cnotA
fof(the_axiom,conjecture,
    ( ! [X] :
        ( cowlThing(X)
        & ~ cowlNothing(X) )
    & ! [X] :
        ( xsd_string(X)
      <=> ~ xsd_integer(X) )
    & ! [X] :
        ( cnotA(X)
      <=> ~ cA(X) ) ) ).

%------------------------------------------------------------------------------

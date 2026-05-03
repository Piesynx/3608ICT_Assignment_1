%------------------------------------------------------------------------------
% File     : KRS139+1 : TPTP v9.2.1. Released v3.1.0.
% Domain   : Knowledge Representation (Semantic Web)
% Problem  : A Lite version of test SymmetricProperty-001
% Version  : Especial.
% English  :

% Refs     : [Bec03] Bechhofer (2003), Email to G. Sutcliffe
%          : [TR+04] Tsarkov et al. (2004), Using Vampire to Reason with OW
% Source   : [Bec03]
% Names    : positive_SymmetricProperty-Manifest003 [Bec03]

% Status   : Theorem
% Rating   : 0.00 v5.3.0, 0.09 v5.2.0, 0.00 v3.1.0
% Syntax   : Number of formulae    :    7 (   3 unt;   0 def)
%            Number of atoms       :   16 (   0 equ)
%            Maximal formula atoms :    7 (   2 avg)
%            Number of connectives :   13 (   4   ~;   0   |;   6   &)
%                                         (   2 <=>;   1  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    6 (   3 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    5 (   5 usr;   0 prp; 1-2 aty)
%            Number of functors    :    2 (   2 usr;   2 con; 0-0 aty)
%            Number of variables   :    6 (   6   !;   0   ?)
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

%----Symmetric: rpath
fof(axiom_2,axiom,
    ! [X,Y] :
      ( rpath(X,Y)
     => rpath(Y,X) ) ).

%----iAntwerp
fof(axiom_3,axiom,
    cowlThing(iAntwerp) ).

%----iGhent
fof(axiom_4,axiom,
    cowlThing(iGhent) ).

fof(axiom_5,axiom,
    rpath(iGhent,iAntwerp) ).

%----Thing and Nothing
%----String and Integer disjoint
%----iAntwerp
%----iGhent
fof(the_axiom,conjecture,
    ( ! [X] :
        ( cowlThing(X)
        & ~ cowlNothing(X) )
    & ! [X] :
        ( xsd_string(X)
      <=> ~ xsd_integer(X) )
    & cowlThing(iAntwerp)
    & rpath(iAntwerp,iGhent)
    & cowlThing(iGhent) ) ).

%------------------------------------------------------------------------------

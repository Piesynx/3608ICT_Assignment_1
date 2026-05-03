%------------------------------------------------------------------------------
% File     : KRS141+1 : TPTP v9.2.1. Released v3.1.0.
% Domain   : Knowledge Representation (Semantic Web)
% Problem  : A simple example
% Version  : Especial.
% English  :

% Refs     : [Bec03] Bechhofer (2003), Email to G. Sutcliffe
%          : [TR+04] Tsarkov et al. (2004), Using Vampire to Reason with OW
% Source   : [Bec03]
% Names    : positive_allValuesFrom-Manifest001 [Bec03]

% Status   : Theorem
% Rating   : 0.00 v3.1.0
% Syntax   : Number of formulae    :    8 (   4 unt;   0 def)
%            Number of atoms       :   17 (   0 equ)
%            Maximal formula atoms :    6 (   2 avg)
%            Number of connectives :   13 (   4   ~;   0   |;   5   &)
%                                         (   2 <=>;   2  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    6 (   3 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    7 (   7 usr;   0 prp; 1-2 aty)
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

%----Super cr
fof(axiom_2,axiom,
    ! [X] :
      ( cr(X)
     => ! [Y] :
          ( rp(X,Y)
         => cc(Y) ) ) ).

%----ii
fof(axiom_3,axiom,
    cr(ii) ).

%----ii
fof(axiom_4,axiom,
    cowlThing(ii) ).

fof(axiom_5,axiom,
    rp(ii,io) ).

%----io
fof(axiom_6,axiom,
    cowlThing(io) ).

%----Thing and Nothing
%----String and Integer disjoint
%----io
%----io
fof(the_axiom,conjecture,
    ( ! [X] :
        ( cowlThing(X)
        & ~ cowlNothing(X) )
    & ! [X] :
        ( xsd_string(X)
      <=> ~ xsd_integer(X) )
    & cc(io)
    & cowlThing(io) ) ).

%------------------------------------------------------------------------------

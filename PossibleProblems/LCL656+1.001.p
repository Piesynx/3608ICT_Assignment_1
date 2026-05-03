%------------------------------------------------------------------------------
% File     : LCL656+1.001 : TPTP v9.2.1. Released v4.0.0.
% Domain   : Logic Calculi (Modal Logic)
% Problem  : In KT, the branching formula made provable, size 1
% Version  : Especial.
% English  : The branching formula plus a negation symbol in front and an
%            additional subformula to make the formula provable.

% Refs     : [BHS00] Balsiger et al. (2000), A Benchmark Method for the Pro
%          : [Kam08] Kaminski (2008), Email to G. Sutcliffe
% Source   : [Kam08]
% Names    : kt_branch_p [BHS00]

% Status   : Theorem
% Rating   : 0.00 v9.1.0, 0.07 v9.0.0, 0.00 v6.3.0, 0.08 v6.2.0, 0.00 v6.1.0, 0.04 v6.0.0, 0.25 v5.5.0, 0.08 v5.4.0, 0.09 v5.3.0, 0.17 v5.2.0, 0.07 v5.0.0, 0.05 v4.1.0, 0.06 v4.0.1, 0.05 v4.0.0
% Syntax   : Number of formulae    :    2 (   1 unt;   0 def)
%            Number of atoms       :   38 (   0 equ)
%            Maximal formula atoms :   37 (  19 avg)
%            Number of connectives :   70 (  34   ~;  22   |;  14   &)
%                                         (   0 <=>;   0  =>;   0  <=;   0 <~>)
%            Maximal formula depth :   19 (  11 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    6 (   6 usr;   0 prp; 1-2 aty)
%            Number of functors    :    0 (   0 usr;   0 con; --- aty)
%            Number of variables   :   10 (   9   !;   1   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments : A naive relational encoding of the modal logic problem into
%            first-order logic.
%------------------------------------------------------------------------------
fof(reflexivity,axiom,
    ! [X] : r1(X,X) ).

fof(main,conjecture,
    ~ ? [X] :
        ~ ( ~ ! [Y] :
                ( ~ r1(X,Y)
                | p2(Y) )
          | ~ ( ! [Y] :
                  ( ~ r1(X,Y)
                  | ( ( ( ~ ! [X] :
                              ( ~ r1(Y,X)
                              | ~ ( ~ p2(X)
                                  & ~ p102(X)
                                  & p101(X) ) )
                        & ~ ! [X] :
                              ( ~ r1(Y,X)
                              | ~ ( p2(X)
                                  & ~ p102(X)
                                  & p101(X) ) ) )
                      | ~ ( ~ p101(Y)
                          & p100(Y) ) )
                    & ( ( ( ! [X] :
                              ( ~ r1(Y,X)
                              | ~ p2(X)
                              | ~ p101(X) )
                          | p2(Y) )
                        & ( ! [X] :
                              ( ~ r1(Y,X)
                              | p2(X)
                              | ~ p101(X) )
                          | ~ p2(Y) ) )
                      | ~ p101(Y) )
                    & ( ( ( ! [X] :
                              ( ~ r1(Y,X)
                              | ~ p1(X)
                              | ~ p100(X) )
                          | p1(Y) )
                        & ( ! [X] :
                              ( ~ r1(Y,X)
                              | p1(X)
                              | ~ p100(X) )
                          | ~ p1(Y) ) )
                      | ~ p100(Y) )
                    & ( p101(Y)
                      | ~ p102(Y) )
                    & ( p100(Y)
                      | ~ p101(Y) ) ) )
              & ~ p101(X)
              & p100(X) ) ) ).

%------------------------------------------------------------------------------

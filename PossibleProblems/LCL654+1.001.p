%------------------------------------------------------------------------------
% File     : LCL654+1.001 : TPTP v9.2.1. Released v4.0.0.
% Domain   : Logic Calculi (Modal Logic)
% Problem  : In KT, A5{box p0/p0} & box A5{~p0/p0} -> A4, size 1
% Version  : Especial.
% English  :

% Refs     : [BHS00] Balsiger et al. (2000), A Benchmark Method for the Pro
%          : [Kam08] Kaminski (2008), Email to G. Sutcliffe
% Source   : [Kam08]
% Names    : kt_45_p [BHS00]

% Status   : Theorem
% Rating   : 0.10 v9.1.0, 0.13 v9.0.0, 0.00 v7.5.0, 0.05 v7.4.0, 0.00 v6.3.0, 0.08 v6.2.0, 0.00 v6.1.0, 0.08 v6.0.0, 0.25 v5.5.0, 0.17 v5.3.0, 0.26 v5.2.0, 0.07 v5.0.0, 0.10 v4.1.0, 0.11 v4.0.1, 0.16 v4.0.0
% Syntax   : Number of formulae    :    2 (   1 unt;   0 def)
%            Number of atoms       :   30 (   0 equ)
%            Maximal formula atoms :   29 (  15 avg)
%            Number of connectives :   70 (  42   ~;  25   |;   3   &)
%                                         (   0 <=>;   0  =>;   0  <=;   0 <~>)
%            Maximal formula depth :   22 (  12 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    3 (   2 usr;   1 prp; 0-2 aty)
%            Number of functors    :    0 (   0 usr;   0 con; --- aty)
%            Number of variables   :   22 (  21   !;   1   ?)
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
                | ~ ( ~ ! [X] :
                          ( ~ r1(Y,X)
                          | ~ ! [Y] :
                                ( ~ r1(X,Y)
                                | ~ p1(Y) ) )
                    & p1(Y) ) )
          | ~ ! [Y] :
                ( ~ r1(X,Y)
                | ! [X] :
                    ( ~ r1(Y,X)
                    | ~ ( ~ ! [Y] :
                              ( ~ r1(X,Y)
                              | ~ ! [X] :
                                    ( ~ r1(Y,X)
                                    | p1(X) ) )
                        & ~ ! [Y] :
                              ( ~ r1(X,Y)
                              | p1(Y) ) ) ) )
          | ~ ! [Y] :
                ( ~ r1(X,Y)
                | ~ ( ~ ! [X] :
                          ( ~ r1(Y,X)
                          | ~ ! [Y] :
                                ( ~ r1(X,Y)
                                | ~ ! [X] :
                                      ( ~ r1(Y,X)
                                      | p1(X) ) ) )
                    & ~ ! [X] :
                          ( ~ r1(Y,X)
                          | ~ ! [Y] :
                                ( ~ r1(X,Y)
                                | p1(Y) ) ) ) )
          | ~ ! [Y] :
                ( ~ r1(X,Y)
                | ~ ! [X] :
                      ( ~ r1(Y,X)
                      | $false ) )
          | ! [Y] :
              ( ~ r1(X,Y)
              | ! [X] :
                  ( ~ r1(Y,X)
                  | ! [Y] :
                      ( ~ r1(X,Y)
                      | p1(Y) ) )
              | ~ ! [X] :
                    ( ~ r1(Y,X)
                    | p1(X) ) ) ) ).

%------------------------------------------------------------------------------

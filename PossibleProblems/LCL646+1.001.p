%------------------------------------------------------------------------------
% File     : LCL646+1.001 : TPTP v9.2.1. Released v4.0.0.
% Domain   : Logic Calculi (Modal Logic)
% Problem  : In K, path through a labyrinth, size 1
% Version  : Especial.
% English  :

% Refs     : [BHS00] Balsiger et al. (2000), A Benchmark Method for the Pro
%          : [Kam08] Kaminski (2008), Email to G. Sutcliffe
% Source   : [Kam08]
% Names    : k_path_p [BHS00]

% Status   : Theorem
% Rating   : 0.00 v5.3.0, 0.09 v5.2.0, 0.00 v4.1.0, 0.06 v4.0.1, 0.05 v4.0.0
% Syntax   : Number of formulae    :    1 (   0 unt;   0 def)
%            Number of atoms       :   16 (   0 equ)
%            Maximal formula atoms :   16 (  16 avg)
%            Number of connectives :   29 (  14   ~;  15   |;   0   &)
%                                         (   0 <=>;   0  =>;   0  <=;   0 <~>)
%            Maximal formula depth :   14 (  14 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    7 (   7 usr;   0 prp; 1-2 aty)
%            Number of functors    :    0 (   0 usr;   0 con; --- aty)
%            Number of variables   :    9 (   8   !;   1   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments : A naive relational encoding of the modal logic problem into
%            first-order logic.
%------------------------------------------------------------------------------
fof(main,conjecture,
    ~ ? [X] :
        ~ ( ~ ! [Y] :
                ( ~ r1(X,Y)
                | p6(Y) )
          | ~ ! [Y] :
                ( ~ r1(X,Y)
                | p2(Y) )
          | ~ ! [Y] :
                ( ~ r1(X,Y)
                | p4(Y) )
          | ~ ! [Y] :
                ( ~ r1(X,Y)
                | p2(Y) )
          | ! [Y] :
              ( ~ r1(X,Y)
              | p5(Y) )
          | ! [Y] :
              ( ~ r1(X,Y)
              | p3(Y) )
          | ! [Y] :
              ( ~ r1(X,Y)
              | p2(Y) )
          | ! [Y] :
              ( ~ r1(X,Y)
              | p1(Y) ) ) ).

%------------------------------------------------------------------------------

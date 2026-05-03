%--------------------------------------------------------------------------
% File     : SET576+3 : TPTP v9.2.1. Released v2.2.0.
% Domain   : Set Theory
% Problem  : Trybulec's 17th Boolean property of sets
% Version  : [Try90] axioms : Reduced > Incomplete.
% English  :

% Refs     : [ILF] The ILF Group (1998), The ILF System: A Tool for the Int
%          : [Try90] Trybulec (1990), Tarski Grothendieck Set Theory
%          : [TS89]  Trybulec & Swieczkowska (1989), Boolean Properties of
% Source   : [ILF]
% Names    : BOOLE (17) [TS89]

% Status   : Theorem
% Rating   : 0.00 v6.3.0, 0.08 v6.2.0, 0.00 v6.0.0, 0.25 v5.5.0, 0.00 v5.3.0, 0.09 v5.2.0, 0.00 v3.2.0, 0.11 v3.1.0, 0.00 v2.2.1
% Syntax   : Number of formulae    :    4 (   0 unt;   0 def)
%            Number of atoms       :   10 (   0 equ)
%            Maximal formula atoms :    3 (   2 avg)
%            Number of connectives :    8 (   2   ~;   0   |;   1   &)
%                                         (   2 <=>;   3  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    7 (   6 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    3 (   3 usr;   0 prp; 2-2 aty)
%            Number of functors    :    0 (   0 usr;   0 con; --- aty)
%            Number of variables   :   10 (   9   !;   1   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%--------------------------------------------------------------------------
%---- line(boole - df(5),1833080)
fof(intersect_defn,axiom,
    ! [B,C] :
      ( intersect(B,C)
    <=> ? [D] :
          ( member(D,B)
          & member(D,C) ) ) ).

%---- line(boole - axiom10,1833083)
fof(disjoint_defn,axiom,
    ! [B,C] :
      ( disjoint(B,C)
    <=> ~ intersect(B,C) ) ).

%---- property(symmetry,op(intersect,2,predicate))
fof(symmetry_of_intersect,axiom,
    ! [B,C] :
      ( intersect(B,C)
     => intersect(C,B) ) ).

%---- line(boole - th(17),1833112)
fof(prove_th17,conjecture,
    ! [B,C] :
      ( ! [D] :
          ( member(D,B)
         => ~ member(D,C) )
     => disjoint(B,C) ) ).

%--------------------------------------------------------------------------

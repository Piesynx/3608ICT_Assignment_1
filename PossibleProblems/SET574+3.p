%--------------------------------------------------------------------------
% File     : SET574+3 : TPTP v9.2.1. Released v2.2.0.
% Domain   : Set Theory
% Problem  : Trybulec's 13th Boolean property of sets
% Version  : [Try90] axioms : Reduced > Incomplete.
% English  :

% Refs     : [ILF] The ILF Group (1998), The ILF System: A Tool for the Int
%          : [Try90] Trybulec (1990), Tarski Grothendieck Set Theory
%          : [TS89]  Trybulec & Swieczkowska (1989), Boolean Properties of
% Source   : [ILF]
% Names    : BOOLE (13) [TS89]

% Status   : Theorem
% Rating   : 0.05 v9.1.0, 0.07 v9.0.0, 0.00 v8.2.0, 0.07 v8.1.0, 0.00 v5.3.0, 0.09 v5.2.0, 0.00 v2.2.1
% Syntax   : Number of formulae    :    3 (   0 unt;   0 def)
%            Number of atoms       :    8 (   0 equ)
%            Maximal formula atoms :    3 (   2 avg)
%            Number of connectives :    5 (   0   ~;   0   |;   2   &)
%                                         (   1 <=>;   2  =>;   0  <=;   0 <~>)
%            Maximal formula depth :    6 (   5 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    2 (   2 usr;   0 prp; 2-2 aty)
%            Number of functors    :    0 (   0 usr;   0 con; --- aty)
%            Number of variables   :    8 (   7   !;   1   ?)
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

%---- property(symmetry,op(intersect,2,predicate))
fof(symmetry_of_intersect,axiom,
    ! [B,C] :
      ( intersect(B,C)
     => intersect(C,B) ) ).

%---- line(boole - th(13),1833110)
fof(prove_th13,conjecture,
    ! [B,C,D] :
      ( ( member(B,C)
        & member(B,D) )
     => intersect(C,D) ) ).

%--------------------------------------------------------------------------

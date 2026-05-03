%------------------------------------------------------------------------------
% File     : KRS181+1 : TPTP v9.2.1. Bugfixed v5.4.0.
% Domain   : Knowledge Representation
% Problem  : If S1 isa S2, and S1 nota S3, then S2 nota S3
% Version  : [Sut08] axioms.
% English  :

% Refs     : [Sut08] Sutcliffe (2008), The SZS Ontologies for Automated Rea
% Source   : [TPTP]
% Names    :

% Status   : Theorem
% Rating   : 0.05 v9.1.0, 0.13 v9.0.0, 0.12 v8.2.0, 0.20 v8.1.0, 0.07 v7.5.0, 0.10 v7.4.0, 0.12 v7.3.0, 0.29 v7.2.0, 0.17 v7.1.0, 0.25 v7.0.0, 0.00 v6.1.0, 0.08 v6.0.0, 0.00 v5.5.0, 0.04 v5.4.0
% Syntax   : Number of formulae    :   14 (   2 unt;   0 def)
%            Number of atoms       :   39 (   0 equ)
%            Maximal formula atoms :    6 (   2 avg)
%            Number of connectives :   35 (  10   ~;   1   |;  12   &)
%                                         (   6 <=>;   4  =>;   0  <=;   2 <~>)
%            Maximal formula depth :    9 (   6 avg)
%            Maximal term depth    :    2 (   1 avg)
%            Number of predicates  :    7 (   7 usr;   0 prp; 2-3 aty)
%            Number of functors    :    1 (   1 usr;   0 con; 1-1 aty)
%            Number of variables   :   48 (  26   !;  22   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
% Bugfixes : v5.4.0 - Added missing axiom in KRS001+1.ax
%------------------------------------------------------------------------------
%----Include SZS success ontology node relationships
include('Axioms/KRS001+1.ax').
%------------------------------------------------------------------------------
fof(nota_isa_nota,conjecture,
    ! [S1,S2,S3] :
      ( ( isa(S1,S2)
        & nota(S1,S3) )
     => nota(S2,S3) ) ).

%------------------------------------------------------------------------------

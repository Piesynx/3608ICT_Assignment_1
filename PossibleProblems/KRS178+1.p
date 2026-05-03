%------------------------------------------------------------------------------
% File     : KRS178+1 : TPTP v9.2.1. Bugfixed v5.4.0.
% Domain   : Knowledge Representation
% Problem  : isa is exclusive of nota, nevera, and xora
% Version  : [Sut08] axioms.
% English  :

% Refs     : [Sut08] Sutcliffe (2008), The SZS Ontologies for Automated Rea
% Source   : [TPTP]
% Names    :

% Status   : Theorem
% Rating   : 0.00 v9.0.0, 0.06 v8.2.0, 0.07 v8.1.0, 0.00 v7.5.0, 0.05 v7.4.0, 0.06 v7.3.0, 0.14 v7.2.0, 0.00 v6.1.0, 0.04 v6.0.0, 0.00 v5.5.0, 0.04 v5.4.0
% Syntax   : Number of formulae    :   14 (   3 unt;   0 def)
%            Number of atoms       :   37 (   0 equ)
%            Maximal formula atoms :    6 (   2 avg)
%            Number of connectives :   33 (  10   ~;   1   |;  11   &)
%                                         (   6 <=>;   3  =>;   0  <=;   2 <~>)
%            Maximal formula depth :    9 (   6 avg)
%            Maximal term depth    :    2 (   1 avg)
%            Number of predicates  :    7 (   7 usr;   0 prp; 2-3 aty)
%            Number of functors    :    1 (   1 usr;   0 con; 1-1 aty)
%            Number of variables   :   46 (  24   !;  22   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
% Bugfixes : v5.4.0 - Added missing axiom in KRS001+1.ax
%------------------------------------------------------------------------------
%----Include SZS success ontology node relationships
include('Axioms/KRS001+1.ax').
%------------------------------------------------------------------------------
fof(isa_reflexive,conjecture,
    ! [S1] : isa(S1,S1) ).

%------------------------------------------------------------------------------

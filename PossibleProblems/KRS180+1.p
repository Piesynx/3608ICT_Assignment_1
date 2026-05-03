%------------------------------------------------------------------------------
% File     : KRS180+1 : TPTP v9.2.1. Bugfixed v5.4.0.
% Domain   : Knowledge Representation
% Problem  : isa is incompatible with nota, nevera, and xora
% Version  : [Sut08] axioms.
% English  :

% Refs     : [Sut08] Sutcliffe (2008), The SZS Ontologies for Automated Rea
% Source   : [TPTP]
% Names    :

% Status   : Theorem
% Rating   : 0.00 v9.1.0, 0.13 v9.0.0, 0.06 v8.2.0, 0.13 v8.1.0, 0.00 v7.5.0, 0.05 v7.4.0, 0.06 v7.3.0, 0.29 v7.2.0, 0.17 v7.1.0, 0.25 v7.0.0, 0.07 v6.3.0, 0.08 v6.2.0, 0.00 v6.1.0, 0.04 v6.0.0, 0.25 v5.5.0, 0.17 v5.4.0
% Syntax   : Number of formulae    :   14 (   2 unt;   0 def)
%            Number of atoms       :   41 (   0 equ)
%            Maximal formula atoms :    6 (   2 avg)
%            Number of connectives :   38 (  11   ~;   3   |;  12   &)
%                                         (   6 <=>;   4  =>;   0  <=;   2 <~>)
%            Maximal formula depth :   10 (   7 avg)
%            Maximal term depth    :    2 (   1 avg)
%            Number of predicates  :    7 (   7 usr;   0 prp; 2-3 aty)
%            Number of functors    :    1 (   1 usr;   0 con; 1-1 aty)
%            Number of variables   :   49 (  25   !;  24   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
% Bugfixes : v5.4.0 - Added missing axiom in KRS001+1.ax
%------------------------------------------------------------------------------
%----Include SZS success ontology node relationships
include('Axioms/KRS001+1.ax').
%------------------------------------------------------------------------------
fof(isa_exclusive,conjecture,
    ! [S1,S2] :
    ? [Ax,C] :
      ( status(Ax,C,S1)
     => ~ ( isa(S1,S2)
          & ( nota(S1,S2)
            | nevera(S1,S2)
            | xora(S1,S2) ) ) ) ).

%------------------------------------------------------------------------------

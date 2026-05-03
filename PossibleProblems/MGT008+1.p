%--------------------------------------------------------------------------
% File     : MGT008+1 : TPTP v9.2.1. Released v2.0.0.
% Domain   : Management (Organisation Theory)
% Problem  : Organizational death rates decrease with size.
% Version  : [PB+94] axioms.
% English  :

% Refs     : [PB+92] Peli et al. (1992), A Logical Approach to Formalizing
%          : [PB+94] Peli et al. (1994), A Logical Approach to Formalizing
%          : [Kam94] Kamps (1994), Email to G. Sutcliffe
% Source   : [Kam94]
% Names    : THEOREM 8 [PB+92]
%          : T8FOL1 [PB+94]

% Status   : Theorem
% Rating   : 0.00 v6.1.0, 0.04 v6.0.0, 0.50 v5.5.0, 0.12 v5.4.0, 0.13 v5.3.0, 0.22 v5.2.0, 0.00 v5.0.0, 0.05 v4.1.0, 0.06 v4.0.1, 0.05 v3.7.0, 0.00 v3.2.0, 0.11 v3.1.0, 0.00 v2.1.0
% Syntax   : Number of formulae    :    4 (   0 unt;   0 def)
%            Number of atoms       :   34 (   0 equ)
%            Maximal formula atoms :   12 (   8 avg)
%            Number of connectives :   30 (   0   ~;   0   |;  26   &)
%                                         (   0 <=>;   4  =>;   0  <=;   0 <~>)
%            Maximal formula depth :   21 (  16 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    7 (   7 usr;   0 prp; 2-3 aty)
%            Number of functors    :    0 (   0 usr;   0 con; --- aty)
%            Number of variables   :   29 (  28   !;   1   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%--------------------------------------------------------------------------
fof(mp5,axiom,
    ! [X,T] :
      ( organization(X,T)
     => ? [I] : inertia(X,I,T) ) ).

%----The level of structural inertia increases with size for each class
%----of organizations.
fof(a5_FOL,hypothesis,
    ! [X,Y,C,S1,S2,I1,I2,T1,T2] :
      ( ( organization(X,T1)
        & organization(Y,T2)
        & class(X,C,T1)
        & class(Y,C,T2)
        & size(X,S1,T1)
        & size(Y,S2,T2)
        & inertia(X,I1,T1)
        & inertia(Y,I2,T2)
        & greater(S2,S1) )
     => greater(I2,I1) ) ).

fof(t1_FOL,hypothesis,
    ! [X,Y,T1,T2,I1,I2,P1,P2] :
      ( ( organization(X,T1)
        & organization(Y,T2)
        & reorganization_free(X,T1,T1)
        & reorganization_free(Y,T2,T2)
        & inertia(X,I1,T1)
        & inertia(Y,I2,T2)
        & survival_chance(X,P1,T1)
        & survival_chance(Y,P2,T2)
        & greater(I2,I1) )
     => greater(P2,P1) ) ).

%----t8_FOL - alias a7_FOL
fof(t8_FOL,conjecture,
    ! [X,Y,C,P1,P2,S1,S2,T1,T2] :
      ( ( organization(X,T1)
        & organization(Y,T2)
        & reorganization_free(X,T1,T1)
        & reorganization_free(Y,T2,T2)
        & class(X,C,T1)
        & class(Y,C,T2)
        & survival_chance(X,P1,T1)
        & survival_chance(Y,P2,T2)
        & size(X,S1,T1)
        & size(Y,S2,T2)
        & greater(S2,S1) )
     => greater(P2,P1) ) ).

%--------------------------------------------------------------------------

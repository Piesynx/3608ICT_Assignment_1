%--------------------------------------------------------------------------
% File     : MGT009+1 : TPTP v9.2.1. Released v2.0.0.
% Domain   : Management (Organisation Theory)
% Problem  : Large organization have higher reproducibility
% Version  : [PB+94] axioms.
% English  :

% Refs     : [PB+92] Peli et al. (1992), A Logical Approach to Formalizing
%          : [PB+94] Peli et al. (1994), A Logical Approach to Formalizing
%          : [Kam94] Kamps (1994), Email to G. Sutcliffe
% Source   : [Kam94]
% Names    : THEOREM 9 [PB+92]
%          : T9FOL1 [PB+94]

% Status   : Theorem
% Rating   : 0.05 v9.1.0, 0.00 v7.5.0, 0.05 v7.4.0, 0.00 v7.0.0, 0.07 v6.4.0, 0.00 v6.3.0, 0.08 v6.2.0, 0.00 v6.1.0, 0.12 v6.0.0, 0.50 v5.5.0, 0.12 v5.4.0, 0.13 v5.3.0, 0.22 v5.2.0, 0.00 v3.2.0, 0.11 v3.1.0, 0.00 v2.1.0
% Syntax   : Number of formulae    :    4 (   0 unt;   0 def)
%            Number of atoms       :   34 (   0 equ)
%            Maximal formula atoms :   12 (   8 avg)
%            Number of connectives :   30 (   0   ~;   0   |;  25   &)
%                                         (   1 <=>;   4  =>;   0  <=;   0 <~>)
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

%----High levels of reproducibility of structure generate strong
%----inertial pressures.
fof(a3_FOL,hypothesis,
    ! [X,Y,T1,T2,Rp1,Rp2,I1,I2] :
      ( ( organization(X,T1)
        & organization(Y,T2)
        & reorganization_free(X,T1,T1)
        & reorganization_free(Y,T2,T2)
        & reproducibility(X,Rp1,T1)
        & reproducibility(Y,Rp2,T2)
        & inertia(X,I1,T1)
        & inertia(Y,I2,T2) )
     => ( greater(Rp2,Rp1)
      <=> greater(I2,I1) ) ) ).

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

fof(t9_FOL,conjecture,
    ! [X,Y,C,Rp1,Rp2,S1,S2,T1,T2] :
      ( ( organization(X,T1)
        & organization(Y,T2)
        & reorganization_free(X,T1,T1)
        & reorganization_free(Y,T2,T2)
        & class(X,C,T1)
        & class(Y,C,T2)
        & reproducibility(X,Rp1,T1)
        & reproducibility(Y,Rp2,T2)
        & size(X,S1,T1)
        & size(Y,S2,T2)
        & greater(S2,S1) )
     => greater(Rp2,Rp1) ) ).

%--------------------------------------------------------------------------

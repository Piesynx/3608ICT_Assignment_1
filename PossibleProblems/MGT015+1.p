%--------------------------------------------------------------------------
% File     : MGT015+1 : TPTP v9.2.1. Released v2.0.0.
% Domain   : Management (Organisation Theory)
% Problem  : Complexity increases the expected duration of reorganisation.
% Version  : [PB+94] axioms.
% English  :

% Refs     : [PB+94] Peli et al. (1994), A Logical Approach to Formalizing
%          : [Kam94] Kamps (1994), Email to G. Sutcliffe
%          : [Kam95] Kamps (1995), Email to G. Sutcliffe
% Source   : [Kam94]
% Names    :

% Status   : Theorem
% Rating   : 0.10 v9.1.0, 0.00 v6.3.0, 0.08 v6.2.0, 0.00 v6.1.0, 0.04 v6.0.0, 0.50 v5.5.0, 0.12 v5.4.0, 0.13 v5.3.0, 0.22 v5.2.0, 0.00 v5.0.0, 0.05 v4.1.0, 0.06 v4.0.1, 0.05 v3.7.0, 0.00 v3.2.0, 0.11 v3.1.0, 0.00 v2.1.0
% Syntax   : Number of formulae    :    4 (   0 unt;   0 def)
%            Number of atoms       :   38 (   0 equ)
%            Maximal formula atoms :   13 (   9 avg)
%            Number of connectives :   34 (   0   ~;   0   |;  30   &)
%                                         (   0 <=>;   4  =>;   0  <=;   0 <~>)
%            Maximal formula depth :   22 (  17 avg)
%            Maximal term depth    :    1 (   1 avg)
%            Number of predicates  :    7 (   7 usr;   0 prp; 2-3 aty)
%            Number of functors    :    0 (   0 usr;   0 con; --- aty)
%            Number of variables   :   30 (  29   !;   1   ?)
% SPC      : FOF_THM_RFO_NEQ

% Comments : "Not published due to publication constraints." [Kam95].
%--------------------------------------------------------------------------
fof(mp5,axiom,
    ! [X,T] :
      ( organization(X,T)
     => ? [I] : inertia(X,I,T) ) ).

fof(a12_FOL,hypothesis,
    ! [X,Y,C,C1,C2,I1,I2,T1,T2] :
      ( ( organization(X,T1)
        & organization(Y,T2)
        & class(X,C,T1)
        & class(Y,C,T2)
        & complexity(X,C1,T1)
        & complexity(Y,C2,T2)
        & inertia(X,I1,T1)
        & inertia(Y,I2,T2)
        & greater(C2,C1) )
     => greater(I2,I1) ) ).

%----The length of reorganizational period grows by the inertia the
%----organization begin s reorganization (if the organization with
%----higher inertia survives it).
fof(a13_FOL,hypothesis,
    ! [X,Y,Rt,C,I1,I2,Ta,Tb,Tc] :
      ( ( organization(X,Ta)
        & organization(Y,Ta)
        & organization(Y,Tc)
        & class(X,C,Ta)
        & class(Y,C,Ta)
        & reorganization(X,Ta,Tb)
        & reorganization(Y,Ta,Tc)
        & reorganization_type(X,Rt,Ta)
        & reorganization_type(Y,Rt,Ta)
        & inertia(X,I1,Ta)
        & inertia(Y,I2,Ta)
        & greater(I2,I1) )
     => greater(Tc,Tb) ) ).

%----t15_FOL - alias a10_FOL
%----Take care! If the set of complexity types is only partially ordered (as
%----we believe it), then ~greater(c1,c2) does not mean necessarily that
%----c2 is >= to c1. It means that if c1 and c2 are comparable,
%----THEN c2 is greater or equal to c1. [Kam94]
fof(t15_FOL,conjecture,
    ! [X,Y,Re,C,C1,C2,Ta,Tb,Tc] :
      ( ( organization(X,Ta)
        & organization(Y,Ta)
        & organization(Y,Tc)
        & class(X,C,Ta)
        & class(Y,C,Ta)
        & reorganization(X,Ta,Tb)
        & reorganization(Y,Ta,Tc)
        & reorganization_type(X,Re,Ta)
        & reorganization_type(Y,Re,Ta)
        & complexity(X,C1,Ta)
        & complexity(Y,C2,Ta)
        & greater(C2,C1) )
     => greater(Tc,Tb) ) ).

%--------------------------------------------------------------------------

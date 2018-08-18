clear all;

f = 4;
f0 = 4;

S11 = 0.75*exp(-1i*120*pi/180);
S21 = 2.5*exp(1i*80*pi/180);
S22 = 0.6*exp(-1i*70*pi/180);

GS_max = 1./(1-abs(S11).^2);
GL_max = 1./(1-abs(S22).^2);
% l/lamda
l1_S = 0.135;
l2_S = 0.06;
l1_L = 0.137;
l2_L = 0.428;

% GS(f)
zL_S = -1i*cot(2*pi*l2_S*f/f0);
%zL_S = zL_S/(1+zL_S);
zin_S = (zL_S + 1i*tan(2*pi*l1_S*f/f0))/(1 + 1i*zL_S*tan(2*pi*l1_S*f/f0));
Gamma_S = (zin_S-1)/(zin_S+1);
GS = GS_max * (1 - abs(Gamma_S)^2)*(1-abs(S11)^2)/abs(1-S11.*Gamma_S)^2;

% GL(f)
zL_L = -1i*cot(2*pi*l2_L*f/f0);
%zL_L = zL_L/(1+zL_L);
zin_L = (zL_L + 1i*tan(2*pi*l1_L*f/f0))/(1 + 1i*zL_L*tan(2*pi*l1_L*f/f0));
Gamma_L = (zin_L-1)/(zin_L+1);
GL = GL_max * (1 - abs(Gamma_L)^2)*(1-abs(S22)^2)/abs(1-S22*Gamma_L)^2;

S = zeros(16,16);
% Gamma Matrix
Gamma = zeros(16,16);
Gamma(1,2) = 1;
Gamma(2,1) = 1;
Gamma(3,6) = 1;
Gamma(4,8) = 1;
Gamma(5,14) = 1;
Gamma(6,3) = 1;
Gamma(7,10) = 1;
Gamma(8,4) = 1;
Gamma(9,13) = 1;
Gamma(10,7) = 1;
Gamma(11,15) = 1;
Gamma(12,16) = 1;
Gamma(13,9) = 1;
Gamma(14,5) = 1;
Gamma(15,11) = 1;
Gamma(16,12) = 1;

S_Hybrid = Hybrid_1(1);

% Amplifier

    A = (1+S11)*(1-S22)/(2*S21);
    B = (1+S11)*(1+S22)/(2*S21);
    C = (1-S11)*(1-S22)/(2*S21);
    D = (1-S11)*(1+S22)/(2*S21);
    
    ABCD1 = [A B;C D];
    ABCD2S = [1 0;1/zL_S 1];
    ABCD1S = [cos(2*pi*l1_S*f/f0) 1i*sin(2*pi*l1_S*f/f0); 1i*sin(2*pi*l1_S*f/f0) cos(2*pi*l1_S*f/f0)];
    ABCD2L = [1 0;1/zL_L 1];
    ABCD1L = [cos(2*pi*l1_L*f/f0) 1i*sin(2*pi*l1_L*f/f0); 1i*sin(2*pi*l1_L*f/f0) cos(2*pi*l1_L*f/f0)];
    
    ABCD = ABCD2S*ABCD1S*ABCD1*ABCD1L*ABCD2L;
    
    A = ABCD(1,1);
    B = ABCD(1,2);
    C = ABCD(2,1);
    D = ABCD(2,2);
    
    S11tot = (A+B-C-D)/(A+B+C+D);
    S12tot = 2*(A*D-B*C)/(A+B+C+D);
    S21tot = 2/(A+B+C+D);
    S22tot = (-A+B-C+D)/(A+B+C+D);
    
% 1st Hybrid
S(2,2) = S_Hybrid(1);
S(3,2) = S_Hybrid(2);
S(4,2) = S_Hybrid(3);
S(5,2) = S_Hybrid(4);
S(2,3) = S_Hybrid(2);
S(3,3) = S_Hybrid(1);
S(4,3) = S_Hybrid(4);
S(5,3) = S_Hybrid(3);
S(2,4) = S_Hybrid(3);
S(3,4) = S_Hybrid(4);
S(4,4) = S_Hybrid(1);
S(5,4) = S_Hybrid(2);
S(2,5) = S_Hybrid(4);
S(3,5) = S_Hybrid(3);
S(4,5) = S_Hybrid(2);
S(5,5) = S_Hybrid(1);

% 1st Amplifier
S(6,6) = S11tot;
S(6,7) = S12tot;
S(7,6) = S21tot;
S(7,7) = S22tot;

% 2nd Amplifier
S(8,8) = S11tot;
S(8,9) = S12tot;
S(9,8) = S21tot;
S(9,9) = S22tot;

% 2nd Hybrid
S(10,10) = S_Hybrid(1);
S(11,10) = S_Hybrid(2);
S(12,10) = S_Hybrid(3);
S(13,10) = S_Hybrid(4);
S(10,11) = S_Hybrid(2);
S(11,11) = S_Hybrid(1);
S(12,11) = S_Hybrid(4);
S(13,11) = S_Hybrid(3);
S(10,12) = S_Hybrid(3);
S(11,12) = S_Hybrid(4);
S(12,12) = S_Hybrid(1);
S(13,12) = S_Hybrid(2);
S(10,13) = S_Hybrid(4);
S(11,13) = S_Hybrid(3);
S(12,13) = S_Hybrid(2);
S(13,13) = S_Hybrid(1);

% Calculation
W = S - Gamma;
c = zeros(16,1);
c(1) = 1;
a = W\c;
b = Gamma*a;

% GT, RL
GT = 20*log10(abs(a(16))/abs(b(1)));
RL = -20*log10(abs(a(1))/abs(b(1)));
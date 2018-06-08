%  constants
u = 10^(-6);
p = 10^(-12);

kp       = 2.9352 * 10^(-5) ;
kn       = 9.6379 * 10^(-5);
Vop      = 180.2*10^-4;
Von      = 591.7*10^-4;
Cox      = kp/Vop;
VToP     = -0.9056;
VToN     = 0.7860;
lp       = 0.07;
ln       = 0.06;

Vinmax   = 0.1;
Vinmin   = - Vinmax;


% specifications
x = 9;
VDD = 1.8+0.003 * x ;
CL = (2+0.01*x)*p;
SR = (18+0.01*x) *1/u ; 
VSS = -VDD;
GBmin = (7+0.01*x)*10^6; 
Amin = (20+0.01*x); 
Pmax = (50+0.01*x); 
 
% step 1
L = 0.7 * u;

% step 2
Cc = 0.22 * CL + 0.2*p; % ----

% step 3
I5 = Cc * SR;

% step 4
S3 = I5 /(kn * (VDD - Vinmax - abs(VToP) - VToN)^2 ); 
if S3 < 1 
    S3 = 1 ;
    I5 = (kn * (VDD - Vinmax - abs(VToP) - VToN)^2 );
end
S4 = S3;

% step 5
p3=sqrt(kn*S3*I5)/(2*0.667*S3*(L^2)*Cox);
if((p3/(2*pi))<10*GBmin)
    fprintf('Error in step 5 \n')
end

% step 6
gm1 = 2 * pi* GBmin * Cc;
gm2 = gm1 ;
S1 = gm1^2 / (kp*I5);
if  S1 < 1
    S1 = 1 ;
end 
S2 = S1;

% step 7
Vds5sat = Vinmin - VSS - sqrt(I5/(S1*kp))-abs(VToP) ;
S5 = 2 * I5 /(kp *Vds5sat^2);
if S5 < 1
    S5 = 1;
end

% step 8
gm6 = 2.2 * gm2 * CL/Cc;
gm4 = sqrt(2*kn*S4*I5)/2;
S6 = S4*gm6/gm4;
if S6 <1 
    S6 =1 ;
end
I6 = (gm6)^2 / (2* kn*S6);

% step 9

% step 10
S7 = I6*S5/I5;
if S7 < 1
    S7 = 1;
end 

% step 11
Av = 2*gm2*gm6 / (I5*(lp+ln)*I6*(ln+lp));
Pdiss = (I5+I6)*(VDD + abs(VSS));

if(Av>Amin)
    fprintf('A : OK \n')
else
    fprintf('? : Error \n')
end

if(Pdiss<Pmax)
    fprintf('Power : OK \n')
else 
    fprintf('Power : Error \n')
end

% Channel Widths

W1 = S1 * L;
W2 = S2 * L;
W3 = S3 * L;
W4 = S4 * L;
W5 = S5 * L;
W6 = S6 * L;
W7 = S7 * L;
W8 = W5;

W1 
W2
W3
W4
W5
W6
W7
W8
I5


VDD
VSS

CL 
Cc













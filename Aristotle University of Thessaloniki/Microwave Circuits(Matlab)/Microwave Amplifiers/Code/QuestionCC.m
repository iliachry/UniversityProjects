function y = QuestionCC(p)

l1_S = p(1);
l2_S = p(2);
l1_L = p(3);
l2_L = p(4);

% S parameters for 3, 4 & 5 GHz
f0 = 4;
f = 3:10e-3:5;

S11 = interp1([3 4 5], [0.8 0.75 0.71], f);
S21 = interp1([3 4 5], [2.8 2.5 2.3], f);
S22 = interp1([3 4 5], [0.66 0.6 0.58], f);

angle11 = interp1([3 4 5], [-90*pi/180 -120*pi/180 -140*pi/180], f);
angle21 = interp1([3 4 5], [100*pi/180 80*pi/180 60*pi/180], f);
angle22 = interp1([3 4 5], [-50*pi/180 -70*pi/180 -85*pi/180], f);

S11 = S11.*exp(1i*angle11);
S21 = S21.*exp(1i*angle21);
S22 = S22.*exp(1i*angle22);

% Gains 
G0 = 20*log10(abs(S21));
GS_max = 1./(1-abs(S11).^2);
GL_max = 1./(1-abs(S22).^2);

% l/lamda
l1_S = 0.178;
l2_S = 0.102;
l1_L = 0.045;
l2_L = 0.432;

% GS(f)
zL_S1 = -1i*cot(2*pi*l2_S*f/f0);
zL_S = zL_S1./(1+zL_S1);
zin_S = (zL_S + 1i*tan(2*pi*l1_S*f/f0))./(1 + 1i*zL_S.*tan(2*pi*l1_S*f/f0));
Gamma_S = (zin_S-1)./(zin_S+1);
GS = GS_max .* (1 - abs(Gamma_S).^2).*(1-abs(S11).^2)./abs(1-S11.*Gamma_S).^2;

% GL(f)
zL_L1 = -1i*cot(2*pi*l2_L*f/f0);
zL_L = zL_L1./(1+zL_L1);
zin_L = (zL_L + 1i*tan(2*pi*l1_L*f/f0))./(1 + 1i*zL_L.*tan(2*pi*l1_L*f/f0));
Gamma_L = (zin_L-1)./(zin_L+1);
GL = GL_max .* (1 - abs(Gamma_L).^2).*(1-abs(S22).^2)./abs(1-S22.*Gamma_L).^2;

% GT(f)
GT_A = 10*log10(GL) + 10*log10(GS) + G0;

y = sum((GT_A-10).^2);
% zL = (1+S11)./(1-S11);
% z = (zL +1i*tan(2*pi*l1_S*f/f0))./(1 + 1i*zL.*tan(2*pi*l1_S*f/f0));
% zOC = -1i*cot(2*pi*l2_S*f/f0);
% zin = z.*zOC./(z+zOC);
% Gamma_in = (zin - 1)./(zin + 1);
% RL_A = -20*log10(abs(Gamma_in));

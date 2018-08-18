% Microwaves 2 
% 3rd exercise 
clear all
close all

%% A2
% S parameters for 3, 4 & 5 GHz
f0 = 4;
f = 3:10e-3:5;

S11 = interp1([3 4 5], [0.8 0.75 0.71], f);
S12 = interp1([3 4 5], [0 0 0], f);
S21 = interp1([3 4 5], [2.8 2.5 2.3], f);
S22 = interp1([3 4 5], [0.66 0.6 0.58], f);

angle11 = interp1([3 4 5], [-90*pi/180 -120*pi/180 -140*pi/180], f);
angle12 = interp1([3 4 5], [0 0 0], f);
angle21 = interp1([3 4 5], [100*pi/180 80*pi/180 60*pi/180], f);
angle22 = interp1([3 4 5], [-50*pi/180 -70*pi/180 -85*pi/180], f);

S11 = S11.*exp(1i*angle11);
S12 = S12.*exp(1i*angle12);
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
figure;
plot(f,GT_A)
title('Transducer Gain, Amplifier')
xlabel('f [GHz]')
ylabel('GT [dB]')
grid on 

%% A3

zL = (1+S11)./(1-S11);
z = (zL +1i*tan(2*pi*l1_S*f/f0))./(1 + 1i*zL.*tan(2*pi*l1_S*f/f0));
zOC = -1i*cot(2*pi*l2_S*f/f0);
zin = z.*zOC./(z+zOC);
Gamma_in = (zin - 1)./(zin + 1);
RL_A = -20*log10(abs(Gamma_in));

figure;
plot(f,RL_A)
title('Return Loss, Amplifier')
xlabel('f [GHz]')
ylabel('RL [dB]')
grid on 

%% B
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

GT2 = zeros(1,length(f));
RL2 = zeros(1,length(f));
for i = 1:length(f)
    % Hybrid 90
    S_Hybrid = Hybrid_1(f(i)/f0);
    
    % Amplifier
    A = (1+S11(i))*(1-S22(i))/2/S21(i);
    B = (1+S11(i))*(1+S22(i))/2/S21(i);
    C = (1-S11(i))*(1-S22(i))/2/S21(i);
    D = (1-S11(i))*(1+S22(i))/2/S21(i);
    ABCD = [A B;C D];
    ABCD2S = [1 0;1/zL_S1(i) 1];
    ABCD1S = [cos(2*pi*l1_S*f(i)/f0) 1j*sin(2*pi*l1_S*f(i)/f0); 1j*sin(2*pi*l1_S*f(i)/f0) cos(2*pi*l1_S*f(i)/f0)];
    ABCD2L = [1 0;1/zL_L1(i) 1];
    ABCD1L = [cos(2*pi*l1_L*f(i)/f0) 1j*sin(2*pi*l1_L*f(i)/f0); 1j*sin(2*pi*l1_L*f(i)/f0) cos(2*pi*l1_L*f(i)/f0)];
    
    ABCD = ABCD2S*ABCD1S*ABCD*ABCD1L*ABCD2L;
    
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
    GT2(i) = 20*log10(abs(a(16))/abs(b(1)));
    RL2(i) = -20*log10(abs(a(1))/abs(b(1)));  
    
end

figure;
plot(f,GT2)
title('Transducer Gain, Balanced Amplifier')
xlabel('f [GHz]')
ylabel('GT [dB]')
grid on 
figure;
plot(f,RL2)
title('Return Loss, Balanced Amplifier')
xlabel('f [GHz]')
ylabel('RL [dB]')
grid on 
ylim([0 50])

%%  C1

% l/lamda
l1_S = 0.114;
l2_S = 0.11;
l1_L = 0.132;
l2_L = 0.441;

zL_S1 = -1i*cot(2*pi*l2_S*f/f0);
zL_L1 = -1i*cot(2*pi*l2_L*f/f0);


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

GTC1 = zeros(1,length(f));
RLC1 = zeros(1,length(f));
for i = 1:length(f)
    S_Hybrid = Hybrid_1(f(i)/f0);
    
    % Amplifier
    A = (1+S11(i))*(1-S22(i))/2/S21(i);
    B = (1+S11(i))*(1+S22(i))/2/S21(i);
    C = (1-S11(i))*(1-S22(i))/2/S21(i);
    D = (1-S11(i))*(1+S22(i))/2/S21(i);
    ABCD = [A B;C D];
    ABCD2S = [1 0;1/zL_S1(i) 1];
    ABCD1S = [cos(2*pi*l1_S*f(i)/f0) 1j*sin(2*pi*l1_S*f(i)/f0); 1j*sin(2*pi*l1_S*f(i)/f0) cos(2*pi*l1_S*f(i)/f0)];
    ABCD2L = [1 0;1/zL_L1(i) 1];
    ABCD1L = [cos(2*pi*l1_L*f(i)/f0) 1j*sin(2*pi*l1_L*f(i)/f0); 1j*sin(2*pi*l1_L*f(i)/f0) cos(2*pi*l1_L*f(i)/f0)];
    
    ABCD = ABCD2S*ABCD1S*ABCD*ABCD1L*ABCD2L;
    
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
    GTC1(i) = 20*log10(abs(a(16))/abs(b(1)));
    RLC1(i) = -20*log10(abs(a(1))/abs((1)));  
    
end

% GT(f)
figure;
plot(f,GTC1)
hold on;
plot(f,GT2)
title('Transducer Gain')
legend('Wideband Balanced Amplifier','Balanced Amplifier');
xlabel('f [GHz]')
ylabel('GT [dB]')
grid on 

% RL
figure;
plot(f,RLC1)
hold on;
plot(f, RL2);
title('Return Loss')
legend('Wideband Balanced Amplifier','Balanced Amplifier');
xlabel('f [GHz]')
ylabel('RL [dB]')
grid on 
ylim([0 50])

%% C2 

l1_S = 0.135;
l2_S = 0.06;
l1_L = 0.137;
l2_L = 0.428;

zL_S1 = -1i*cot(2*pi*l2_S*f/f0);
zL_L1 = -1i*cot(2*pi*l2_L*f/f0);

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

GTC2 = zeros(1,length(f));
RLC2 = zeros(1,length(f));
for i = 1:length(f)
    S_Hybrid = Hybrid_1(f(i)/f0);
    
    % Amplifier
    A = (1+S11(i))*(1-S22(i))/2/S21(i);
    B = (1+S11(i))*(1+S22(i))/2/S21(i);
    C = (1-S11(i))*(1-S22(i))/2/S21(i);
    D = (1-S11(i))*(1+S22(i))/2/S21(i);
    ABCD = [A B;C D];
    ABCD2S = [1 0;1/zL_S1(i) 1];
    ABCD1S = [cos(2*pi*l1_S*f(i)/f0) 1j*sin(2*pi*l1_S*f(i)/f0); 1j*sin(2*pi*l1_S*f(i)/f0) cos(2*pi*l1_S*f(i)/f0)];
    ABCD2L = [1 0;1/zL_L1(i) 1];
    ABCD1L = [cos(2*pi*l1_L*f(i)/f0) 1j*sin(2*pi*l1_L*f(i)/f0); 1j*sin(2*pi*l1_L*f(i)/f0) cos(2*pi*l1_L*f(i)/f0)];
    
    ABCD = ABCD2S*ABCD1S*ABCD*ABCD1L*ABCD2L;
    
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
    GTC2(i) = 20*log10(abs(a(16))/abs(b(1)));
    RLC2(i) = -20*log10(abs(a(1))/abs((1)));  
    
end

figure;
plot(f,GTC2)
hold on;
plot(f,GT2)
title('Transducer Gain')
legend('Wideband Balanced Amplifier','Balanced Amplifier');
xlabel('f [GHz]')
ylabel('GT [dB]')
grid on 

figure;
plot(f,RLC2)
hold on;
plot(f, RL2);
title('Return Loss')
legend('Wideband Balanced Amplifier','Balanced Amplifier');
xlabel('f [GHz]')
ylabel('RL [dB]')
grid on 
ylim([0 50])

figure;
plot(f,GTC1)
hold on
plot(f,GTC2)
grid on
title('Transducer Gain')
legend('c1','c2')
xlabel('f [GHz]')
ylabel('GT [dB]')

figure;
plot(f,RLC1)
hold on
plot(f,RLC2)
grid on
title('Return Loss')
legend('c1','c2')
xlabel('f [GHz]')
ylabel('GT [dB]')
ylim([0 50])
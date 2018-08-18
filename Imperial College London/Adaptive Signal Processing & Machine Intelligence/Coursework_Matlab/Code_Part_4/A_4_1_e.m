%% 4.1.e

clear all; close all; clc; 

N = 200; 
fs = 1000;
f0 = 50;
phi = 0;
mu = 0.1;
L = 1;

% Balanced System 
Va = ones(1,N);
Vb = ones(1,N);
Vc = ones(1,N);
Deltab = 0;
Deltac = 0;
n = 1:N;
A = sqrt(6)/6*(Va + Vb*exp(1j*Deltab) + Vc*exp(1j*Deltac));
B = sqrt(6)/6*(Va + Vb*exp(-1j*(Deltab+2*pi/3)) + Vc*exp(-1j*(Deltac-2*pi/3)));
v_bal = A.*exp(1i*((2*pi*f0/fs*n)+phi)) + B.*exp(-1i*((2*pi*f0/fs*n)+phi));

[~,~, h_CLMS_bal] = CLMS_e(v_bal, mu, L);
h_CLMS_bal = conj(h_CLMS_bal);
f0_CLMS_bal = fs/2/pi * atan(imag(h_CLMS_bal)./real(h_CLMS_bal));

[~, ~, h_ACLMS_bal, g_ACLMS_bal] = ACLMS_e(v_bal, mu, L);
f0_ACLMS_bal = fs/2/pi * atan(((sqrt(imag(h_ACLMS_bal).^2)-(abs(g_ACLMS_bal).^2)))./real(h_ACLMS_bal));

% Unbalanced System / Type C
Va = ones(1,N);
Vb = 0.707*ones(1,N);
Vc = 0.707*ones(1,N);
Deltab = -pi/12;
Deltac = pi/12;
n = 1:N;
A = sqrt(6)/6*(Va + Vb*exp(1j*Deltab) + Vc*exp(1j*Deltac));
B = sqrt(6)/6*(Va + Vb*exp(-1j*(Deltab+2*pi/3)) + Vc*exp(-1j*(Deltac-2*pi/3)));
v_C = A.*exp(1i*((2*pi*f0*n/fs)+phi)) + B.*exp(-1i*((2*pi*f0/fs*n)+phi));

[~,~, h_CLMS_C] = CLMS_e(v_C, mu, L);
h_CLMS_C = conj(h_CLMS_C);
f0_CLMS_C = fs/2/pi*atan(imag(h_CLMS_C)./real(h_CLMS_C));

[~, ~, h_ACLMS_C, g_ACLMS_C] = ACLMS_e(v_C, mu, L);
f0_ACLMS_C = fs/(2*pi)*atan(((sqrt(imag(h_ACLMS_C).^2)-(abs(g_ACLMS_C).^2)))./real(h_ACLMS_C));

% Unbalanced System / Type D
Va = 0.464*ones(1,N);
Vb = 0.896*ones(1,N);
Vc = 0.896*ones(1,N);
Deltab = pi/12;
Deltac = -pi/12;
n = 1:N;
A = (sqrt(6)/6)*(Va + Vb*exp(1j*Deltab) + Vc*exp(1j*Deltac));
B = (sqrt(6)/6)*(Va + Vb*exp(-1j*(Deltab+2*pi/3)) + Vc*exp(-1j*(Deltac-2*pi/3)));
v_D = A.*exp(1i*((2*pi*f0/fs*n)+phi)) + B.*exp(-1i*((2*pi*f0/fs*n)+phi));

[~,~, h_CLMS_D] = CLMS_e(v_D, mu, L);
h_CLMS_D = conj(h_CLMS_D);
f0_CLMS_D = fs/2/pi * atan(imag(h_CLMS_D)./real(h_CLMS_D));

[~,~, h_ACLMS_D, g_ACLMS_D] = ACLMS_e(v_D, mu, L);
f0_ACLMS_D = fs/(2*pi) * atan(((sqrt(imag(h_ACLMS_D).^2)-(abs(g_ACLMS_D).^2)))./real(h_ACLMS_D));

% Plots
figure; 
subplot(1,3,1); hold on; 
plot(f0_CLMS_bal, 'LineWidth', 1.2); 
plot(f0_ACLMS_bal, 'LineWidth', 1.2);
set(gca, 'FontSize', 14); grid on; grid minor; 
xlabel('Sample')
ylabel('f_0')
legend('CLMS Estimate', 'ACLMS Estimate')
title({'Balanced System';''})

subplot(1,3,2); hold on; 
plot(f0_CLMS_C, 'LineWidth', 1.2); 
plot(f0_ACLMS_C, 'LineWidth', 1.2);
ylim([0 100])
set(gca, 'FontSize', 14); grid on; grid minor; 
xlabel('Sample')
ylabel('f_0')
legend('CLMS Estimate', 'ACLMS Estimate')
title({'Unbalanced System (Type C)';''})

subplot(1,3,3); hold on; 
plot(f0_CLMS_D, 'LineWidth', 1.2); 
plot(f0_ACLMS_D, 'LineWidth', 1.2);
ylim([0 100])
set(gca, 'FontSize', 14); grid on; grid minor; 
xlabel('Sample')
ylabel('f_0')
legend('CLMS Estimate', 'ACLMS Estimate')
title({'Unbalanced System (Type D)';''})
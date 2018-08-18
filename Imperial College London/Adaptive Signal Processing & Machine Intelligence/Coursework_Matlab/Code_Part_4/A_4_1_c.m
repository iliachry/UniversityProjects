%% 4.1.c

clear all; close all; clc;

N = 200; 
fs = 10000;
f0 = 50;
phi = 0;

% Balanced System 
Va = ones(1,N);
Vb = ones(1,N);
Vc = ones(1,N);
Deltab = 0;
Deltac = 0;
n = 1:N;
A = sqrt(6)/6*(Va + Vb*exp(1j*Deltab) + Vc*exp(1j*Deltac));
B = sqrt(6)/6*(Va + Vb*exp(-1j*(Deltab+2*pi/3)) + Vc*exp(-1j*(Deltac-2*pi/3)));
v_bal = A.*exp(1i*(2*pi*f0/fs*n+phi)) + B.*exp(-1i*(2*pi*f0/fs*n+phi));

% Unbalanced System / Type C
Va = ones(1,N);
Vb = 0.707*ones(1,N);
Vc = 0.707*ones(1,N);
Deltab = -pi/12;
Deltac = pi/12;
n = 1:N;
A = sqrt(6)/6*(Va + Vb*exp(1j*Deltab) + Vc*exp(1j*Deltac));
B = sqrt(6)/6*(Va + Vb*exp(-1j*(Deltab+2*pi/3)) + Vc*exp(-1j*(Deltac-2*pi/3)));
v_C = A.*exp(1i*(2*pi*f0/fs*n+phi)) + B.*exp(-1i*(2*pi*f0/fs*n+phi));

% Unbalanced System / Type D
Va = 0.464*ones(1,N);
Vb = 0.896*ones(1,N);
Vc = 0.896*ones(1,N);
Deltab = pi/12;
Deltac = -pi/12;
n = 1:N;
A = sqrt(6)/6*(Va + Vb*exp(1j*Deltab) + Vc*exp(1j*Deltac));
B = sqrt(6)/6*(Va + Vb*exp(-1j*(Deltab+2*pi/3)) + Vc*exp(-1j*(Deltac-2*pi/3)));
v_D = A.*exp(1i*(2*pi*f0/fs*n+phi)) + B.*exp(-1i*(2*pi*f0/fs*n+phi));

figure;
subplot(1,3,1); 
plot(real(v_bal), imag(v_bal),'.', 'markerSize', 20);
xlim([-1.5, 1.5]); ylim([-1.5, 1.5])
grid on; grid minor; xlabel('Real Part'); ylabel('Imaginary Part');
title({'Balanced System';''}); set(gca, 'FontSize', 14);

subplot(1,3,2); 
plot(real(v_C), imag(v_C),'.', 'markerSize', 20); 
xlim([-1.5, 1.5]); ylim([-1.5, 1.5])
grid on; grid minor; xlabel('Real Part'); ylabel('Imaginary Part');
title({'Unbalanced System'; 'Type C'}); set(gca, 'FontSize', 14);

subplot(1,3,3); 
plot(real(v_D), imag(v_D),'.', 'markerSize', 20); 
xlim([-1.5, 1.5]); ylim([-1.5, 1.5]);
grid on; grid minor; xlabel('Real Part'); ylabel('Imaginary Part');
title({'Unbalanced System'; 'Type D'}); set(gca, 'FontSize', 14);
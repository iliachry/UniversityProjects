% 1.3 Resolution and Leakage of Periodogram-based Methods

clear all; close all; clc; 

%% 1.3.b)

f0 = 0.2;
a1 = 1;
a2 = 1;
phi1 = 0;
phi2 = 0;
N = 256;
a = 0.6;

n = 0:1:N-1;
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 

K = 4096;

% X = fft(x,K);
% P = 10*log10(fftshift((X.*conj(X))/K));
f = 0:1/K:1/2-1/K;

P = periodogram(x, [], K);
P = P/max(P);
P(end) = [];

subplot(2,3,1);
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-3, 1])
title({'Periodogram of x(n), a = 0.6';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);

a = 0.75; 
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 

P = periodogram(x, [], K);
P = P/max(P);
P(end) = [];

subplot(2,3,2)
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-3, 1])
title({'Periodogram of x(n), a = 0.75';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);

a = 0.9; 
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 

P = periodogram(x, [], K);
P = P/max(P);
P(end) = [];

subplot(2,3,3)
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-3, 1])
title({'Periodogram of x(n), a = 0.9';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);

a = 1; 
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 

P = periodogram(x, [], K);
P = P/max(P);
P(end) = [];

subplot(2,3,4)
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-3, 1])
title({'Periodogram of x(n), a = 1';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);

a = 1.5; 
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 

P = periodogram(x, [], K);
P = P/max(P);
P(end) = [];

subplot(2,3,5)
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-3, 1])
title({'Periodogram of x(n), a = 1.5';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;
set(gca, 'FontSize', 14);

a = 2; 
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 

P = periodogram(x, [], K);
P = P/max(P);
P(end) = [];

subplot(2,3,6)
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-3, 1])
title({'Periodogram of x(n), a = 2';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);
















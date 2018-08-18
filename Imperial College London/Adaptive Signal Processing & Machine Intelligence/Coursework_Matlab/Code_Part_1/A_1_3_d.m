% 1.3.d

clear all; close all; clc

f0 = 0.2;
a1 = 1;
a2 = 1;
phi1 = 0;
phi2 = 0;
N = 256;
a = 4;

n = 0:1:N-1;
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 

K = 4096;

f = 0:1/K:1/2-1/K;

P = periodogram(x, [], K);
P = P/max(P);
P(end) = [];

subplot(2,3,1);
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-3 1])
title({'Periodogram of x(n), \alpha = 4, a_2 = 1';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);

a2 = 0.1; 
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 

P = periodogram(x, [], K);
P = P/max(P);
P(end) = [];

subplot(2,3,2)
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-3 1])
title({'Periodogram of x(n), \alpha = 4, a_2 = 0.1';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);

a2 = 0.01; 
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 
ylim([10^-4 1])
P = periodogram(x, [], K);
P = P/max(P);
P(end) = [];

subplot(2,3,3)
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-3 1])
title({'Periodogram of x(n), \alpha = 4, a_2 = 0.01';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);

a2 = 1; 
a = 12;
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 
ylim([10^-4 1])
P = periodogram(x, [], K);
P = P/max(P);
P(end) = [];

subplot(2,3,4)
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-3 1])
title({'Periodogram of x(n), \alpha = 12, a_2 = 1';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);

a2 = 0.1; 
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 

P = periodogram(x, [], K);
P = P/max(P);
P(end) = [];

subplot(2,3,5)
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-3 1])
title({'Periodogram of x(n), \alpha = 12, a_2 = 0.1';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);

a2 = 0.01; 
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 

P = periodogram(x, [], K);
P = P/max(P);
P(end) = [];

subplot(2,3,6)
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-3 1])
title({'Periodogram of x(n), \alpha = 4, a_2 = 0.01';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);
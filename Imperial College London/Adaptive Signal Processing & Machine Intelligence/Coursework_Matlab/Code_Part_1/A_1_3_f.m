%% 1.3.f)

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

K = 512;
f = 0:1/K:1/2-1/K;

P = periodogram(x, chebwin(N), K);
P = P/max(P);
P(end) = [];

subplot(2,4,1);
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-10 1])
title({'Chebyshev, \alpha = 4, a_2 = 1';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor; set(gca, 'FontSize', 12);

a2 = 0.1; 
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 

P = periodogram(x, chebwin(N), K);
P = P/max(P);
P(end) = [];

subplot(2,4,2)
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-10 1])
title({'Chebyshev, \alpha = 4, a_2 = 0.1';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor; set(gca, 'FontSize', 12);

a2 = 0.01; 
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 
ylim([10^-10 1])
P = periodogram(x, chebwin(N), K);
P = P/max(P);
P(end) = [];

subplot(2,4,3)
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-10 1])
title({'Chebyshev, \alpha = 4, a_2 = 0.01';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor; set(gca, 'FontSize', 12);

a2 = 0.001; 
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 
ylim([10^-10 1])
P = periodogram(x, chebwin(N), K);
P = P/max(P);
P(end) = [];

subplot(2,4,4)
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-10 1])
title({'Chebyshev, \alpha = 4, a_2 = 0.001';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor; set(gca, 'FontSize', 12);

% K = 256;
% f = 0:1/K:1/2-1/K;
a = 12;

a2 = 1; 
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 
ylim([10^-10 1])
P = periodogram(x, chebwin(N), K);
P = P/max(P);
P(end) = [];

subplot(2,4,5)
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-10 1])
title({'Chebyshev, \alpha = 12, a_2 = 1';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor; set(gca, 'FontSize', 12);

a2 = 0.1; 
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 

P = periodogram(x, chebwin(N), K);
P = P/max(P);
P(end) = [];

subplot(2,4,6)
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-10 1])
title({'Chebyshev, \alpha = 12, a_2 = 0.1';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor; set(gca, 'FontSize', 12);

a2 = 0.01; 
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 

P = periodogram(x, chebwin(N), K);
P = P/max(P);
P(end) = [];

subplot(2,4,7)
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-10 1])
title({'Chebyshev, \alpha = 12, a_2 = 0.01';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor; set(gca, 'FontSize', 12);

a2 = 0.001; 
x = a1*sin(f0*2*pi*n + phi1) + a2*sin((f0+a/N)*2*pi*n+phi2); 

P = periodogram(x, chebwin(N), K);
P = P/max(P);
P(end) = [];


subplot(2,4,8)
semilogy(f, P, 'LineWidth', 1.2)
ylim([10^-10 1])
title({'Chebyshev, \alpha = 12, a_2 = 0.001';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor; set(gca, 'FontSize', 12);



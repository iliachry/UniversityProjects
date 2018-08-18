%% 1.4.a Periodogram-based Methods Applied to Real-World Data

clear all; close all; clc; 

load sunspot.dat

% plot(sunspot(:,1),sunspot(:,2))

t = sunspot(:,1);
x1 = sunspot(:,2);
x2 = x1 - mean(x1);
x3 = detrend(x1);

K = 512;
f = 0:1/K:1/2-1/K;

P1 = periodogram(x1, chebwin(288), K);
P1 = P1/max(P1);
P1(end) = [];

P2 = periodogram(x2, chebwin(288), K);
P2 = P2/max(P2);
P2(end) = [];

P3 = periodogram(x3, chebwin(288), K);
P3 = P3/max(P3);
P3(end) = [];


figure;
subplot(2,3,1)
plot(f, P1, 'LineWidth', 1.2)
title({'Chebyshev Window, Sunspot Time Series';''})
xlabel('Frequency')
ylabel('Magnitude')
grid on; set(gca, 'FontSize', 12);

grid minor

subplot(2,3,2)
plot(f, P2, 'LineWidth', 1.2)
title({'Chebyshev Window, Removed Mean';''})
xlabel('Frequency')
ylabel('Magnitude')
grid on; set(gca, 'FontSize', 12);

grid minor

subplot(2,3,3)
plot(f, P3, 'LineWidth', 1.2)
title({'Chebyshev Window, Removed Trend';''})
xlabel('Frequency')
ylabel('Magnitude')
grid on; set(gca, 'FontSize', 12);

grid minor

P1 = periodogram(x1, hamming(288), K);
P1 = P1/max(P1);
P1(end) = [];

P2 = periodogram(x2, hamming(288), K);
P2 = P2/max(P2);
P2(end) = [];

P3 = periodogram(x3,hamming(288), K);
P3 = P3/max(P3);
P3(end) = [];

subplot(2,3,4)
plot(f, P1, 'LineWidth', 1.2)
title({'Hamming Window, Sunspot Time Series';''})
xlabel('Frequency')
ylabel('Magnitude')
grid on; set(gca, 'FontSize', 12);

grid minor

subplot(2,3,5)
plot(f, P2, 'LineWidth', 1.2)
title({'Hamming Window, Removed Mean';''})
xlabel('Frequency')
ylabel('Magnitude')
grid on; set(gca, 'FontSize', 12);

grid minor

subplot(2,3,6)
plot(f, P3, 'LineWidth', 1.2)
title({'Hamming Window, Removed Trend';''})
xlabel('Frequency')
ylabel('Magnitude')
grid on; set(gca, 'FontSize', 12);

grid minor

%% Standard 

P1 = periodogram(x1, [], K);
P1 = P1/max(P1);
P1(end) = [];

P2 = periodogram(x2, [], K);
P2 = P2/max(P2);
P2(end) = [];

P3 = periodogram(x3, [], K);
P3 = P3/max(P3);
P3(end) = [];

figure;
subplot(2,3,1)
plot(f, P1, 'LineWidth', 1.2)
title({'Rectangular Window, Sunspot Time Series';''})
xlabel('Frequency')
ylabel('Magnitude')
grid on; set(gca, 'FontSize', 12);

grid minor

subplot(2,3,2)
plot(f, P2, 'LineWidth', 1.2)
title({'Rectangular Window, Removed Mean';''})
xlabel('Frequency')
ylabel('Magnitude')
grid on; set(gca, 'FontSize', 12);

grid minor

subplot(2,3,3)
plot(f, P3, 'LineWidth', 1.2)
title({'Rectangular Window, Removed Trend';''})
xlabel('Frequency')
ylabel('Magnitude')
grid on; set(gca, 'FontSize', 12);

grid minor

%% Applying a logarithm

t = sunspot(:,1);
x1 = sunspot(:,2);
x1(x1 == 0) = 1;
x1 = log(x1);
x2 = x1 - mean(x1);
x3 = detrend(x1);

K = 512;
f = 0:1/K:1/2-1/K;

P1 = periodogram(x1, [], K);
P1 = P1/max(P1);
P1(end) = [];

P2 = periodogram(x2, [], K);
P2 = P2/max(P2);
P2(end) = [];

P3 = periodogram(x3,[], K);
P3 = P3/max(P3);
P3(end) = [];

subplot(2,3,4)
plot(f, P1, 'LineWidth', 1.2)
title({'Logarithm Applied, Sunspot Time Series';''})
xlabel('Frequency')
ylabel('Magnitude')
grid on; set(gca, 'FontSize', 12);

grid minor

subplot(2,3,5)
plot(f, P2, 'LineWidth', 1.2)
title({'Logarithm Applied, Removed Mean';''})
xlabel('Frequency')
ylabel('Magnitude')
grid on; set(gca, 'FontSize', 12);

grid minor

subplot(2,3,6)
plot(f, P3, 'LineWidth', 1.2)
title({'Logarithm Applied, Removed Trend';''})
xlabel('Frequency')
ylabel('Magnitude')
grid on; set(gca, 'FontSize', 12);

grid minor


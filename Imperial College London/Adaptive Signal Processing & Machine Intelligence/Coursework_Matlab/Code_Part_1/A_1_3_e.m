%% 1.3.e

clear all; close all; clc

N = 256; 
K = 2048;

wb = bartlett(N);
Wb = periodogram(wb,[],K);
Wb = Wb/max(Wb);
Wb(end) = [];

f = 0:1/K:1/2-1/K;

semilogy(f, Wb, 'LineWidth', 1.2);
hold on;
stem([4, 4]/256, [10^-6, 10^-3], 'LineWidth', 1.2)
stem([12, 12]/256, [10^-6, 10^-4], 'LineWidth', 1.2)
ylim([10^-6 1])
title('Bartlett Window')
xlabel('Frequency')
ylabel('Magnitude')
legend('Bartlett Window', '\alpha = 4', '\alpha = 12')
grid on;
grid minor; set(gca, 'FontSize', 14);


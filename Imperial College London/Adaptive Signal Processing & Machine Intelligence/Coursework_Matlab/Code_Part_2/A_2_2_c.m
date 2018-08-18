%% 2.2.c

clear all; close all; clc;

N = 10000; 
x = filter(1, [1, -2.76, 3.81, -2.65, 0.92], randn(1,N));
x = x(501:end);

h = zeros(1024,3);
w = zeros(1024,3);
p = [2, 4, 8];
for i = 1:3
    [a, e] = aryule(x, p(i));
    [h(:,i), w(:,i)] = freqz(sqrt(e), a, 1024);
end

[h(:,4), w(:,4)] = freqz(1, [1, -2.76, 3.81, -2.65, 0.92], 1024);


figure;
hold on;
plot(w(:,4), mag2db(abs(h(:,4)).^2), 'LineWidth', 1.2);
plot(w(:,1), mag2db(abs(h(:,1)).^2), 'LineWidth', 1.2);
plot(w(:,2), mag2db(abs(h(:,2)).^2), 'LineWidth', 1.2);
plot(w(:,3), mag2db(abs(h(:,3)).^2), 'LineWidth', 1.2);
grid on; grid minor;
xlim([0, pi]);
title('PSD Estimates of AR(4) Process, N = 10000');
xlabel('Angular Frequency')
ylabel('PSD [dB]');
legend('True', 'p = 2', 'p = 4', 'p = 8');
set(gca, 'FontSize', 14);

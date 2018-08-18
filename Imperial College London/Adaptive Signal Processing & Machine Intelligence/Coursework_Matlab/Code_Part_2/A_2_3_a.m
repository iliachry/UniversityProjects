%% 2.3.a

clear all; close all; clc

load('PCAPCR.mat');

s = svd(X);
s_noise = svd(Xnoise);

error = (s - s_noise).^2;

subplot(1,3,1)
stem(s, 'LineWidth', 1.5); grid on; grid minor; xlabel('Singular Values'); ylabel('Amplitude');
title({'Singular Values of X';''}); set(gca, 'FontSize', 14 );
subplot(1,3,2)
stem(s_noise, 'LineWidth', 1.5); grid on; grid minor; xlabel('Singular Values'); ylabel('Amplitude');
title({'Singular Values of Xnoise';''}); set(gca, 'FontSize', 14);
subplot(1,3,3)
stem(error, 'LineWidth', 1.5); grid on; grid minor; xlabel('Singular Values'); ylabel('Square Error');
title({'Square Error between the Singular Values';''}); set(gca, 'FontSize', 14);
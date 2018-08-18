%% 4.2.a

clear all; close all; clc;

N = 1500;
fs = 2000;

eta = wgn(1,1500, pow2db(0.05), 'complex');
f = [100*ones(1,500), 100*ones(1,500)+ ((501:1000)-500)/2, 100*ones(1,500) + (((1001:1500)-1000)/25).^2];
phi = cumsum(f);
y = exp(1i*2*pi/fs*phi)+eta;

a = aryule(y, 1);
[h, w] = freqz(1, a, 2048);

figure; 
subplot(1,2,1);
plot(f, 'LineWidth', 1.2)
grid on; grid minor; xlabel('Sample'); ylabel('f(n)');
title({'Frequency'}); set(gca, 'FontSize', 14);

subplot(1,2,2);
plot(w*fs/2/pi,pow2db(abs(h).^2), 'LineWidth', 1.2);
grid on; grid minor; xlabel('Frequency'); ylabel('dB');
title({'AR PSD Estimate'}); set(gca, 'FontSize', 14); 
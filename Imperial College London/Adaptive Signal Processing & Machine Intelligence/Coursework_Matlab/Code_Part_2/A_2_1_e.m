%% 2.1.e

clear all; close all; clc;

n = 0:29; 
noise=0.2/sqrt(2)*(randn(size(n))+1j*randn(size(n)));
x=exp(1j*2*pi*0.3*n)+exp(1j*2*pi*0.32*n)+noise;

[X,R] = corrmtx(x,14,'mod');
[S,F] = pmusic(R,2,[],1,'corr');

subplot(1,3,1);
plot(F,S, 'LineWidth', 1.2); set(gca,'xlim',[0.25 0.40]);
grid on; grid minor;set(gca, 'FontSize', 14);
box off;  xlabel('Frequency [Hz]'); ylabel('Pseudospectrum');
title('N = 30, f_1 = 0.3, f_2 = 0.32')

n = 0:24; 
noise=0.2/sqrt(2)*(randn(size(n))+1j*randn(size(n)));
x=exp(1j*2*pi*0.3*n)+exp(1j*2*pi*0.32*n)+noise;

[X,R] = corrmtx(x,14,'mod');
[S,F] = pmusic(R,2,[],1,'corr');

subplot(1,3,2);
plot(F,S, 'LineWidth', 1.2); set(gca,'xlim',[0.25 0.40]);
grid on; grid minor;set(gca, 'FontSize', 14);
box off;  xlabel('Frequency [Hz]'); ylabel('Pseudospectrum');
title('N = 25, f_1 = 0.3, f_2 = 0.32')

n = 0:19; 
noise=0.2/sqrt(2)*(randn(size(n))+1j*randn(size(n)));
x=exp(1j*2*pi*0.3*n)+exp(1j*2*pi*0.32*n)+noise;

[X,R] = corrmtx(x,14,'mod');
[S,F] = pmusic(R,2,[],1,'corr');

subplot(1,3,3);
plot(F,S, 'LineWidth', 1.2); set(gca,'xlim',[0.25 0.40]);
grid on; grid minor;set(gca, 'FontSize', 14);
box off;  xlabel('Frequency [Hz]'); ylabel('Pseudospectrum');
title('N = 20, f_1 = 0.3, f_2 = 0.32')


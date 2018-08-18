% 1.1 Discrete Fourier Transform Basics

clear all; close all; clc; 

%% 1.1.a)

% Sine Wave
f0 = -100:0.01:100; % frequency
X = zeros(1,length(f0));
X(f0==-20) = 0.5;
X(f0==20) = 0.5;

subplot(1,2,1)
plot(f0,X, 'LineWidth', 1.2);
title({'Ideal Fourier (Magnitude) Spectrum of a sine wave';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;
axis([-50 50 -0.2 0.5])
set(gca, 'FontSize', 14);

% Windowed Sine Wave

filt = sinc(f0);
Xw = conv(X, filt);

Xw(30002:40001) = [] ; % deleting zero values created by the convolution
Xw(1:10000) = []; % deleting zero values created by the convolution

subplot(1,2,2)
plot(f0,Xw, 'LineWidth', 1.2)
title({'Theoretical DTFT (Magnitude) Spectrum of a windowed sine wave';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;
axis([-50 50 -0.2 0.5])
set(gca, 'FontSize', 14);
%% 1.1.b)

N = 100;
fs = 1000;
f0 = 20;
n = 0:1/fs:(N-1)/fs;
x = sin(2*pi*f0*n);

K1 = 100;
X1 = abs(fftshift(fft(x,K1)));

K2 = 1000;
X2 = abs(fftshift(fft(x,K2)));

f1 = -fs/2:fs/K1:fs/2-fs/K1;
f2 = -fs/2:fs/K2:fs/2-fs/K2;

figure;

subplot(1,2,1);
stem(f1,X1, 'LineWidth', 1.2)
title({'K = 100 point DFT of a 20 Hz sine wave';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;
axis([-50 50 0 50])
set(gca, 'FontSize', 14);

subplot(1,2,2)
stem(f2,X2, 'LineWidth', 1.2)
title({'K = 1000 point DFT of a 20 Hz sine wave';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;
axis([-100 100 0 50])
set(gca, 'FontSize', 14);
%% 1.1.c)

N = 100;
fs = 1000;
f0 = 24;
n = 0:1/fs:(N-1)/fs;
x = sin(2*pi*f0*n);

K1 = 100;
X1 = abs(fftshift(fft(x,K1)));
f1 = -fs/2:fs/K1:fs/2-fs/K1;

K2 = 500;
X2 = abs(fftshift(fft(x,K2)));
f2 = -fs/2:fs/K2:fs/2-fs/K2;

K3 = 1000;
X3 = abs(fftshift(fft(x,K3)));
f3 = -fs/2:fs/K3:fs/2-fs/K3;

K4 = 10000;
X4 = abs(fftshift(fft(x,K4)));
f4 = -fs/2:fs/K4:fs/2-fs/K4;

figure;

subplot(2,2,1)
stem(f1,X1, 'LineWidth', 1.2)
title({'K = 100 point DFT of a 24 Hz sine wave';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor; set(gca, 'FontSize', 14);
axis([-50 50 0 50])

subplot(2,2,2)
stem(f2,X2, 'LineWidth', 1.2)
title({'K = 500 point DFT of a 24 Hz sine wave';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;
axis([-50 50 0 50])
set(gca, 'FontSize', 14);

subplot(2,2,3)
stem(f3,X3, 'LineWidth', 1.2)
title({'K = 1000 point DFT of a 24 Hz sine wave';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;
axis([-50 50 0 50])
set(gca, 'FontSize', 14);

subplot(2,2,4)
plot(f4,X4, 'LineWidth', 1.2)
title({'K = 10000 point DFT of a 24 Hz sine wave';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor; set(gca, 'FontSize', 14);
axis([-50 50 0 50])









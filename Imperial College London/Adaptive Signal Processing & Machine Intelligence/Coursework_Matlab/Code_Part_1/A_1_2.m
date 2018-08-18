% 1.2 Properties of Power Spectral Density (PSD)

clear all; close all; clc; 

%% Introduction 

% Proof that fft(x) = P(omega_k) 

M = 10;
L = 256;

k = -M+1:1:M-1;
r = (M-abs(k))/M;
x = [r(M:end) zeros(1,L-(2*M-1)) r(1:M-1)];

f = -1:2/L:1-1/L;
X = fftshift(fft(x)); 
P = abs(fftshift(fft(r,256)));

subplot(2,2,1)
plot(f, real(X), 'LineWidth', 1.2)
title({'X(\omega), M = 10, L = 256';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor; set(gca, 'FontSize', 14);


subplot(2,2,2)
plot(f, P, 'LineWidth', 1.2)
title({'P(\omega), M = 10, L = 256';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


M = 128;
L = 256;

k = -M+1:1:M-1;
r = (M-abs(k))/M;
x = [r(M:end) zeros(1,L-(2*M-1)) r(1:M-1)];

f = -1:2/L:1-1/L;
X = fftshift(fft(x)); 
P = abs(fftshift(fft(r,256)));

subplot(2,2,3)
plot(f, real(X), 'LineWidth', 1.2)
title({'X(\omega), M = 128, L = 256';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


subplot(2,2,4)
plot(f, P, 'LineWidth', 1.2)
title({'P(\omega), M = 128, L = 256';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


%% 1.2.a) 

M = 10;
L = 20;

k = -M+1:1:M-1;
r = (M-abs(k))/M;
x = [r(M:end) zeros(1,L-(2*M-1)) r(1:M-1)];

f = -1:2/L:1-1/L;
X = fftshift(fft(x)); 

subplot(2,2,1)
plot(f, abs(X), 'LineWidth', 1.2)
title({'X(\omega), M = 10, L = 20';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


M = 10;
L = 256;

k = -M+1:1:M-1;
r = (M-abs(k))/M;
x = [r(M:end) zeros(1,L-(2*M-1)) r(1:M-1)];

f = -1:2/L:1-1/L;
X = fftshift(fft(x)); 

subplot(2,2,2)
plot(f, abs(X), 'LineWidth', 1.2)
title({'X(\omega), M = 10, L = 256';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


M = 128;
L = 256;

k = -M+1:1:M-1;
r = (M-abs(k))/M;
x = [r(M:end) zeros(1,L-(2*M-1)) r(1:M-1)];

f = -1:2/L:1-1/L;
X = fftshift(fft(x)); 

subplot(2,2,3)
plot(f, abs(X), 'LineWidth', 1.2)
title({'X(\omega), M = 128, L = 256';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);

axis([-0.5 0.5 0 120])

M = 128;
L = 1024;

k = -M+1:1:M-1;
r = (M-abs(k))/M;
x = [r(M:end) zeros(1,L-(2*M-1)) r(1:M-1)];

f = -1:2/L:1-1/L;
X = fftshift(fft(x)); 

subplot(2,2,4)
plot(f, abs(X), 'LineWidth', 1.2)
title({'X(\omega), M = 128, L = 1024';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);

axis([-0.5 0.5 0 120])

%% 1.2.b)

M = 10;
L = 20;

k = -M+1:1:M-1;
r = (M-abs(k))/M;
x = [r(M:end) zeros(1,L-(2*M-1)) r(1:M-1)];

f = -1:2/L:1-1/L;
X = imag(fftshift(fft(x))); 

figure;
subplot(1,2,1)
stem(f, X, 'LineWidth', 1.2)
title({'Imaginary Part of X(\omega), M = 10, L = 20';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


M = 10;
L = 256;

k = -M+1:1:M-1;
r = (M-abs(k))/M;
x = [r(M:end) zeros(1,L-(2*M-1)) r(1:M-1)];

f = -1:2/L:1-1/L;
X = imag(fftshift(fft(x))); 

subplot(1,2,2)
stem(f, X, 'LineWidth', 1.2)
title({'Imaginary Part of X(\omega), M = 10, L = 256';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


%% 1.2.c)

M = 10;
L = 20;

k = -M+1:1:M-1;
r = (M-abs(k))/M;
z = [r zeros(1,L-(2*M-1))];

f = -1:2/L:1-1/L;
Z = real(fftshift(fft(z))); 

figure;
subplot(2,3,1)
stem(f, Z, 'LineWidth', 1.2)
title({'Real Part of X(\omega), M = 10, L = 20';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


Z = imag(fftshift(fft(z))); 

subplot(2,3,2)
stem(f, Z, 'LineWidth', 1.2)
title({'Imaginary Part of X(\omega), M = 10, L = 20';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


Z = abs(fftshift(fft(z))); 

subplot(2,3,3)
stem(f, Z, 'LineWidth', 1.2)
title({'Magnitude of X(\omega), M = 10, L = 20';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


M = 10;
L = 256;

k = -M+1:1:M-1;
r = (M-abs(k))/M;
z = [r zeros(1,L-(2*M-1))];

f = -1:2/L:1-1/L;
Z = real(fftshift(fft(z))); 

subplot(2,3,4)
plot(f, Z, 'LineWidth', 1.2)
title({'Real Part of X(\omega), M = 10, L = 256';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


Z = imag(fftshift(fft(z))); 

subplot(2,3,5)
plot(f, Z, 'LineWidth', 1.2)
title({'Imaginary Part of X(\omega), M = 10, L = 256';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


Z = abs(fftshift(fft(z))); 

subplot(2,3,6)
plot(f, Z, 'LineWidth', 1.2)
title({'Magnitude of X(\omega), M = 10, L = 256';''})
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


%% 1.2.d)

M = 10;
L = 256;

k = -M+1:1:M-1;
r = (M-abs(k))/M;
x = [r(M:end) zeros(1,L-(2*M-1)) r(1:M-1)];

f = -1:2/L:1-1/L;
X = fft(x); 

figure;
subplot(2,2,1)
plot(f, real(X), 'LineWidth', 1.2)
title({'X(\omega), M = 10, L = 256, no shift';''})
xlabel('Frequency');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


X = fftshift(fft(x)); 

subplot(2,2,2)
plot(f, real(X), 'LineWidth', 1.2)
title({'X(\omega), M = 10, L = 256, with shift';''})
xlabel('Frequency');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


M = 10;
L = 256;

k = -M+1:1:M-1;
r = (M-abs(k))/M;
x = [r(M:end) zeros(1,L-(2*M-1)) r(1:M-1)];

f = -1:2/L:1-1/L;
X = fft(x); 

ACF = ifft(X);

subplot(2,2,3)
plot(f, ACF, 'LineWidth', 1.2)
title({'ACF, M = 10, L = 256, no shift';''})
xlabel('Time Lag');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


ACF = fftshift(ifft(X));

subplot(2,2,4)
plot(f, ACF, 'LineWidth', 1.2)
title({'ACF, M = 10, L = 256, with shift';''})
xlabel('Time Lag');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);



M = 10;
L = 255;

k = -M+1:1:M-1;
r = (M-abs(k))/M;
x = [r(M:end) zeros(1,L-(2*M-1)) r(1:M-1)];

f = -1:2/L:1-1/L;
X = (fft(x)); 
ACF = fftshift(ifft(X));

figure;
subplot(2,2,1)
plot(f, real(fftshift(X)), 'LineWidth', 1.2)
title({'X(\omega), M = 10, L = 255, False Frequency Vector';''})
xlabel('Frequency');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


subplot(2,2,2)
plot(f, ACF, 'LineWidth', 1.2)
title({'ACF, M = 10, L = 255, False Time Lag Vector';''})
xlabel('Time Lag');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


f = -1+1/L:2/L:1-1/L;

subplot(2,2,3)
plot(f, real(fftshift(X)), 'LineWidth', 1.2)
title({'X(\omega), M = 10, L = 255, Correct Frequency Vector';''})
xlabel('Frequency');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);


subplot(2,2,4)
plot(f, ACF, 'LineWidth', 1.2)
title({'ACF, M = 10, L = 255, Correct Time Lag Vector';''})
xlabel('Time Lag');
ylabel('Magnitude');
grid on;
grid minor;set(gca, 'FontSize', 14);




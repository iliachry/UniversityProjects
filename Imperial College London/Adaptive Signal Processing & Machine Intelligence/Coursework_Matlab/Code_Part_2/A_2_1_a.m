%% 2.1.a

clear all; close all; clc

N = 1000;

%% WGN
x = randn(1,N);

ACF_b = xcorr(x, 'biased');
ACF_ub = xcorr(x, 'unbiased');

Px_b = fftshift(fft(ifftshift(ACF_b)));
Px_ub = fftshift(fft(ifftshift(ACF_ub)));

x_axis = -0.5:0.0005:0.5-0.001;
subplot(2,3,1);
plot(x_axis, ACF_ub);
hold on;
plot(x_axis, ACF_b);
grid on;
%grid minor;
title('ACF Estimate of WGN');
legend('Unbiased', 'Biased', 'location', 'best');
ylabel('ACF');
xlabel('Time Lag');

subplot(2,3,4);
plot(x_axis, Px_ub);
hold on;
plot(x_axis, Px_b);
grid on;
%grid minor;
title('Estimated PSD of WGN');
legend('Unbiased', 'Biased', 'location', 'best');
ylabel('PSD');
xlabel('Frequency');

%% Filtered WGN 
b = [2,3];
a = [1,0.2];
x = filter(b, a, x); 

ACF_b = xcorr(x, 'biased');
ACF_ub = xcorr(x, 'unbiased');

Px_b = fftshift(fft(ifftshift(ACF_b)));
Px_ub = fftshift(fft(ifftshift(ACF_ub)));

subplot(2,3,2);
plot(x_axis, ACF_ub);
hold on;
plot(x_axis, ACF_b);
grid on;
%grid minor;
title('ACF Estimate of Filtered WGN');
legend('Unbiased', 'Biased', 'location', 'best');
ylabel('ACF');
xlabel('Time Lag');

subplot(2,3,5);
plot(x_axis, Px_ub);
hold on;
plot(x_axis, Px_b);
grid on;
%grid minor;
title('Estimated PSD of Filtered WGN');
legend('Unbiased', 'Biased', 'location', 'best');
ylabel('PSD');
xlabel('Frequency');

%% Noisy sinusoids
x = sin(2*pi*0.4*(0:N-1)) + 0.5*randn(1,N);

ACF_b = xcorr(x, 'biased');
ACF_ub = xcorr(x, 'unbiased');

Px_b = fftshift(fft(ifftshift(ACF_b)));
Px_ub = fftshift(fft(ifftshift(ACF_ub)));

subplot(2,3,3);
plot(x_axis, ACF_ub);
hold on;
plot(x_axis, ACF_b);
grid on;
%grid minor;
title('ACF Estimate of Noisy Sinusoid');
legend('Unbiased', 'Biased', 'location', 'best');
ylabel('ACF');
xlabel('Time Lag');

subplot(2,3,6);
plot(x_axis, Px_ub);
hold on;
plot(x_axis, Px_b);
grid on;
%grid minor;
title('Estimated PSD of Noisy Sinusoid');
legend('Unbiased', 'Biased', 'location', 'best');
ylabel('PSD');
xlabel('Frequency');


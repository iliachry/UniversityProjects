%% 2.1.d

clear all; close all; clc

n = 0:29; 
noise=0.2/sqrt(2)*(randn(size(n))+1j*randn(size(n)));
x=exp(1j*2*pi*0.3*n)+exp(1j*2*pi*0.32*n)+noise;
Px = periodogram(x,rectwin(length(x)),128);

x_axis = 0:1/128:1-1/128;
subplot(2,3,1)
plot(x_axis, mag2db(Px), 'LineWidth', 1.2)
grid on; grid minor;set(gca, 'FontSize', 14);
title('N = 30, f_1 = 0.3, f_2 = 0.32')
xlabel('Normalized Frequency')
ylabel('Power Spectral Density [dB]')

n = 0:34; 
noise=0.2/sqrt(2)*(randn(size(n))+1j*randn(size(n)));
x=exp(1j*2*pi*0.3*n)+exp(1j*2*pi*0.32*n)+noise;
Px = periodogram(x,rectwin(length(x)),128);

subplot(2,3,2)
plot(x_axis, mag2db(Px), 'LineWidth', 1.2)
grid on; grid minor;set(gca, 'FontSize', 14);
title('N = 35, f_1 = 0.3, f_2 = 0.32')
xlabel('Normalized Frequency')
ylabel('Power Spectral Density [dB]')

n = 0:39; 
noise=0.2/sqrt(2)*(randn(size(n))+1j*randn(size(n)));
x=exp(1j*2*pi*0.3*n)+exp(1j*2*pi*0.32*n)+noise;
Px = periodogram(x,rectwin(length(x)),128);

subplot(2,3,3)
plot(x_axis, mag2db(Px), 'LineWidth', 1.2)
grid on; grid minor;set(gca, 'FontSize', 14);
title('N = 40, f_1 = 0.3, f_2 = 0.32')
xlabel('Normalized Frequency')
ylabel('Power Spectral Density [dB]')

n = 0:29; 
noise=0.2/sqrt(2)*(randn(size(n))+1j*randn(size(n)));
x=exp(1j*2*pi*0.3*n)+exp(1j*2*pi*0.34*n)+noise;
Px = periodogram(x,rectwin(length(x)),128);

subplot(2,3,4)
plot(x_axis, mag2db(Px), 'LineWidth', 1.2)
grid on; grid minor;set(gca, 'FontSize', 14);
title('N = 30, f_1 = 0.3, f_2 = 0.34')
xlabel('Normalized Frequency')
ylabel('Power Spectral Density [dB]')

n = 0:34; 
noise=0.2/sqrt(2)*(randn(size(n))+1j*randn(size(n)));
x=exp(1j*2*pi*0.3*n)+exp(1j*2*pi*0.34*n)+noise;
Px = periodogram(x,rectwin(length(x)),128);

subplot(2,3,5)
plot(x_axis, mag2db(Px), 'LineWidth', 1.2)
grid on; grid minor;set(gca, 'FontSize', 14);
title('N = 35, f_1 = 0.3, f_2 = 0.34')
xlabel('Normalized Frequency')
ylabel('Power Spectral Density [dB]')

n = 0:39; 
noise=0.2/sqrt(2)*(randn(size(n))+1j*randn(size(n)));
x=exp(1j*2*pi*0.3*n)+exp(1j*2*pi*0.34*n)+noise;
Px = periodogram(x,rectwin(length(x)),128);

subplot(2,3,6)
plot(x_axis, mag2db(Px), 'LineWidth', 1.2)
grid on; grid minor;set(gca, 'FontSize', 14);
title('N = 40, f_1 = 0.3, f_2 = 0.34')
xlabel('Normalized Frequency')
ylabel('Power Spectral Density [dB]')
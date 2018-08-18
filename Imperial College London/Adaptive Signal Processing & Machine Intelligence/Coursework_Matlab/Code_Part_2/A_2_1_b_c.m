%% 2.1.b/c

clear all; close all; clc

N = 1000;
nr = 100;

Px_b = zeros(nr, 2*N-1);
for i = 1:nr
    x = sin(2*pi*0.1*(0:N-1)) + 0.75*sin(2*pi*0.2*(0:N-1)) + 0.5*randn(1,N);
    ACF_b = xcorr(x, 'biased');
    Px_b(i,:) = fftshift(fft(ACF_b));
end

E_Px_b = mean(Px_b);
var_Px_b = var(Px_b);

x_axis = -0.5:0.0005:0.5-0.001;
subplot(1,2,1);
hold on;
plot(x_axis, 10*log10(Px_b), 'color', 'cyan', 'LineWidth', 1.2);
plot(x_axis, 10*log10(E_Px_b), 'color', [0 0.4470 0.7410], 'lineWidth', 2);
grid on;
grid minor;
title({'PSD Estimate of two sinusoids corrupted by noise';''});
legend('Different Realizations', 'Ensemble Average', 'location', 'best');
ylabel('dB');
xlabel('Normalized Frequency'); set(gca, 'FontSize', 14);
ylim([-40, 30])

subplot(1,2,2);
plot(x_axis, sqrt(var_Px_b), 'LineWidth', 1.2);
grid on;
grid minor;
title({'Standard Deviation of the PSD Estimate';''});
ylabel('dB');
xlabel('Normalized Frequency');set(gca, 'FontSize', 14);
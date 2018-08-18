%% 1.4.b)
clear all; close all; clc

load('EEG_Data_Assignment1.mat');

N = length(POz);
K = 10*fs;

%% Standard Periodogram
[P1, w] = periodogram(POz,rectwin(N),K,fs,'two-sided');

subplot(2,2,1)
plot(w, pow2db(P1), 'LineWidth', 1.2)
hold on; 
text(50, -105,'\downarrow 50 Hz')
text(39, -120,'\downarrow 39 Hz')
text(26, -110,'\downarrow 26 Hz')
text(13, -105,'\downarrow 13 Hz')
text(9, -110,'8-10 Hz \downarrow','HorizontalAlignment','right')
xlim([0 60])
ylim([-150 -90])
grid on;
grid minor; set(gca, 'FontSize', 14);
title('Standard Periodogram of the EEG Signal')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')

%% Welch Method 10s

N = 12000;

[P2, w2] = pwelch(POz, rectwin(N), [], K,fs, 'two-sided');

N = 6000;
[P3, w3] = pwelch(POz, rectwin(N), [], K,fs, 'two-sided');

N = 1200;
[P4, w4] = pwelch(POz, rectwin(N), [], K,fs, 'two-sided');

subplot(2,2,2)
plot(w2, pow2db(P2), 'LineWidth', 1.2)
hold on; 
text(50, -105,'\downarrow 50 Hz')
text(39, -120,'\downarrow 39 Hz')
text(26, -110,'\downarrow 26 Hz')
text(13, -105,'\downarrow 13 Hz')
text(9, -110,'8-10 Hz \downarrow','HorizontalAlignment','right')
xlim([0 60])
ylim([-150 -90])
grid on;
grid minor; set(gca, 'FontSize', 14);
title('Averaged Periodogram, 10s')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')

subplot(2,2,3)
plot(w3, pow2db(P3), 'LineWidth', 1.2)
hold on; 
text(50, -105,'\downarrow 50 Hz')
text(39, -120,'\downarrow 39 Hz')
text(26, -110,'\downarrow 26 Hz')
text(13, -105,'\downarrow 13 Hz')
text(9, -110,'8-10 Hz \downarrow','HorizontalAlignment','right')
xlim([0 60])
ylim([-150 -90])
grid on;
grid minor; set(gca, 'FontSize', 14);
title('Averaged Periodogram, 5s')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')

subplot(2,2,4)
plot(w4, pow2db(P4), 'LineWidth', 1.2)
hold on; 
text(50, -105,'\downarrow 50 Hz')
text(39, -120,'\downarrow 39 Hz')
text(26, -110,'\downarrow 26 Hz')
text(13, -105,'\downarrow 13 Hz')
text(9, -110,'8-10 Hz \downarrow','HorizontalAlignment','right')
xlim([0 60])
ylim([-150 -90])
grid on;
grid minor; set(gca, 'FontSize', 14);
title('Averaged Periodogram, 1s')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')
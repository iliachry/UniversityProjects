%% 4.3.d

clear all; close all; clc

load('EEG_Data_Assignment1.mat');
POz = detrend(POz);
POz = POz(1000:1000+1200-1);

N1 = 2*1200;
[~, ~, w1] = DFT_CLMS(POz,N1,1,0);

N2 = 3*1200;
[~, ~, w2] = DFT_CLMS(POz,N2,1,0);

N3 = 4*1200;
[~, ~, w3] = DFT_CLMS(POz,N3,1,0);

figure;
subplot(1,3,1);
surf(1:1200, ([0:N1-1]).*fs/N1, mag2db(abs(w1)), 'LineStyle', 'none');
view(2); ylim([0, 75]); xlim([0 1200]); caxis([-140 -100]);
xlabel('Sample'), ylabel('Frequency'); ylabel(colorbar,'dB/Hz')
title({'DFT-CLMS of EEG Signal, N = 2400';''}); set(gca, 'FontSize', 14)

subplot(1,3,2);
surf(1:1200, ([0:N2-1]).*fs/N2, mag2db(abs(w2)), 'LineStyle', 'none');
view(2); ylim([0, 75]); xlim([0 1200]); caxis([-140 -100]);
xlabel('Sample'), ylabel('Frequency'); ylabel(colorbar,'dB/Hz')
title({'DFT-CLMS of EEG Signal, N = 3600';''}); set(gca, 'FontSize', 14)

subplot(1,3,3);
surf(1:1200, ([0:N3-1]).*fs/N3, mag2db(abs(w3)), 'LineStyle', 'none');
view(2); ylim([0, 75]); xlim([0 1200]); caxis([-140 -100]);
xlabel('Sample'), ylabel('Frequency'); ylabel(colorbar,'dB/Hz')
title({'DFT-CLMS of EEG Signal, N = 4800';''}); set(gca, 'FontSize', 14)

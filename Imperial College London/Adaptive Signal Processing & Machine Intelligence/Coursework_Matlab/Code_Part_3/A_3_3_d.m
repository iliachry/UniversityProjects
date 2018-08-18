%% 3.3.d

clear all; close all; clc;

load('EEG_Data_Assignment2.mat');
POz = detrend(POz);
N = length(POz);

noise = sin(2*pi*50/fs*(1:N)) + sqrt(0.25)*randn(1,N);

M = [5, 10, 15, 20];
mu = [0.001, 0.005, 0.01, 0.05,0.1]; 

x_ANC_mu = zeros(N, length(mu)); 
for i = 1:length(mu)
    [x_ANC_mu(:,i), ~] = ANC(POz, 10, mu(i), noise);
end

x_ANC_M = zeros(N, length(M));
for i = 1:length(M)
    [x_ANC_M(:,i), ~] = ANC(POz, M(i), 0.1, noise);
end

M = 4096;
noverlap = round(0.75*M);

figure;
subplot(2,3,1);
spectrogram(POz, hann(M), noverlap, M, fs, 'yaxis');
ylim([0, 100]); title('POz'); set(gca, 'FontSize', 11);

subplot(2,3,2);
spectrogram(x_ANC_mu(:,1), hann(M), noverlap, M, fs, 'yaxis');
ylim([0, 100]); title('POz Estimate \mu = 0.001'); set(gca, 'FontSize', 11);

subplot(2,3,3);
spectrogram(x_ANC_mu(:,2), hann(M), noverlap, M, fs, 'yaxis');
ylim([0, 100]); title('POz Estimate \mu = 0.005'); set(gca, 'FontSize', 11);


subplot(2,3,4);
spectrogram(x_ANC_mu(:,3), hann(M), noverlap, M, fs, 'yaxis');
ylim([0, 100]); title('POz Estimate \mu = 0.01'); set(gca, 'FontSize', 11);

subplot(2,3,5);
spectrogram(x_ANC_mu(:,4), hann(M), noverlap, M, fs, 'yaxis');
ylim([0, 100]);title('POz Estimate \mu = 0.05'); set(gca, 'FontSize', 11);

subplot(2,3,6);
spectrogram(x_ANC_mu(:,5), hann(M), noverlap, M, fs, 'yaxis');
ylim([0, 100]);title('POz Estimate \mu = 0.1'); set(gca, 'FontSize', 11);

figure;
subplot(2,2,1);
spectrogram(x_ANC_M(:,1), hann(M), noverlap, M, fs, 'yaxis');
ylim([0, 100]); title('POz Estimate M = 5'); set(gca, 'FontSize', 14);

subplot(2,2,2);
spectrogram(x_ANC_M(:,2), hann(M), noverlap, M, fs, 'yaxis');
ylim([0, 100]); title('POz Estimate M = 10'); set(gca, 'FontSize', 14);

subplot(2,2,3);
spectrogram(x_ANC_M(:,3), hann(M), noverlap, M, fs, 'yaxis');
ylim([0, 100]); title('POz Estimate M = 15'); set(gca, 'FontSize', 14);

subplot(2,2,4);
spectrogram(x_ANC_M(:,4), hann(M), noverlap, M, fs, 'yaxis');
ylim([0, 100]); title('POz Estimate M = 20'); set(gca, 'FontSize', 14);
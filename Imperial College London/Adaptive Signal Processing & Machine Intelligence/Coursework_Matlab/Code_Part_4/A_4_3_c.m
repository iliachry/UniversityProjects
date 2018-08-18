%% 4.3.c

clear all; close all; clc

N = 1500;
fs = 1500;

eta = wgn(1,1500, pow2db(0.05), 'complex');
f = [100*ones(1,500), 100*ones(1,500)+ ((501:1000)-500)/2, 100*ones(1,500) + (((1001:1500)-1000)/25).^2];
phi = cumsum(f);
y = exp(1i*2*pi/fs*phi)+eta;

[~, ~, w1] = DFT_CLMS(y,N,1,0);

[~, ~, w2] = DFT_CLMS(y,N,1,0.05);

[~, ~, w3] = DFT_CLMS(y,N,1,0.1);

figure;
subplot(1,3,1);
surf(1:length(y), ([0:N-1]).*fs/N./1000, abs(w1), 'LineStyle', 'none');
view(2); ylim([0, 0.55])
xlabel('Sample'), ylabel('Frequency'); title('DFT-CLMS'); 
set(gca, 'FontSize', 14)

subplot(1,3,2);
surf(1:length(y), ([0:N-1]).*fs/N./1000, abs(w2), 'LineStyle', 'none');
view(2); ylim([0, 0.55])
xlabel('Sample'), ylabel('Frequency'); title('Leaky DFT-CLMS \gamma = 0.05'); 
set(gca, 'FontSize', 14)

subplot(1,3,3);
surf(1:length(y), ([0:N-1]).*fs/N./1000, abs(w3), 'LineStyle', 'none');
view(2); ylim([0, 0.55])
xlabel('Sample'), ylabel('Frequency'); title('Leaky DFT-CLMS \gamma = 0.1'); 
set(gca, 'FontSize', 14)
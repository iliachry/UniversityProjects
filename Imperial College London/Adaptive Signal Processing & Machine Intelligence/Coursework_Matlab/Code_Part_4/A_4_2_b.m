%% 4.2.b

clear all; close all; clc;

N = 1500;
fs = 2000;

eta = wgn(1,1500, pow2db(0.05), 'complex');
f = [100*ones(1,500), 100*ones(1,500)+ ((501:1000)-500)/2, 100*ones(1,500) + (((1001:1500)-1000)/25).^2];
phi = cumsum(f);
y = exp(1i*2*pi/fs*phi)+eta;

[~, ~, a1] = CLMS_e(y, 0.005, 1);

M = 2048;
H1 = zeros(M,N);
for i = 1:N
    [h, w] = freqz(1, [1; -conj(a1(i))], M,fs);
    H1(:,i) = abs(h).^2;
end

medianH = 50*median(median(H1));
H1(H1>medianH) = medianH;

[~, ~, a2] = CLMS_e(y, 0.05, 1);

M = 2048;
H2 = zeros(M,N);
for i = 1:N
    [h, w] = freqz(1, [1; -conj(a2(i))], M,fs);
    H2(:,i) = abs(h).^2;
end

medianH = 50*median(median(H2));
H2(H2>medianH) = medianH;

[~, ~, a3] = CLMS_e(y, 0.5, 1);

M = 2048;
H3 = zeros(M,N);
for i = 1:N
    [h, w] = freqz(1, [1; -conj(a3(i))], M,fs);
    H3(:,i) = abs(h).^2;
end

medianH = 50*median(median(H3));
H3(H3>medianH) = medianH;

figure;
subplot(1,3,1);
surf(1:length(y), w/1000, H1.^2, 'LineStyle', 'none');
view(2); %ylim([0 0.55]);
xlabel('Sample'), ylabel('Frequency'); title({'CLMS AR Spectrum, \mu = 0.005';''}); 
set(gca, 'FontSize', 14)


subplot(1,3,2);
surf(1:length(y), w/1000, H2.^2, 'LineStyle', 'none');
view(2); %ylim([0 0.55]);
xlabel('Sample'), ylabel('Frequency'); title({'CLMS AR Spectrum, \mu = 0.05';''}); 
set(gca, 'FontSize', 14)

subplot(1,3,3);
surf(1:length(y), w/1000, H3.^2, 'LineStyle', 'none');
view(2); %ylim([0 0.55]);
xlabel('Sample'), ylabel('Frequency'); title({'CLMS AR Spectrum, \mu = 0.5';''}); 
set(gca, 'FontSize', 14)
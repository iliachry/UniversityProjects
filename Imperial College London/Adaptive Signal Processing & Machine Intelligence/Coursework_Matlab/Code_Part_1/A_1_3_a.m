%% 1.3.a

clear all; close all; clc;

N = [8, 16, 32, 64, 128, 256, 512];
K = 2^10;

peaks_f = zeros(3,length(N));
p_3dB = zeros(1, length(N));

for i = 1:length(N)
    wb = bartlett(N(i));
    Wb = abs(fftshift(fft(wb,K))); 
    Wb = Wb'./max(Wb);
    
    f = -1:2/K:1-1/K;
    y = ones(1, length(Wb))./sqrt(2);

    points = InterX([f; mag2db(Wb)], [f; mag2db(y)]);
    
    p_3dB(i) = points(1,2);
    
    peaks = findpeaks(mag2db(Wb));
    
    peaks = sort(peaks,'descend');
    
    peaks_f(1,:) = peaks(2) - peaks(1);
    peaks_f(2,:) = peaks(3) - peaks(1); 
    peaks_f(3,:) = peaks(4) - peaks(1); 
    
end

subplot(1,3,1)
plot(N, peaks_f(1,:),'--', 'LineWidth', 1.2);
hold on
plot(N, peaks_f(2,:),'-.', 'LineWidth', 1.2);
plot(N, peaks_f(3,:), 'LineWidth', 1.2);
grid on;
grid minor;set(gca, 'FontSize', 14);
ylabel('Magnitude [dB]')
xlabel('N')
xlim([8, N(end)]);
legend('First Sidelobe', 'Second Sidelobe', 'Third Sidelobe', 'location', 'best')
title({'Peaks of the first 3 Sidelobes';''})

subplot(1,3,2)
plot(N, p_3dB, 'LineWidth', 1.2);
grid on;
grid minor;set(gca, 'FontSize', 14);
ylabel('Magnitude [dB]')
xlabel('N')
xlim([8, N(end)]);
title({'3 dB Main Lobe as a function of N';''})

subplot(1,3,3)
plot(1./N, p_3dB, 'LineWidth', 1.2);
grid on;
grid minor;set(gca, 'FontSize', 14);
ylabel('Magnitude [dB]')
xlabel('N')
xlim([0, 0.125]);
title({'3 dB Main Lobe as a function of 1/N';''})


%% Verification

N = 8;
wb = bartlett(N);
Wb = abs(fftshift(fft(wb,K))); 
Wb = Wb'./max(Wb);

f = -1:2/K:1-1/K;
y = ones(1, length(Wb))./sqrt(2);

figure;
subplot(3,2,1)
plot(f, Wb, 'LineWidth', 1.2);
hold on 
plot(f, y, 'LineWidth', 1.2);
grid on;
grid minor;set(gca, 'FontSize', 14);
ylabel('Magnitude')
xlabel('Frequency')
title('N = 8')

subplot(3,2,2)
plot(f, mag2db(Wb), 'LineWidth', 1.2);
hold on 
plot(f, mag2db(y), 'LineWidth', 1.2);
grid on;
grid minor;set(gca, 'FontSize', 14);
ylabel('Magnitude [dB]')
xlabel('Frequency')
title('N = 8')

N = 64;
wb = bartlett(N);
Wb = abs(fftshift(fft(wb,K))); 
Wb = Wb'./max(Wb);

f = -1:2/K:1-1/K;
y = ones(1, length(Wb))./sqrt(2);

subplot(3,2,3)
plot(f, Wb, 'LineWidth', 1.2);
hold on 
plot(f, y, 'LineWidth', 1.2);
grid on;
grid minor;set(gca, 'FontSize', 14);
ylabel('Magnitude')
xlabel('Frequency')
title('N = 64')

subplot(3,2,4)
plot(f, mag2db(Wb), 'LineWidth', 1.2);
hold on 
plot(f, mag2db(y), 'LineWidth', 1.2);
grid on;
grid minor;set(gca, 'FontSize', 14);
ylabel('Magnitude [dB]')
xlabel('Frequency')
title('N = 64')

N = 128;
wb = bartlett(N);
Wb = abs(fftshift(fft(wb,K))); 
Wb = Wb'./max(Wb);

f = -1:2/K:1-1/K;
y = ones(1, length(Wb))./sqrt(2);

subplot(3,2,5)
plot(f, Wb, 'LineWidth', 1.2);
hold on 
plot(f, y, 'LineWidth', 1.2);
grid on;
grid minor;set(gca, 'FontSize', 14);
ylabel('Magnitude')
xlabel('Frequency')
title('N = 128')

subplot(3,2,6)
plot(f, mag2db(Wb), 'LineWidth', 1.2);
hold on 
plot(f, mag2db(y), 'LineWidth', 1.2);
grid on;
grid minor;set(gca, 'FontSize', 14);
ylabel('Magnitude [dB]')
xlabel('Frequency')
title('N = 128')


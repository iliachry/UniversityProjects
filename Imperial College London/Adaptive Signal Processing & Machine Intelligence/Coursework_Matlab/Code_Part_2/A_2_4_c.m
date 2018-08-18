%% 2.4.c

clear all; close all; clc; 

load Trial1.mat; load Trial2.mat; load Trial3.mat

clear all; close all; clc; 

load Trial1.mat; load Trial2.mat; load Trial3.mat

xRRI1 = detrend(xRRI1);
xRRI2 = detrend(xRRI2);
xRRI3 = detrend(xRRI3);

[Px1, f1] = pwelch(xRRI1, rectwin(200), 0,  2^13, 4);
[Px2, f2] = pwelch(xRRI2, rectwin(200), 0, 2^13, 4);
[Px3, f3] = pwelch(xRRI3, rectwin(200), 0,  2^13, 4);

h = zeros(4096,length(5:30));
error = zeros(1,length(5:30));
for p = 5:30
    [a, e] = aryule(xRRI1, p);
    h(:,p) = freqz(sqrt(e), a, 2^12, 4);
    error(p) = immse(h(:,p), h(:,1));
end

figure;
subplot(1,3,1)
plot(5:30, error(5:30), 'LineWidth', 2)
grid on; grid minor;
title({'MSE of Estimated Models - Trial 1';''})
xlabel('Model order p')
ylabel('Error')
xlim([5 30])
set(gca, 'FontSize', 14)

h = zeros(4096,length(5:30));
error = zeros(1,length(5:30));
for p = 5:30
    [a, e] = aryule(xRRI2, p);
    h(:,p) = freqz(sqrt(e), a, 2^12, 4);
    error(p) = immse(h(:,p), h(:,1));
end

subplot(1,3,2)
plot(5:30, error(5:30), 'LineWidth', 2)
grid on; grid minor;
title({'MSE of Estimated Models - Trial 2';''})
xlabel('Model order p')
ylabel('Error')
xlim([5 30])
set(gca, 'FontSize', 14)

h = zeros(4096,length(5:30));
error = zeros(1,length(5:30));
for p = 5:30
    [a, e] = aryule(xRRI3, p);
    h(:,p) = freqz(sqrt(e), a, 2^12, 4);
    error(p) = immse(h(:,p), h(:,1));
end

subplot(1,3, 3)
plot(5:30, error(5:30), 'LineWidth', 2)
grid on; grid minor;
title({'MSE of Estimated Models - Trial 3';''})
xlabel('Model order p')
ylabel('Error')
xlim([5 30])
set(gca, 'FontSize', 14)

[a1, e1] = aryule(xRRI1, 12);
h1 = freqz(sqrt(e1), a1, 2^12, 4);
[a1, e1] = aryule(xRRI1, 16);
h2 = freqz(sqrt(e1), a1, 2^12, 4);
[a1, e1] = aryule(xRRI1, 22);
h3 = freqz(sqrt(e1), a1, 2^12, 4);

figure;
subplot(3,3,1)
hold on;
plot(f1(1:(end-1)), pow2db(Px1(1:(end-1))), 'LineWidth', 1.5)
plot(f1(1:(end-1)), pow2db(abs(h1).^2), 'LineWidth', 1.5)
legend('True','p = 12')
ylim([-60, 0]);
grid on; grid minor; xlabel('Frequency'); ylabel('Power [dB]');
set(gca, 'FontSize', 14); 

subplot(3,3,2);
hold on;
plot(f1(1:(end-1)), pow2db(Px1(1:(end-1))), 'LineWidth', 1.5)
plot(f1(1:(end-1)), pow2db(abs(h2).^2), 'LineWidth', 1.5)
legend('True','p = 16')
ylim([-60, 0]);
grid on; grid minor; xlabel('Frequency'); ylabel('Power [dB]');
set(gca, 'FontSize', 14); title({'Trial 1'})

subplot(3,3,3);
hold on;
plot(f1(1:(end-1)), pow2db(Px1(1:(end-1))), 'LineWidth', 1.5)
plot(f1(1:(end-1)), pow2db(abs(h3).^2), 'LineWidth', 1.5)
legend('True', 'p = 22')
ylim([-60, 0]);
grid on; grid minor; xlabel('Frequency'); ylabel('Power [dB]');
set(gca, 'FontSize', 14);

[a1, e1] = aryule(xRRI2, 11);
h1 = freqz(sqrt(e1), a1, 2^12, 4);
[a1, e1] = aryule(xRRI2, 19);
h2 = freqz(sqrt(e1), a1, 2^12, 4);
[a1, e1] = aryule(xRRI2, 23);
h3 = freqz(sqrt(e1), a1, 2^12, 4);

subplot(3,3,4)
hold on;
plot(f1(1:(end-1)), pow2db(Px2(1:(end-1))), 'LineWidth', 1.5)
plot(f1(1:(end-1)), pow2db(abs(h1).^2), 'LineWidth', 1.5)
legend('True','p = 11')
ylim([-60, 0]);
grid on; grid minor; xlabel('Frequency'); ylabel('Power [dB]');
set(gca, 'FontSize', 14);
subplot(3,3,5);
hold on;
plot(f1(1:(end-1)), pow2db(Px2(1:(end-1))), 'LineWidth', 1.5)
plot(f1(1:(end-1)), pow2db(abs(h2).^2), 'LineWidth', 1.5)
legend('True','p = 19')
ylim([-60, 0]);
grid on; grid minor; xlabel('Frequency'); ylabel('Power [dB]');
set(gca, 'FontSize', 14); title({'Trial 2'})

subplot(3,3,6);
hold on;
plot(f1(1:(end-1)), pow2db(Px2(1:(end-1))), 'LineWidth', 1.5)
plot(f1(1:(end-1)), pow2db(abs(h3).^2), 'LineWidth', 1.5)
legend('True', 'p = 23')
ylim([-60, 0]);
grid on; grid minor; xlabel('Frequency'); ylabel('Power [dB]');
set(gca, 'FontSize', 14); 

[a1, e1] = aryule(xRRI3, 9);
h1 = freqz(sqrt(e1), a1, 2^12, 4);
[a1, e1] = aryule(xRRI3, 14);
h2 = freqz(sqrt(e1), a1, 2^12, 4);
[a1, e1] = aryule(xRRI3, 18);
h3 = freqz(sqrt(e1), a1, 2^12, 4);

subplot(3,3,7)
hold on;
plot(f1(1:(end-1)), pow2db(Px3(1:(end-1))), 'LineWidth', 1.5)
plot(f1(1:(end-1)), pow2db(abs(h1).^2), 'LineWidth', 1.5)
legend('True','p = 9')
ylim([-60, 0]);
grid on; grid minor; xlabel('Frequency'); ylabel('Power [dB]');
set(gca, 'FontSize', 14); 

subplot(3,3,8);
hold on;
plot(f1(1:(end-1)), pow2db(Px3(1:(end-1))), 'LineWidth', 1.5)
plot(f1(1:(end-1)), pow2db(abs(h2).^2), 'LineWidth', 1.5)
legend('True','p = 14')
ylim([-60, 0]);
grid on; grid minor; xlabel('Frequency'); ylabel('Power [dB]');
set(gca, 'FontSize', 14); title({'Trial 3'})

subplot(3,3,9);
hold on;
plot(f1(1:(end-1)), pow2db(Px3(1:(end-1))), 'LineWidth', 1.5)
plot(f1(1:(end-1)), pow2db(abs(h3).^2), 'LineWidth', 1.5)
legend('True', 'p = 18')
ylim([-60, 0]);
grid on; grid minor; xlabel('Frequency'); ylabel('Power [dB]');
set(gca, 'FontSize', 14);

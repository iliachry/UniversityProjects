%% 2.2.b

clear all; close all; clc

N = 10000; 
x = filter(1, [1, -2.76, 3.81, -2.65, 0.92], randn(1,N));
x = x(501:end);

h = zeros(1024,14);
w = zeros(1024,14);
error = zeros(1,14);
[h(:,1), w(:,1)] = freqz(1, [1, -2.76, 3.81, -2.65, 0.92], 1024);

for p = 2:14
    [a, e] = aryule(x, p);
    [h(:,p), w(:,p)] = freqz(sqrt(e), a, 1024);
    error(p) = immse(h(:,p), h(:,1));
end

error(1) = error(2);
[~, idx1] = min(error);
temp = error(idx1);
error(idx1) = error(1);
[~, idx2] = min(error);
error(idx1) = temp;

subplot(1,2,1);
plot(2:14, error(2:14), 'LineWidth', 1.2)
grid on; grid minor;set(gca, 'FontSize', 14);
title('Mean-Squared error of Estimated Models')
xlabel('Model order p')
ylabel('Error')

subplot(1,2,2);
plot(w(:,1), mag2db(abs(h(:,1)).^2), 'LineWidth', 1.2)
hold on
plot(w(:,idx1), mag2db(abs(h(:,idx1)).^2), 'LineWidth', 1.2);
plot(w(:,idx2), mag2db(abs(h(:,idx2)).^2), 'LineWidth', 1.2);
xlim([0,3]);
grid on; grid minor;set(gca, 'FontSize', 14);
title('True & Estimates PSD of AR(4) process');
xlabel('Angular Frequency');
ylabel('PSD [dB]');
legend({'True', ['p_1 = ', num2str(idx1)], ['p_2 = ', num2str(idx2)]});


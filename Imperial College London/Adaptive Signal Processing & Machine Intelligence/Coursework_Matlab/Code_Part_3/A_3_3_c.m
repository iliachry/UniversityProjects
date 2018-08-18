%% 3.3.c

clear all; close all; clc; 

N = 1000; 
M = 2:20;
mu = 0.01;
omega0 = 0.01*pi;
x = sin(omega0*(1:N));

x_ANC = zeros(N,4,100); x_ALE = zeros(N, 4, 100);
SPE_ANC = zeros(N, length(M)); SPE_ALE = zeros(N, length(M));
for j = 1:length(M)
    for i = 1:100
        n = randn(1,N);
        eta = filter([1, 0, 0.5], 1, n);
        s = x + eta;
        [x_ANC(:,j,i), ~] = ANC(s, M(j), mu, n);
        SPE_ANC(:,j) = SPE_ANC(:,j) + (x' - x_ANC(:,j,i)).^2;
        [x_ALE(:,j,i), ~, ~] = ALE(s, M(j), mu, 3);
        SPE_ALE(:,j) = SPE_ALE(:,j) + (x' - x_ALE(:,j,i)).^2;
    end
end

MSPE_ANC = mean(SPE_ANC)/100;
MSPE_ALE = mean(SPE_ALE)/100;

figure; 
subplot(1,2,1); hold on; 
plot(MSPE_ANC, 'LineWidth', 1.2); 
plot(MSPE_ALE, 'LineWidth', 1.2);
grid on; grid minor; xlabel('M'); ylabel('MSPE');
title('MSPE vs filter length M'); set(gca, 'FontSize', 14);
legend('ANC', 'ALE \Delta = 3', 'Location', 'best');

subplot(1,2,2); 
plot(mean(x_ANC(:,4,:),3), 'LineWidth', 1.2);
grid on; grid minor; xlabel('Sample'); ylabel('x');
title('ANC Estimate, M = 5'); set(gca, 'FontSize', 14);

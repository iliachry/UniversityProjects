%% 3.3.b

clear all; close all; clc;

N = 1000;
M = [5, 10, 15, 20];
delta = 3:25;
mu = 0.01;
omega0 = 0.01*pi;
x = sin(omega0*(1:N));

x_est = zeros(N,length(delta),4,1000); 
SPE = zeros(N,length(delta), 4);
for j = 1:length(delta)
    for k = 1:length(M)
        for i = 1:1000
            n = randn(1,N);
            eta = filter([1, 0, 0.5], 1, n);
            s = x + eta;
            [x_est(:,j,k,i), ~, ~] = ALE(s, M(k), mu, delta(j));
            SPE(:,j,k) = SPE(:,j,k) + (x' - x_est(:,j,k,i)).^2;
        end
    end
end
MSPE = mean(SPE)/1000;

figure; hold on; 
plot(MSPE(1,:,1), 'LineWidth', 1.2); 
plot(MSPE(1,:,2), 'LineWidth', 1.2); 
plot(MSPE(1,:,3), 'LineWidth', 1.2); 
plot(MSPE(1,:,4), 'LineWidth', 1.2); 
grid on; grid minor; xlabel('\Delta'); ylabel('MSPE');
title('MSPE vs \Delta & M'); set(gca, 'FontSize', 14);
legend('M = 5', 'M = 10', 'M = 15', 'M = 20', 'Location', 'best');


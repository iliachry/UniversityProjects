%% 3.3.a

clear all; close all; clc;

N = 1000;
M = 5;
delta = [1, 2, 3, 4, 5, 6];
mu = 0.01;
omega0 = 0.01*pi;
x = sin(omega0*(1:N));

x_est = zeros(N,4,1000); 
SPE = zeros(N,length(delta));
for j = 1:length(delta)
    for i = 1:1000
        n = randn(1,N);
        eta = filter([1, 0, 0.5], 1, n);
        s = x + eta;
        [x_est(:,j,i),~, ~] = ALE(s, M, mu, delta(j));
        SPE(:,j) = SPE(:,j) + (x' - x_est(:,j,i)).^2;
    end
end

MSPE1 = mean(SPE(:,1))/1000;
MSPE2 = mean(SPE(:,2))/1000;
MSPE3 = mean(SPE(:,3))/1000;
MSPE4 = mean(SPE(:,4))/1000;
MSPE5 = mean(SPE(:,5))/1000;
MSPE6 = mean(SPE(:,6))/1000;

figure; 
subplot(2,3,1);
plot(mean(x_est(:,1,:),3), 'LineWidth', 1.2)
grid on; grid minor; xlabel('Sample'); ylabel('Estimate');
title('\Delta = 1, MSPE = 0.4649'); set(gca, 'FontSize', 14);
subplot(2,3,2);
plot(mean(x_est(:,2,:),3), 'LineWidth', 1.2)
grid on; grid minor; xlabel('Sample'); ylabel('Estimate');
title('\Delta = 2, MSPE = 0.4751'); set(gca, 'FontSize', 14);
subplot(2,3,3);
plot(mean(x_est(:,3,:),3), 'LineWidth', 1.2)
grid on; grid minor; xlabel('Sample'); ylabel('Estimate');
title('\Delta = 3, MSPE = 0.3322'); set(gca, 'FontSize', 14);
subplot(2,3,4);
plot(mean(x_est(:,4,:),3), 'LineWidth', 1.2)
grid on; grid minor; xlabel('Sample'); ylabel('Estimate');
title('\Delta = 4, MSPE = 0.3016'); set(gca, 'FontSize', 14);
subplot(2,3,5);
plot(mean(x_est(:,5,:),3), 'LineWidth', 1.2)
grid on; grid minor; xlabel('Sample'); ylabel('Estimate');
title('\Delta = 5, MSPE = 0.3316'); set(gca, 'FontSize', 14);
subplot(2,3,6);
plot(mean(x_est(:,6,:),3), 'LineWidth', 1.2)
grid on; grid minor; xlabel('Sample'); ylabel('Estimate');
title('\Delta = 6, MSPE = 0.3133'); set(gca, 'FontSize', 14);
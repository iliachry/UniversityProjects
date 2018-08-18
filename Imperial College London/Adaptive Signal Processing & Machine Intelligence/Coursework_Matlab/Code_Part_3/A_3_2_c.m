%% 3.2.c

clear all; close all; clc

N = 1000;
L = 1;

wmat_BEN = zeros(L+1,N,100);
wmat_GNGD = zeros(L+1,N,100);

for i = 1:100
   x = sqrt(0.5)*randn(1,N);
   d = filter([1, 0.9], 1, x); 
   
   % GNGD
   [~, wmat_GNGD(:,:,i)] = GNGD(x, d, L, 0.1, 0.01, 1);
   
   % Benveniste 
   rho = 0.003;
   alpha = 0;
   mu0 = 0;
   alg = 'BEN';
   [~, wmat_BEN(:,:,i)] = LMS_GASS(x, d, L, mu0, rho, alpha, alg);
end

b1_BEN = 0.9*ones(1,N) - mean(wmat_BEN(2,:,:),3);
b1_GNGD = 0.9*ones(1,N) - mean(wmat_GNGD(2,:,:),3);

figure;
subplot(1,2,1); hold on; 
plot(b1_BEN(1:100), 'LineWidth', 1.2);
plot(b1_GNGD(1:100), 'LineWidth', 1.2);
grid on; grid minor; xlabel('Sample'); ylabel('Weight Error');
title('Weight Error Curves Comparison'); set(gca, 'FontSize', 14);
legend('BEN \rho = 0.003', 'GNGD \mu = 0.1, \rho = 0.01')
ylim([-0.05 0.95]);

subplot(1,2,2); hold on; 
plot(mean(wmat_BEN(1,1:100,:),3), 'LineWidth', 1.2);
plot(mean(wmat_BEN(2,1:100,:),3), 'LineWidth', 1.2);
plot(mean(wmat_GNGD(1,1:100,:),3), 'LineWidth', 1.2);
plot(mean(wmat_GNGD(2,1:100,:),3), 'LineWidth', 1.2);
grid on; grid minor; xlabel('Sample'); ylabel('Weight Error');
title('Weight Estimates'); set(gca, 'FontSize', 14);
legend('BEN b_0','BEN b_1', 'GNGD b_0', 'GNGD b_1', 'Location', 'best'); 
ylim([0 1.05]);

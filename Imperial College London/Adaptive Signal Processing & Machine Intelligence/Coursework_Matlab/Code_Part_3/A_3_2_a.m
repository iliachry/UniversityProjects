%% 3.2.a

clear all; close all; clc;

N = 1000;
L = 1;

wmat_LMS_01 = zeros(L+1,N,100); wmat_LMS_1 = zeros(L+1,N,100);

wmat_BEN_001 = zeros(L+1,N,100); wmat_BEN_01 = zeros(L+1,N,100);
wmat_BEN_1 = zeros(L+1,N,100);

wmat_AF_001_25 = zeros(L+1, N, 100); wmat_AF_01_25 = zeros(L+1, N, 100); 
wmat_AF_025_5 = zeros(L+1, N, 100); wmat_AF_01_5 = zeros(L+1, N, 100);
wmat_AF_01_75 = zeros(L+1, N, 100); 

wmat_MX_001 = zeros(L+1, N, 100); wmat_MX_002 = zeros(L+1, N, 100);
wmat_MX_003 = zeros(L+1, N, 100);


for i = 1:100
   x = sqrt(0.5)*randn(1,N);
   d = filter([1, 0.9], 1, x); 
   
   % LMS
   mu1 = 0.01;
   mu2 = 0.1;
   [~, wmat_LMS_01(:,:,i)] = LMS(x, d, mu1, L);
   [~, wmat_LMS_1(:,:,i)] =  LMS(x, d, mu2, L);

   % Benveniste GASS
   mu0 = 0;
   rho1 = 0.001;
   rho2 = 0.002;
   rho3 = 0.003;
   alpha = 0;
   alg = 'BEN';
   [~, wmat_BEN_001(:,:,i)] = LMS_GASS(x, d, L, mu0, rho1, alpha, alg);
   [~, wmat_BEN_01(:,:,i)] = LMS_GASS(x, d, L, mu0, rho2, alpha, alg);
   [~, wmat_BEN_1(:,:,i)] = LMS_GASS(x, d, L, mu0, rho3, alpha, alg);
   
   % Ang & Farhang
   rho1 = 0.001;
   rho2 = 0.01;
   rho3 = 0.025;
   alpha1 = 0.25; 
   alpha2 = 0.5; 
   alpha3 = 0.75;
   alg = 'A&F';
   [~, wmat_AF_001_25(:,:,i)] = LMS_GASS(x, d, L, mu0, rho1, alpha1, alg);
   [~, wmat_AF_01_25(:,:,i)] = LMS_GASS(x, d, L, mu0, rho2, alpha1, alg);
   [~, wmat_AF_025_5(:,:,i)] = LMS_GASS(x, d, L, mu0, rho3, alpha2, alg);
   [~, wmat_AF_01_5(:,:,i)] = LMS_GASS(x, d, L, mu0, rho2, alpha2, alg);
   [~, wmat_AF_01_75(:,:,i)] = LMS_GASS(x, d, L, mu0, rho2, alpha3, alg);
   
   % Matthews & Xie
   rho1 = 0.001;
   rho2 = 0.002;
   rho3 = 0.003;
   alpha = 0;
   alg = 'M&X';
   [~, wmat_MX_001(:,:,i)] = LMS_GASS(x, d, L, mu0, rho1, alpha, alg);
   [~, wmat_MX_002(:,:,i)] = LMS_GASS(x, d, L, mu0, rho2, alpha, alg);
   [~, wmat_MX_003(:,:,i)] = LMS_GASS(x, d, L, mu0, rho3, alpha, alg);
end

b1_LMS_01 = 0.9*ones(1,N)- mean(wmat_LMS_01(2,:,:),3);
b1_LMS_1 = 0.9*ones(1,N)- mean(wmat_LMS_1(2,:,:),3);

b1_BEN_001 = 0.9*ones(1,N) - mean(wmat_BEN_001(2,:,:),3);
b1_BEN_002 = 0.9*ones(1,N) - mean(wmat_BEN_01(2,:,:),3);
b1_BEN_003 = 0.9*ones(1,N) - mean(wmat_BEN_1(2,:,:),3);

b1_AF_001_25 = 0.9*ones(1,N) - mean(wmat_AF_001_25(2,:,:),3);
b1_AF_01_25 = 0.9*ones(1,N) - mean(wmat_AF_01_25(2,:,:),3);
b1_AF_025_5 = 0.9*ones(1,N) - mean(wmat_AF_025_5(2,:,:),3);
b1_AF_01_5 = 0.9*ones(1,N) - mean(wmat_AF_01_5(2,:,:),3);
b1_AF_01_75 = 0.9*ones(1,N) - mean(wmat_AF_01_75(2,:,:),3);

b1_MX_001 =  0.9*ones(1,N) - mean(wmat_MX_001(2,:,:),3);
b1_MX_002 =  0.9*ones(1,N) - mean(wmat_MX_002(2,:,:),3);
b1_MX_003 =  0.9*ones(1,N) - mean(wmat_MX_003(2,:,:),3);

figure; 
subplot(2,2,1); hold on; 
plot(b1_BEN_001(1:100), 'LineWidth', 1.2); 
plot(b1_BEN_002(1:100), 'LineWidth', 1.2);
plot(b1_BEN_003(1:100), 'LineWidth', 1.2);
grid on; grid minor; xlabel('Sample'); ylabel('Weight Error');
title('GASS Benveniste'); set(gca, 'FontSize', 14);
legend('\rho = 0.001', '\rho = 0.002', '\rho = 0.003');

subplot(2,2,2); hold on; 
plot(b1_AF_001_25(1:100), 'LineWidth', 1.2);
plot(b1_AF_01_25(1:100), 'LineWidth', 1.2);
plot(b1_AF_025_5(1:100), 'LineWidth', 1.2);
plot(b1_AF_01_5(1:100), 'LineWidth', 1.2);
plot(b1_AF_01_75(1:100), 'LineWidth', 1.2);
grid on; grid minor; xlabel('Sample'); ylabel('Weight Error');
title('GASS Ang & Farhang'); set(gca, 'FontSize', 14);
legend('\rho = 0.001, \alpha = 0.25', '\rho = 0.01, \alpha = 0.25', ...
       '\rho = 0.025, \alpha = 0.5', '\rho = 0.01, \alpha = 0.5', ...
       '\rho = 0.1, \alpha = 0.75');

subplot(2,2,3); hold on; 
plot(b1_MX_001(1:100), 'LineWidth', 1.2); 
plot(b1_MX_002(1:100), 'LineWidth', 1.2); 
plot(b1_MX_003(1:100), 'LineWidth', 1.2);
grid on; grid minor; xlabel('Sample'); ylabel('Weight Error');
title('GASS Matthews & Xie'); set(gca, 'FontSize', 14);
legend('\rho = 0.001', '\rho = 0.002', '\rho = 0.003');

subplot(2,2,4); hold on;
plot(b1_LMS_1(1:100), 'LineWidth', 1.2); 
plot(b1_LMS_01(1:100), 'LineWidth', 1.2);
plot(b1_BEN_003(1:100), 'LineWidth', 1.2);
plot(b1_AF_025_5(1:100), 'LineWidth', 1.2);
plot(b1_MX_003(1:100), 'LineWidth', 1.2);
grid on; grid minor; xlabel('Sample'); ylabel('Weight Error');
title('Comparison'); set(gca, 'FontSize', 14);
legend('LMS \mu = 0.1', 'LMS \mu = 0.01', 'BEN \rho = 0.003', ...
       'A&F \rho = 0.025, \alpha = 0.5', 'M&X \rho = 0.003');



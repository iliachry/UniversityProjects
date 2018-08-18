%% 3.1.d

clear all; close all; clc; 

N = 2000;
d = sqrt(0.25)*randn(1,N);
x = filter(1, [1, -0.1, -0.8], d);
mu = 0.05;
L = 2;

wmat1 = zeros(2,N+1,100);
wmat2 = zeros(2,N+1,100);
for i = 1:100
    mu = 0.05;
    d = sqrt(0.25)*randn(1,N);
    x = filter(1, [1, -0.1, -0.8], d);
    [~, wmat1(:,:,i)] = LMS_AR(x, mu, L);
    
    mu = 0.01;
    [~, wmat2(:,:,i)] = LMS_AR(x, mu, L);
end

coeff_1_05 = mean(mean(wmat1(1,1001:2001,:),2));
coeff_2_05 = mean(mean(wmat1(2,1001:2001,:),2));

coeff_1_01 = mean(mean(wmat2(1,1001:2001,:),2));
coeff_2_01 = mean(mean(wmat2(2,1001:2001,:),2));

a1_05 = mean(wmat1(1,:,:),3);
a2_05 = mean(wmat1(2,:,:),3);
figure;  
subplot(1,2,1); hold on;
plot(a1_05, 'LineWidth', 1.2); plot(0.1*ones(1,2001), 'LineWidth', 1.2); 
plot(a2_05, 'LineWidth', 1.2); plot(0.8*ones(1,2001), 'LineWidth', 1.2);
xlim([0 2000]); ylim([0 0.85])
grid on; grid minor; xlabel('Sample'); ylabel('Coefficients');
title('\mu = 0.05'); set(gca, 'FontSize', 14);
legend('a_1 est', 'a_1', 'a_2 est', 'a_2', 'Location', 'east')

a1_01 = mean(wmat2(1,:,:),3);
a2_01 = mean(wmat2(2,:,:),3);
subplot(1,2,2); hold on;
plot(a1_01, 'LineWidth', 1.2); plot(0.1*ones(1,2001), 'LineWidth', 1.2); 
plot(a2_01, 'LineWidth', 1.2); plot(0.8*ones(1,2001), 'LineWidth', 1.2);
xlim([0 2000]); ylim([0 0.85])
grid on; grid minor; xlabel('Sample'); ylabel('Coefficients');
title('\mu = 0.01'); set(gca, 'FontSize', 14);
legend('a_1 est', 'a_1', 'a_2 est', 'a_2', 'Location', 'east')
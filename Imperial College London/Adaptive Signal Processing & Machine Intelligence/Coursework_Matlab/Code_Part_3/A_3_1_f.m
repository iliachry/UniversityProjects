%% 3.1.f

clear all; close all; clc; 

N = 2000;
d = sqrt(0.25)*randn(1,N);
x = filter(1, [1, -0.1, -0.8], d);
mu = 0.05;
L = 2;
gamma = 0.01;

wmat1 = zeros(2,N+1,100);
wmat2 = zeros(2,N+1,100);
for i = 1:100
    mu = 0.05;
    d = sqrt(0.25)*randn(1,N);
    x = filter(1, [1, -0.1, -0.8], d);
    [~, wmat1(:,:,i)] = Leaky_LMS_AR(x, mu, L, gamma);
    
    mu = 0.01;
    [~, wmat2(:,:,i)] = Leaky_LMS_AR(x, mu, L, gamma);
end

gamma = 0.1; 
wmat3 = zeros(2,N+1,100);
wmat4 = zeros(2,N+1,100);
for i = 1:100
    mu = 0.05;
    d = sqrt(0.25)*randn(1,N);
    x = filter(1, [1, -0.1, -0.8], d);
    [~, wmat3(:,:,i)] = Leaky_LMS_AR(x, mu, L, gamma);
    
    mu = 0.01;
    [~, wmat4(:,:,i)] = Leaky_LMS_AR(x, mu, L, gamma);
end

gamma = 0.5; 
wmat5 = zeros(2,N+1,100);
wmat6 = zeros(2,N+1,100);
for i = 1:100
    mu = 0.05;
    d = sqrt(0.25)*randn(1,N);
    x = filter(1, [1, -0.1, -0.8], d);
    [~, wmat5(:,:,i)] = Leaky_LMS_AR(x, mu, L, gamma);
    
    mu = 0.01;
    [~, wmat6(:,:,i)] = Leaky_LMS_AR(x, mu, L, gamma);
end

a1_05_01 = mean(wmat1(1,:,:),3);
a2_05_01 = mean(wmat1(2,:,:),3);
a1_01_01 = mean(wmat2(1,:,:),3);
a2_01_01 = mean(wmat2(2,:,:),3);
a1_05_1 = mean(wmat3(1,:,:),3);
a2_05_1 = mean(wmat3(2,:,:),3);
a1_01_1 = mean(wmat4(1,:,:),3);
a2_01_1 = mean(wmat4(2,:,:),3);
a1_05_5 = mean(wmat5(1,:,:),3);
a2_05_5 = mean(wmat5(2,:,:),3);
a1_01_5 = mean(wmat6(1,:,:),3);
a2_01_5 = mean(wmat6(2,:,:),3);

figure;
subplot(3,2,1); hold on;
plot(a1_05_01, 'LineWidth', 1.2); plot(0.1*ones(1,2001), 'LineWidth', 1.2); 
plot(a2_05_01, 'LineWidth', 1.2); plot(0.8*ones(1,2001), 'LineWidth', 1.2);
xlim([0 2000]); ylim([0 0.85])
grid on; grid minor; xlabel('Sample'); ylabel('Coefficients');
title('\mu = 0.05, \gamma = 0.01'); set(gca, 'FontSize', 10);
legend('a_1 est', 'a_1', 'a_2 est', 'a_2', 'Location', 'east')

subplot(3,2,2); hold on;
plot(a1_01_01, 'LineWidth', 1.2); plot(0.1*ones(1,2001), 'LineWidth', 1.2); 
plot(a2_01_01, 'LineWidth', 1.2); plot(0.8*ones(1,2001), 'LineWidth', 1.2);
xlim([0 2000]); ylim([0 0.85])
grid on; grid minor; xlabel('Sample'); ylabel('Coefficients');
title('\mu = 0.01, \gamma = 0.01'); set(gca, 'FontSize', 10);
legend('a_1 est', 'a_1', 'a_2 est', 'a_2', 'Location', 'east')

subplot(3,2,3); hold on;
plot(a1_05_1, 'LineWidth', 1.2); plot(0.1*ones(1,2001), 'LineWidth', 1.2); 
plot(a2_05_1, 'LineWidth', 1.2); plot(0.8*ones(1,2001), 'LineWidth', 1.2);
xlim([0 2000]); ylim([0 0.85])
grid on; grid minor; xlabel('Sample'); ylabel('Coefficients');
title('\mu = 0.05, \gamma = 0.1'); set(gca, 'FontSize', 10);
legend('a_1 est', 'a_1', 'a_2 est', 'a_2', 'Location', 'east')

subplot(3,2,4); hold on;
plot(a1_01_1, 'LineWidth', 1.2); plot(0.1*ones(1,2001), 'LineWidth', 1.2); 
plot(a2_01_1, 'LineWidth', 1.2); plot(0.8*ones(1,2001), 'LineWidth', 1.2);
xlim([0 2000]); ylim([0 0.85])
grid on; grid minor; xlabel('Sample'); ylabel('Coefficients');
title('\mu = 0.01, \gamma = 0.1'); set(gca, 'FontSize', 10);
legend('a_1 est', 'a_1', 'a_2 est', 'a_2', 'Location', 'east')

subplot(3,2,5); hold on;
plot(a1_05_5, 'LineWidth', 1.2); plot(0.1*ones(1,2001), 'LineWidth', 1.2); 
plot(a2_05_5, 'LineWidth', 1.2); plot(0.8*ones(1,2001), 'LineWidth', 1.2);
xlim([0 2000]); ylim([0 0.85])
grid on; grid minor; xlabel('Sample'); ylabel('Coefficients');
title('\mu = 0.05, \gamma = 0.5'); set(gca, 'FontSize', 10);
legend('a_1 est', 'a_1', 'a_2 est', 'a_2', 'Location', 'east')

subplot(3,2,6); hold on;
plot(a1_01_5, 'LineWidth', 1.2); plot(0.1*ones(1,2001), 'LineWidth', 1.2); 
plot(a2_01_5, 'LineWidth', 1.2); plot(0.8*ones(1,2001), 'LineWidth', 1.2);
xlim([0 2000]); ylim([0 0.85])
grid on; grid minor; xlabel('Sample'); ylabel('Coefficients');
title('\mu = 0.01, \gamma = 0.5'); set(gca, 'FontSize', 10);
legend('a_1 est', 'a_1', 'a_2 est', 'a_2', 'Location', 'east')


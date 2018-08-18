%% 4.1.b

clear all; close all; clc;

load('high-wind.mat'); v_high = v_east + 1i*v_north;
load('medium-wind.mat'); v_medium = v_east + 1i*v_north;
load('low-wind.mat'); v_low = v_east + 1i*v_north;
N = length(v_high);

% subplot(1,3,1)
% plot(real(v_high), imag(v_high),'.', 'markerSize', 5)
% axis([-5 5 -5 5])
% rectangle('Position',[-1 -1 2 2]*0.005 ,'Curvature',[1 1], 'lineStyle', '--', 'lineWidth', 2)
% rectangle('Position',[-1 -1 2 2]*1 ,'Curvature',[1 1], 'lineStyle', '--', 'lineWidth', 0.5)
% rectangle('Position',[-1 -1 2 2]*2 ,'Curvature',[1 1], 'lineStyle', '--', 'lineWidth', 0.5)
% rectangle('Position',[-1 -1 2 2]*3 ,'Curvature',[1 1], 'lineStyle', '--', 'lineWidth', 0.5)
% rectangle('Position',[-1 -1 2 2]*4 ,'Curvature',[1 1], 'lineStyle', '--', 'lineWidth', 0.5)
% rectangle('Position',[-1 -1 2 2]*5 ,'Curvature',[1 1], 'lineStyle', '--', 'lineWidth', 0.5)
% xlabel('Real Part'); ylabel('Imaginary Part');
% title({'High Wind Speed'});
% set(gca, 'FontSize', 13);
% 
% subplot(1,3,2)
% plot(real(v_medium), imag(v_medium),'.', 'markerSize', 5)
% axis([-2 2 -2 2])
% rectangle('Position',[-1 -1 2 2]*0.001 ,'Curvature',[1 1], 'lineStyle', '--', 'lineWidth', 2)
% rectangle('Position',[-1 -1 2 2]*0.5 ,'Curvature',[1 1], 'lineStyle', '--', 'lineWidth', 0.5)
% rectangle('Position',[-1 -1 2 2]*1 ,'Curvature',[1 1], 'lineStyle', '--', 'lineWidth', 0.5)
% rectangle('Position',[-1 -1 2 2]*1.5 ,'Curvature',[1 1], 'lineStyle', '--', 'lineWidth', 0.5)
% rectangle('Position',[-1 -1 2 2]*2 ,'Curvature',[1 1], 'lineStyle', '--', 'lineWidth', 0.5)
% rectangle('Position',[-1 -1 2 2]*2.5 ,'Curvature',[1 1], 'lineStyle', '--', 'lineWidth', 0.5)
% xlabel('Real Part'); ylabel('Imaginary Part');
% title({'Medium Wind Speed'});
% set(gca, 'FontSize', 13);
% 
% subplot(1,3,3)
% plot(real(v_low), imag(v_low),'.','markerSize', 5)
% axis([-0.5 0.5 -0.5 0.5])
% rectangle('Position',[-1 -1 2 2]*0.001 ,'Curvature',[1 1], 'lineStyle', '--', 'lineWidth', 2)
% rectangle('Position',[-1 -1 2 2]*0.1 ,'Curvature',[1 1], 'lineStyle', '--', 'lineWidth', 0.5)
% rectangle('Position',[-1 -1 2 2]*0.2 ,'Curvature',[1 1], 'lineStyle', '--', 'lineWidth', 0.5)
% rectangle('Position',[-1 -1 2 2]*0.3 ,'Curvature',[1 1], 'lineStyle', '--', 'lineWidth', 0.5)
% rectangle('Position',[-1 -1 2 2]*0.4 ,'Curvature',[1 1], 'lineStyle', '--', 'lineWidth', 0.5)
% rectangle('Position',[-1 -1 2 2]*0.5 ,'Curvature',[1 1], 'lineStyle', '--', 'lineWidth', 0.5)
% xlabel('Real Part'); ylabel('Imaginary Part');
% title({'Low Wind Speed'});
% set(gca, 'FontSize', 13);

L = 1:30;

e_high_CLMS = zeros(length(L),1); e_high_ACLMS = zeros(length(L),1); 
e_medium_CLMS = zeros(length(L),1); e_medium_ACLMS = zeros(length(L),1); 
e_low_CLMS = zeros(length(L),1); e_low_ACLMS = zeros(length(L),1); 
for i = 1:length(L)
    y_est_high_CLMS = CLMS_Pred(v_high, 0.0001, L(i));
    e_high_CLMS(i) = mean(abs(v_high-y_est_high_CLMS).^2);
    y_est_high_ACLMS = ACLMS_Pred(v_high, 0.0001, L(i));
    e_high_ACLMS(i) = mean(abs(v_high-y_est_high_ACLMS).^2);
    
    y_est_medium_CLMS = CLMS_Pred(v_medium, 0.001, L(i));
    e_medium_CLMS(i) = mean(abs(v_medium-y_est_medium_CLMS).^2);
    y_est_medium_ACLMS = ACLMS_Pred(v_medium, 0.001, L(i));
    e_medium_ACLMS(i) = mean(abs(v_medium-y_est_medium_ACLMS).^2);
    
    y_est_low_CLMS = CLMS_Pred(v_low, 0.005, L(i));
    e_low_CLMS(i) = mean(abs(v_low-y_est_low_CLMS).^2);
    y_est_low_ACLMS = ACLMS_Pred(v_low, 0.005, L(i));
    e_low_ACLMS(i) = mean(abs(v_low-y_est_low_ACLMS).^2);
end

figure;
subplot(1,3,1);
plot(pow2db(e_high_CLMS), 'LineWidth', 1.2)
hold on
plot(pow2db(e_high_ACLMS), 'LineWidth', 1.2)
grid on; grid minor; xlabel('Filter Length'); ylabel('10log|e(n)|^2');
title({'High Speed Wind'; '\mu = 0.0001'}); set(gca, 'FontSize', 14);
legend('CLMS', 'ACLMS', 'Location', 'best');

subplot(1,3,2);
plot(pow2db(e_medium_CLMS), 'LineWidth', 1.2)
hold on
plot(pow2db(e_medium_ACLMS), 'LineWidth', 1.2)
grid on; grid minor; xlabel('Filter Length'); ylabel('10log|e(n)|^2');
title({'Medium Speed Wind'; '\mu = 0.001'}); set(gca, 'FontSize', 14);
legend('CLMS', 'ACLMS', 'Location', 'best');

subplot(1,3,3);
plot(pow2db(e_low_CLMS), 'LineWidth', 1.2)
hold on
plot(pow2db(e_low_ACLMS), 'LineWidth', 1.2)
grid on; grid minor; xlabel('Filter Length'); ylabel('10log|e(n)|^2');
title({'Low Speed Wind'; '\mu = 0.005'}); set(gca, 'FontSize', 14);
legend('CLMS', 'ACLMS', 'Location', 'best');

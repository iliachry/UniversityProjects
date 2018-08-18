%% 3.1.b

clear all; close all; clc; 

N = 1000;
d = sqrt(0.25)*randn(1,N);
x = filter(1, [1, -0.1, -0.8], d);
mu = 0.05;
L = 2;

[e, ~] = LMS_AR(x, mu, L);
subplot(1,2,1)
plot(10*log10(e.^2), 'LineWidth', 1)
hold on;
mu = 0.01;
[e, ~] = LMS_AR(x, mu, L);
plot(10*log10(e.^2), 'LineWidth', 1)
plot(-6*ones(1,1000),'black', 'LineWidth', 2);

ylim([-60, 10]); grid on; grid minor; xlabel('Sample'); ylabel('Error');
legend('\mu = 0.05', '\mu = 0.01', 'Location', 'best', 'Theoretical');
set(gca, 'FontSize', 14'); title('Learning Curve')


e = zeros(1000,100,2);
for i = 1:100
    mu = 0.05;
    d = sqrt(0.25)*randn(1,N);
    x = filter(1, [1, -0.1, -0.8], d);
    [e(:,i,1), ~] = LMS_AR(x, mu, L);
    
    mu = 0.01;
    [e(:,i,2), ~] = LMS_AR(x, mu, L);
end

lc1 = mean(e(:,:,1).^2,2);
lc2 = mean(e(:,:,2).^2,2);

subplot(1,2,2)
hold on;
plot(10*log10(lc1), 'LineWidth', 1);
plot(10*log10(lc2), 'LineWidth', 1);
plot(-6*ones(1,1000), 'black', 'LineWidth', 2);
grid on; grid minor; xlabel('Sample'); ylabel('Error');
legend('\mu = 0.05', '\mu = 0.01', 'Location', 'best', 'Theoretical');
set(gca, 'FontSize', 14'); title('Average Learning Curve')
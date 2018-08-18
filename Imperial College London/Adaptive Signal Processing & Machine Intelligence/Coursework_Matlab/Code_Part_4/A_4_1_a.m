%% 4.1.a

clear all; close all; clc;

N = 1500;
mu = 0.05;
L = 1;

e_CLMS = zeros(N,100); h_CLMS = zeros(L+1,N,100);
e_ACLMS = zeros(N,100); h_ACLMS = zeros(L+1,N,100); g_ACLMS = zeros(L+1,N,100);
for i = 1:100
    x = wgn(1,N,0,'complex');
    y = zeros(1,N);
    for j = 2:N
        y(j) = x(j) + (1.5+1i)*x(j-1) + (2.5-0.5j)*x(j-1)';
    end
    [e_CLMS(:,i), h_CLMS(:,:,i)] = CLMS(x, y, mu, L);
    [e_ACLMS(:,i), h_ACLMS(:,:,i), g_ACLMS(:,:,i)] = ACLMS(x, y, mu, L);
end

lc_CLMS = mean(abs(e_CLMS).^2,2);
lc_ACLMS = mean(abs(e_ACLMS).^2,2);

figure; 
subplot(1,2,1); hold on; 
plot(pow2db(lc_CLMS), 'LineWidth', 1.2); 
plot(pow2db(ones(N,1)*mean(lc_CLMS(500:1500))), 'LineWidth', 1.2);
grid on; grid minor; xlabel('Sample'); ylabel('10log|e(n)|^2');
title('Learning Curve for CLMS'); set(gca, 'FontSize', 14);
legend('Learning Curve', 'Steady State Error', 'Location', 'best');

subplot(1,2,2); hold on;
plot(pow2db(lc_ACLMS), 'LineWidth', 1.2);
plot(pow2db(ones(N,1)*mean(lc_ACLMS(1000:1500))), 'LineWidth', 1.2);
grid on; grid minor; xlabel('Sample'); ylabel('10log|e(n)|^2');
title('Learning Curve for ACLMS'); set(gca, 'FontSize', 14);
legend('Learning Curve', 'Steady State Error', 'Location', 'best');
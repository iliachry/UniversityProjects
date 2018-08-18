% Exercise 1.2 (v)
clear all
close all
% LMS
mu = [0.1, 0.01, 0.001];


[e(:,1), wnorm(:,1)]= RunLMS_mu_given(9, mu(1));
[e(:,2), wnorm(:,2)]= RunLMS_mu_given(9, mu(2));
[e(:,3), wnorm(:,3)]= RunLMS_mu_given(9, mu(3));


figure;
semilogy(e(:,1).^2);
hold on;
semilogy(e(:,2).^2);
semilogy(e(:,3).^2);
legend('mu = 0.5', 'mu = 0.01', 'mu = 0.001') 
legend('Location', 'southwest')
ylabel('e^2')
xlabel('N')
title('LMS Average Squared Error, Different mu, Real Signal');

figure;
semilogy(wnorm(:,1));
hold on;
semilogy(wnorm(:,2));
semilogy(wnorm(:,3));
legend('mu = 0.1', 'mu = 0.01', 'mu = 0.001') 
ylabel('Weighted Error Vector')
xlabel('N')
title('LMS Average Normalized Weighted Error Vector, Different mu, Real Signal');

% NLMS
[eNLMS, wnormNLMS] = RunNLMS(9);

figure;
semilogy(eNLMS);
ylabel('e^2')
xlabel('N')
title('NLMS Average Squared Error');

figure;
semilogy(wnormNLMS);
ylabel('Weighted Error Vector')
xlabel('N')
title('NLMS Average Normalized Weighted Error Vector');
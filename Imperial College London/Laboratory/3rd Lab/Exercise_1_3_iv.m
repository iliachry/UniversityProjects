% Exercise 1.3(iv)

e = zeros(400,3);
wnorm = zeros(400,3);

k = 1:9;
w1 = 1./k.*exp(-(k-4).^2/4);
w2 = 1./k.^2.*exp(-(k-4).^2/4);

N = 200;
x1 = randn(N, 1);
x2 = randn(N, 1);

d1 = filter(w1,1,x1);
d2 = filter(w2,1,x2);
d(1:N) = d1;
d(N+1:2*N) = d2;

x(1:N) = x1;
x(N+1:2*N) = x2;

L = 9;
mu_upper_bound = 1/L/std(x);
mu = 1/3 * mu_upper_bound;
[e(:,1), ~] = LMS(x, d, mu, L);

[e(:,2), ~] = NLMS(x, d, mu, L);

[e(:,3), ~] = RLS(x, d, 0.9, L);

figure;
semilogy(e(:,1).^2);
hold on;
semilogy(e(:,2).^2);
semilogy(e(:,3).^2);
legend('LMS','NLMS','RLS')
ylabel('e^2 [dB]')
xlabel('N')
title('Varying channel, Squared Error log-scale')
function [y_est, e, w] = DFT_CLMS(y, N, mu, gamma)
M = length(y);
w = zeros(N,M);
e = zeros(M,1);
y_est = zeros(M,1);
for i = 0:M-1
    x = 1/N*exp(1i*2*pi*i*(0:N-1)'/N);
    y_est(i+1) = w(:,i+1)'*x;
    e(i+1) = y(i+1)-y_est(i+1);
    w(:,i+2) = (1-mu*gamma)*w(:,i+1) + mu*conj(e(i+1))*x;
end
w = w(1:N, 1:M);
end
function [y_est, e, h, g] = ACLMS_Pred(x, mu, L)
N = length(x);
h = zeros(L+1,N+1);
g = zeros(L+1,N+1);
e = zeros(1,N);
y_est=zeros(N,1);
for i = L+2:N
    xh = x(i-1:-1:i-L-1);
    y_est(i) = h(:,i)'*xh + g(:,i)'*conj(xh);
    e(i) = x(i)-y_est(i);
    h(:,i+1) = h(:,i) + mu*conj(e(i))*xh;
    g(:,i+1) = g(:,i) + mu*conj(e(i))*conj(xh);
end
h = h(:,1:N);
g = g(:,1:N);
end
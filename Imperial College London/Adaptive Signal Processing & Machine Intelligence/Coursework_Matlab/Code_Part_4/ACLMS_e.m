function [y_est, e, h, g] = ACLMS_e(x, mu, L)
N = length(x);
h = zeros(L,N+1);
g = zeros(L,N+1);
e = zeros(1,N);
y_est=zeros(N,1);
for i = 1:N
    if i==1 
        xh = 0;
    else
        xh = x(i-1);
    end
    y_est(i) = h(:,i)'*xh + g(:,i)'*conj(xh);
    e(i) = x(i)-y_est(i);
    h(:,i+1) = h(:,i) + mu*conj(e(i))*xh;
    g(:,i+1) = g(:,i) + mu*conj(e(i))*conj(xh);
end
h = (h(:,1:N));
g = (g(:,1:N));
end
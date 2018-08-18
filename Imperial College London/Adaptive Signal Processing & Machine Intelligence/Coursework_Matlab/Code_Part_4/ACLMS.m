function [e, h, g] = ACLMS(x, y, mu, L)
N = length(x);
h = zeros(L+1,N+1);
g = zeros(L+1,N+1);
e = zeros(1,N);
for i = L+1:N
    xh = x(i:-1:i-L)';
    yh = h(:,i)'*xh + g(:,i)'*conj(xh);
    e(i) = y(i)-yh;
    h(:,i+1) = h(:,i) + mu*conj(e(i))*xh;
    g(:,i+1) = g(:,i) + mu*conj(e(i))*conj(xh);
end
h = h(:,1:N);
g = g(:,1:N);
end
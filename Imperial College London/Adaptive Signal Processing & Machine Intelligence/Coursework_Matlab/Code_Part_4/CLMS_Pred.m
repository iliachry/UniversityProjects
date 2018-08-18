function [y_est, e, h] = CLMS_Pred(x, mu, L)
N = length(x);
h = zeros(L+1,N+1);
e = zeros(1,N);
y_est = zeros(N,1);
for i = L+2:N
    xh = x(i-1:-1:i-L-2);
    y_est(i) = xh.'*conj(h(:,i));
    e(i) = x(i)-y_est(i);
    h(:,i+1) = h(:,i) + mu*conj(e(i))*xh;
end
h = h(:,1:N);
end



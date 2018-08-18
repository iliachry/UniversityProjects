function [y_est, e, h] = CLMS_e(x, mu, L)
N = length(x);
h = zeros(L,N+1);
e = zeros(1,N);
y_est = zeros(1,N);
for i = 1:N
    if i==1 
        xh = 0;
    else
        xh = x(i-1);
    end
    
    y_est(i) = xh.'*h(:,i)';
    e(i) = x(i)-y_est(i);
    h(:,i+1) = h(:,i) + mu*conj(e(i))*xh;
end
h = h(:,1:N);
end

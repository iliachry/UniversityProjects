function [e, wmat] = GNGD(x, d, L, mu, rho, beta)
N = length(x);
wmat = zeros(L+1, N);
y = zeros(1,N);
e = zeros(1,N);
epsilon = ones(1,N)*mu*rho;
for i = L+2:N
    xh1 = x(i:-1:i-L)';
    xh2 = x(i-1:-1:i-L-1)';
    y(i) = xh1'*wmat(:,i);
    e(i) = d(i) - y(i);
    wmat(:,i+1) = wmat(:,i) + beta/(epsilon(i)+xh1'*xh1)*e(i)*xh1;
    epsilon(i+1) = epsilon(i) + rho*mu*(e(i)*e(i-1)*xh1'*xh2)/(epsilon(i-1)+xh2'*xh2)^2;
end
e = e';
wmat = wmat(:,1:N);
end

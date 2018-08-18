function [e, wmat] = Leaky_LMS_AR(x, mu, L, gamma)
N = length(x);
y = zeros(1,N);
wmat = zeros(L,N+1);
e = zeros(1,N);
for i=L+1:N
    x_past = x(i-1:-1:i-L);
    y(i) = wmat(:,i)'*x_past';
    e(i) = x(i) - y(i);
    wmat(:,i+1) = (1-mu*gamma)*wmat(:,i) + mu*e(i)*x_past';
end
end


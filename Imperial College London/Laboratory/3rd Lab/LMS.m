function [e, wmat] = LMS(x, d, mu, L)
N = length(x);
wmat = zeros (N, L);
e = zeros(N,1);
for i = L:N
    e(i) = d(i) - wmat(i-1,:)*x(i:-1:(i-L+1));
    wmat(i,:) = wmat(i-1,:) + 2*mu*x(i:-1:(i-L+1))'*e(i);
end
end


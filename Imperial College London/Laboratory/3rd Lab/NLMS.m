function [e, wmat] = NLMS(x, d, mu, L )
N = length(x);
wmat = zeros (N, L);
e = zeros(N,1);
for i = L:N
    e(i) = d(i) - wmat(i-1,:)*x(i:-1:(i-L+1));
    dnm = 1 + norm(x(i:-1:(i-L+1)));
    wmat(i,:) = wmat(i-1,:) + 2*mu/dnm*x(i:-1:(i-L+1))'*e(i);
end
end


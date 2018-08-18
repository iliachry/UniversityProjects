function [e, wmat] = LMS(x, d, mu, L)
N = length(x);
wmat = zeros (L+1, N);
e = zeros(N,1);
for i = L+1:N
    xh = x(i:-1:i-L)'; 
    e(i) = d(i) - xh'* wmat(:,i);
    wmat(:,i+1) = wmat(:,i) + mu*e(i)*xh;
end
wmat = wmat(:,1:N);
end


function [x_est, e, wmat] = ALE(s, M, mu, delta)
N = length(s);
wmat = zeros(M+1,N+1);
e = zeros(1,N);
x_est = zeros(N,1);
s_delayed = [zeros(1,delta), s];
for i = M+1:N
    u = s_delayed(i:-1:i-M)';
    x_est(i) = u'*wmat(:,i);
    e(i) = s(i) - x_est(i);
    wmat(:,i+1) = wmat(:,i) + mu*e(i)*u;
end
e = e';   
wmat = wmat(:,1:N);
end


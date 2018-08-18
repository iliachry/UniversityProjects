function [x_est, wmat] = ANC(s, M, mu, epsilon)
N = length(s);
wmat = zeros(M+1,N+1);
eta_est = zeros(1,N);
x_est = zeros(N,1);
for i = M+1:N
    eh = epsilon(i:-1:i-M)';
    eta_est(i) = eh'*wmat(:,i);
    x_est(i) = s(i) - eta_est(i);
    wmat(:,i+1) = wmat(:,i) + mu*x_est(i)*eh;
end 
wmat = wmat(:,1:N);
end

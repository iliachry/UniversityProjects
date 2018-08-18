function [e, wmat] = LMS_GASS(x, d, L, mu0, rho, alpha, alg)

N = length(x);
wmat = zeros(L+1, N);
mu = ones(1,N)*mu0;
psi = zeros(L+1,N);
y = zeros(1,N);
e = zeros(1,N);

for i = L+2:N
    xh1 = x(i:-1:i-L)';
    xh2 = x(i-1:-1:i-L-1)';
    y(i) = xh1'*wmat(:,i);
    e(i) = d(i) - y(i);
    if alg == 'BEN'
        psi(:,i) = (eye(L+1)-mu(i-1)*(xh2*xh2'))*psi(:,i-1)+e(i-1)*xh2;
    elseif alg == 'A&F'
        psi(:,i) = alpha*psi(:,i-1) + e(i-1)*xh2;
    else
        psi(:,i) = e(i)*xh2;
    end
    wmat(:,i+1) = wmat(:,i) + mu(i)*e(i)*xh1;
    mu(i+1) = mu(i)+rho*e(i)*xh1'*psi(:,i);
end    
e = e';
wmat = wmat(:,1:N);
end


function [e, wmat] = RLS(x, d, lambda, L)
N = length(x);
wmat = zeros(N,L);
e = zeros(N,1);
z = zeros(L,1);
rinv = eye(L,L);
for count = L:N 
    y = x(count:-1:(count-L+1))'*wmat(count-1,:)';
    e(count) = d(count) - y;
    z = rinv*x(count:-1:(count-L+1));
    q = x(count:-1:(count-L+1))'*z;
    v = 1/(lambda + q);
    update = e(count)*v;
    wmat(count,:) = wmat(count-1,:) + update*z';
    rinv = (rinv - z*z'*v)/lambda;

end
end


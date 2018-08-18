function [T,phiT]=deft(phi,u,K)

n = size(u,1);
[phiysorted,i] = sort(u);
%T = set ( K indices with largest magnitude of u)
T = i(n-K+1:n);
% phiT now is phi with the column from T
phiT = phi(:,i(n-K+1:n));
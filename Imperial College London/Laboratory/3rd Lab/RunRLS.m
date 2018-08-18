function [e, wnorm] = RunRLS(L, Noise_factor,lambda)

N = 200;

k = 1:9;
w = 1./k.*exp(-(k-4).^2/4);

x = randn(N, 1);
% load('s1.mat');
% N = length(s1);
% x = s1;

% with noise
d = filter(w,1,x) + Noise_factor*randn(N,1);

%lambda = 1;
[e, wmat] = RLS(x, d, lambda, L);

wdn = w*w';
temp = ones(N,1);
wi = temp*w;
wnm = sum(((wmat-wi).^2)');
wnorm = wnm/wdn;

end


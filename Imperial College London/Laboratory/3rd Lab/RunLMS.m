function [e, wnorm] = RunLMS(L)

N = 200;

k = 1:9;
w = 1./k.*exp(-(k-4).^2/4);

x = randn(N, 1);
% load('s1.mat');
% N = length(s1);
% x = s1;

% without noise
% d = filter(w,1,x);

% with noise
 d = filter(w,1,x) + 0.1*randn(N,1);

mu_upper_bound = 1/L/std(x);
mu = 1/3 * mu_upper_bound;
[e, wmat] = LMS(x, d, mu, L);

wdn = w*w';
temp = ones(N,1);
wi = temp*w;
wnm = sum(((wmat-wi).^2)');
wnorm = wnm/wdn;

end
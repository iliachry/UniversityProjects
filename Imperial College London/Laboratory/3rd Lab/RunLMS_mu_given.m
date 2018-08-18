function [e, wnorm] = RunLMS_mu_given(L, mu)

N = 200;

k = 1:9;
w = 1./k.*exp(-(k-4).^2/4);

 x = randn(N, 1);
load('s1.mat');
N = length(s1);
x = s1;

d = filter(w,1,x);

[e, wmat] = LMS(x, d, mu, L);

wdn = w*w';
temp = ones(N,1);
wi = temp*w;
wnm = sum(((wmat-wi).^2)');
wnorm = wnm/wdn;

end


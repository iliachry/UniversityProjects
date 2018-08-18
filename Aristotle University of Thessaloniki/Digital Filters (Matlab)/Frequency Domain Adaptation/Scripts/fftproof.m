% "Proof" by MATLAB
% A simple technique to develop and verify the steps of a proof 
% using random data input
%
% N P P
% Cornell U 
% Sept 1992
%

% Ilias Chrysovergis
% 8009
% iliachry@ece.auth.gr

clear

n = 8; % any even

% input 
x = randn(n,1) + 1i*randn(n,1);
% correct answer
ys = fft(x);

% root of unity
w = @(n,e) exp(-2*pi*1i.*e/n);

k = (0:n-1)';

% DFT proof steps
y = zeros(n,1);

for j = 0:n-1
  y(j+1) = sum(w(n,j*k) .* x(k+1));
end

fprintf('DFT : %e\n', norm(y - ys))

% split output top bottom
y = zeros(n,1);

for j = 0:n/2-1
  y(j+1) = sum(w(n,j*k) .* x(k+1));
end
for j = n/2:n-1
  y(j+1) = sum(w(n,j*k) .* x(k+1));
end

fprintf('split output top bottom : %e\n', norm(y - ys))

% split input even odd
y = zeros(n,1);

k = (0:n/2-1)';
for j = 0:n/2-1
  y(j +1) = sum(w(n,j*2*k) .* x(2*k +1)) + sum(w(n,j*(2*k+1)) .* x(2*k+1 +1));
end
for j = n/2:n-1
  y(j +1) = sum(w(n,j*2*k) .* x(2*k +1)) + sum(w(n,j*(2*k+1)) .* x(2*k+1 +1));
end

fprintf('split input even odd : %e\n', norm(y - ys))

% apply w identities
y = zeros(n,1);
x1 = zeros(n/2,1);
x2 = zeros(n/2,1);
k = (0:n/2-1)';

for j = 0:n/2-1
    x1(j+1) = sum(w(n/2,j*k) .* x(2*k+1));
    x2(j+1) = sum(w(n/2,j*k) .* x(2*k+2));
end

y(1:n/2) = x1 + diag(w(n,k)) * x2;
y(n/2+1:n) = x1 - diag(w(n,k)) * x2;

fprintf('split input error : %e\n', norm(y - ys))

% to complete the proof
fe = fft(x((0:2:n-1) +1));
fo = fft(x((1:2:n-1) +1));

wfo = w(n,(0:n/2-1)') .* fo; 
y = [fe + wfo; fe - wfo];

fprintf('done : %e\n', norm(y - ys))

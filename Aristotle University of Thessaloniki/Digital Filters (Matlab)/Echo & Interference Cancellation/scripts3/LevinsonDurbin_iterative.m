function [a, G, L, Dp] = LevinsonDurbin_iterative(M, r)
% function [a , G, L, Dp] = LevinsonDurbin_iterative(M, r)
% Iterative version of the Levinson-Durbin algorithm 
% Levinson-Durbin recursion is an algorithm that solves 
% the Wiener-Hopf equation of an Mth order forward prediction filter 
% in O(M^2) time instead of O(M^3) with Gauss-Jordan elimination
%
% Input: 
%   M: order of the filter
%   r: autocorrelation vector r
% Output:
%   a: tap-weight vector
%   G: vector of reflection coefficients
%   L: Lower triangular matrix used to orthogonalize  b
%   b(n) = L*u(n) (see Gram-Schmidt orthogonalization)
%   Dp: Diagonal of the autocorrelation  matrix of the 
%   backward prediction error 
%
% author: Nikos Sismanis
% date: 14 May 2013

L = zeros(M+1, M+1);
Dp = zeros(M+1, 1); 
G = zeros(M,1); %  vector of reflection coefficients

ao = 1;
D = r(2);
P = r(1);
L(1, 1) = ao;
Dp(1) = P;
for m = 1:M-1
    G(m) = -D/P;
    a = [ao; 0] + G(m)*[0; ao(end:-1:1)];    
    D = a' * r(m+2:-1:2);
    P = P * (1-G(m)^2);
    ao = a;
    L(m+1, 1:m+1) = a(end:-1:1);
    Dp(m+1) = P;
end

% final iteration
G(M) = -D/P;
a = [ao; 0] + G(M)*[0; ao(end:-1:1)];
P = P * (1-G(M)^2);
L(M+1, :) = a(end:-1:1);
Dp(M+1) = P;
end
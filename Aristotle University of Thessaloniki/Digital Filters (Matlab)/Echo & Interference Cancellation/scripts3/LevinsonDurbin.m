function [a, D, P] = LevinsonDurbin(m, r)
% function [a, D, P] = LevinsonDurbin(m, r)
% Levinson-Durbin recursion is an algorithm that solves 
% the Wiener-Hopf equation of an Mth order forward prediction filter 
% in O(M^2) time instead of O(M^3) with Gauss-Jordan elimination
%
% Input: 
%   m: recursion level
%   r: autocorrelation vector r
% Output:
%   a: tap-weight vector
%   D: crosscorrelation between 
%          the forward prediction error 
%      and the delayed backward prediction 
%   P: forward prediction-error power
%
% author: Nikos Sismanis
% date: 11 May 2013

M = length(r)-1;

if m == 0    % base case
  a = 1;
  D = r(2); 
  P = r(1);
else         % recursion
  [am, D, P] = LevinsonDurbin(m-1, r);
  G = -D/P;
  a = [am; 0] + G*[0; am(end:-1:1)];
  
  if m~=M
    D = a' * r(m+2:-1:2);
    P = P * (1-G^2);
  end
end

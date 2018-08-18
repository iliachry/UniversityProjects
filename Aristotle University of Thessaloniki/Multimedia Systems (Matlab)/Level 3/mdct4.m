function y = mdct4(x)
% MDCT4 Calculates the Modified Discrete Cosine Transform
%   y = mdct4(x)
%
%   Use either a Sine or a Kaiser-Bessel Derived window (KBDWin)with 
%   50% overlap for perfect TDAC reconstruction.
%   Remember that MDCT coefs are symmetric: y(k)=-y(N-k-1) so the full
%   matrix (N) of coefs is: yf = [y;-flipud(y)];
%
%   x: input signal (can be either a column or frame per column)
%      length of x must be a integer multiple of 4 (each frame)     
%   y: MDCT of x (coefs are divided by sqrt(N))
%
%   Vectorize ! ! !

% ------- mdct4.m ------------------------------------------
% Marios Athineos, marios@ee.columbia.edu
% http://www.ee.columbia.edu/~marios/
% Copyright (c) 2002 by Columbia University.
% All rights reserved.
% ----------------------------------------------------------

[flen,fnum] = size(x);
% Make column if it's a single row
if (flen==1)
    x = x(:);
    flen = fnum;
    fnum = 1;
end
% Make sure length is multiple of 4
if (rem(flen,4)~=0)
    error('MDCT4 defined for lengths multiple of four.');
end

% We need these for furmulas below
N     = flen; % Length of window
M     = N/2;  % Number of coefficients
N4    = N/4;  % Simplify the way eqs look
sqrtN = sqrt(N);

% Preallocate rotation matrix
% It would be nice to be able to do it in-place but we cannot
% cause of the prerotation.
rot = zeros(flen,fnum);

% Shift
t = (0:(N4-1)).';
rot(t+1,:) = -x(t+3*N4+1,:);
t = (N4:(N-1)).';
rot(t+1,:) =  x(t-N4+1,:);
clear x;

% We need this twice so keep it around
t = (0:(N4-1)).';
w = diag(sparse(exp(-(1i)*2*pi*(t+1/8)/N)));

% Pre-twiddle
t = (0:(N4-1)).';
c =   (rot(2*t+1,:)-rot(N-1-2*t+1,:))...
   -(1i)*(rot(M+2*t+1,:)-rot(M-1-2*t+1,:));
% This is a really cool Matlab trick ;)
c = 0.5*w*c;
clear rot;

% FFT for N/4 points only !!!
c = fft(c,N4);

% Post-twiddle
c = (2/sqrtN)*w*c;

% Sort
t = (0:(N4-1)).';
y(2*t+1,:)     =  real(c(t+1,:));
y(M-1-2*t+1,:) = -imag(c(t+1,:));
end
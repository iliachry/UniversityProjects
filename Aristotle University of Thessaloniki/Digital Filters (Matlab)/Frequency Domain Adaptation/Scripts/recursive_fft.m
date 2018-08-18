% Ilias Chrysovergis
% 8009
% iliachry@ece.auth.gr

function [y, cost] = recursive_fft(x,cost)
n = length(x);
if n == 1
    y = x;
else
    [y1, cost] = recursive_fft(x(1:2:(n-1)),cost);
    [y2, cost] = recursive_fft(x(2:2:n),cost);
    o = exp(-2 * pi * 1i / n) .^ (0:n/2-1);
    p = o .* y2;
    cost = cost + 6*(((n-5)/2)+((n-1)/2 -1));
    y = [y1 + p , y1 - p];
    cost = cost + 4*(n-5)/2;
end
end
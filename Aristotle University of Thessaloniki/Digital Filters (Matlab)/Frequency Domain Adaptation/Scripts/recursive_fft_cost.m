% Ilias Chrysovergis
% 8009
% iliachry@ece.auth.gr

function [t] = recursive_fft_cost(n)

if (n == 1) 
    t = 0;
elseif (n == 2)
    t = 4;
else
    t = ((n/2) * 4) + (6 * n /2) + (2 * recursive_fft_cost(n/2));
end

end
function [ xhat ] = IHT( S, A, y, n )
% The Iterative Hardthresholding Algorithm 
xIHT = zeros(n, 1);
j = 0;
while norm(y - A*xIHT)/norm(y) > 10^(-6) && j < 8*S
    j = j+1;
    temp = xIHT + A'*(y - A*xIHT);
    [~, ix] = sort(abs(temp), 'descend');
    [rr, ~] = ind2sub(size(temp), ix(1:S));
    xIHT = zeros(n, 1);
    xIHT(rr) = temp(rr);
end
xhat = xIHT;
end

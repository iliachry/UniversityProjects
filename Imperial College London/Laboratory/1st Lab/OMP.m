function [ xhat ] = OMP( S, A, y, n )
% The Orthogonal Matching Pursuit Algorithm
xOMP = zeros(n,1);
xOMP_S = [];
yrOMP = y;
for i = 1:S
    temp1 = transpose(A)*yrOMP;
    [~, index] = max(abs(temp1));
    xOMP_S = [xOMP_S index];
    xs = A(:, xOMP_S)\y;
    xOMP(xOMP_S) = xs;
    yrOMP = y - A*xOMP;
end
xhat = xOMP;
end


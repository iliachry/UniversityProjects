function [ xhat ] = SP( S, A, y, n )
% The Subspace Pursuit Algorithm 

% Initialization 

% 1 
temp2 = transpose(A)*y;
[~, ix] = sort(abs(temp2), 'descend');
[rr, ~] = ind2sub(size(temp2), ix(1:S));
xSP_S = rr;

xSP = zeros(n,1);

% 2
ySP_pseudoinverse = A(:, xSP_S)\y;
ypSP = A(:, xSP_S)*ySP_pseudoinverse;
yrSP = y - ypSP;

j = 0;
%xSP_S2 = [];

% Iteration
while norm(y - A*xSP)/norm(y) > 10^(-6) && j < S
    xSP = zeros(n,1);
    j = j + 1;
    % 1
    temp3 = transpose(A)*yrSP;
    [~, ix] = sort(abs(temp3), 'descend');
    [rr, ~] = ind2sub(size(temp3), ix(1:S));
    xSP_S(end+1:end+length(rr)) = rr;
    
%     for k = 1:S
%         if ismember(rr(k), xSP_S) == 0
%             xSP_S(end+1) = rr(k);
%         end
%     end
    
    % 2
    bs = A(:, xSP_S)\y;
        
    % 3
    [~, ix] = sort(abs(bs), 'descend');
    [rr, ~] = ind2sub(size(bs), ix(1:S));

    xSP_Snew = xSP_S(rr);
    
%     xSP_Snew = [];
%     for k = 1:S
%         xSP_Snew(k) = xSP_S(rr(k));
%     end
%     
    xSP_Snew = xSP_Snew';
    xSP_S = xSP_Snew;
    
    % 4
    xSP(xSP_S) =  A(:, xSP_S)\y;
    
    
    % 5
    yrSP = y - A*xSP;
end

xhat = xSP;

end

function [idx_, dim, t] = axis_aligned(D, data)
    % Pick one random dimension
    % We use D-1 because the last column will hold the class
    dim = randi(D-1);
    % Find the data range of this dimension
    d_min = single(min(data(:,dim))) + eps; 
    d_max = single(max(data(:,dim))) - eps;
    % Pick a random value within the range as threshold
    t = d_min + rand*((d_max-d_min)); 
    % return the index of the left node
    idx_ = data(:,dim) < t;
end


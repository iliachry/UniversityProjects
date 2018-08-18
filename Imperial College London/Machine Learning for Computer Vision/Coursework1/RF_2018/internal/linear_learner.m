function [idx_, dim, t] = linear_learner( ~, data )

    % get maximum and minima along all axis
    axis_max=max(data(:,1:end-1));
    axis_min=min(data(:,1:end-1));
    
    % initialise normal to plane in 2 dimenions
    dim = zeros(size(data(:,1:end-1),2),1);
    
    % generate random points along the 2 axis
    for i=1:size(data(:,1:end-1),2)
        dim(i)=axis_min(i)+rand*(axis_max(i)-axis_min(i));
    end
    
    % initialise the threshold
    holder = zeros(1, size(data(:,1:end-1),2));
    holder(1) = dim(1);
    % determine threshold
    t = holder*dim;
    
    % Pick a random value within the range as threshold
    idx_ = data(:,1:end-1)*dim < t;

end

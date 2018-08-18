function [idx_, dim, t] = quad_feature_learner( ~, data )

    % transform into feature vector 
    non_linear_feat=get_quad_features(data);
    
    % get maximum and minima along all axis
    axis_max=max(non_linear_feat);
    axis_min=min(non_linear_feat);
    
    % initialise normal to plane in 5 dimenions
    dim = zeros(size(non_linear_feat,2),1);
    
    % generate random points along the 5 axis
    for i=1:size(non_linear_feat,2)
        dim(i)=axis_min(i)+rand*(axis_max(i)-axis_min(i));
    end
    
    % determine threshold
    t = [dim(1) 0 0 0 0]*dim;
    
    % Pick a random value within the range as threshold
    idx_ = non_linear_feat*dim < t;

end


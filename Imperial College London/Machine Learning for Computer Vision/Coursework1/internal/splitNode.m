function [ig_best,node,nodeL,nodeR] = splitNode(data,node,param)
% Split node
ig_best = -inf;
visualise = 0;

% Initilise child nodes
iter = param.splitNum;
nodeL = struct('idx',[],'t',nan,'dim',0,'prob',[]);
nodeR = struct('idx',[],'t',nan,'dim',0,'prob',[]);

if length(node.idx) <= 5 % make this node a leaf if has less than 5 data points
    node.t = nan;
    node.dim = 0;
    return;
end

idx = node.idx;
data = data(idx,:);
[N,D] = size(data);
% ig_best = -inf; % Initialise best information gain
idx_best = [];

for n = 1:iter
    
    % Split function - Modify here and try other types of split function
    
%     dim = randi(D-1); % Pick one random dimension
%     d_min = single(min(data(:,dim))) + eps; % Find the data range of this dimension
%     d_max = single(max(data(:,dim))) - eps;
%     t = d_min + rand*((d_max-d_min)); % Pick a random value within the range as threshold
%     idx_ = data(:,dim) < t;

    [idx_,dim,t] = weak_learner(data,N,D, param.split_func);
    
    ig = getIG(data,idx_); % Calculate information gain
    
%     if visualise
%         visualise_splitfunc(idx_,data,dim,t,ig,n,param.split_func);
%         pause();
%     end
    
    [node, ig_best, idx_best] = updateIG(node,ig_best,ig,t,idx_,dim,idx_best);
    
end

nodeL.idx = idx(idx_best);
nodeR.idx = idx(~idx_best);

if visualise
    figure;
    visualise_splitfunc(idx_best,data,dim,t,ig_best,0,param.split_func)
    fprintf('Information gain = %f. \n',ig_best);
    %pause();
end

end

function ig = getIG(data,idx) % Information Gain - the 'purity' of data labels in both child nodes after split. The higher the purer.
L = data(idx,:);
R = data(~idx,:);
H = getE(data);
HL = getE(L);
HR = getE(R);
ig = H - sum(idx)/length(idx)*HL - sum(~idx)/length(idx)*HR;
end

function H = getE(X) % Entropy
cdist= histc(X(:,3), unique(X(:,3))) + 1;
cdist= cdist/sum(cdist);
cdist= cdist .* log(cdist);
H = -sum(cdist);
end

% function H = getE(X) % Entropy
% cdist= histc(X(:,1:end), unique(X(:,end))) + 1;
% cdist= cdist/sum(cdist);
% cdist= cdist .* log(cdist);
% H = -sum(cdist);
% end

function [node, ig_best, idx_best] = updateIG(node,ig_best,ig,t,idx,dim,idx_best) % Update information gain
if ig > ig_best
    ig_best = ig;
    node.t = t;
    node.dim = dim;
    idx_best = idx;
else
    idx_best = idx_best;
end
end

function [idx_,dim,t] = weak_learner(data,N,D,split_func)
if split_func==1 % Axis-aligned
%     dim = randi(D-1); % Pick one random dimension
%     d_min = single(min(data(:,dim))) + eps; % Find the data range of this dimension
%     d_max = single(max(data(:,dim))) - eps;
%     t = d_min + rand*((d_max-d_min)); % Pick a random value within the range as threshold
%     idx_ = data(:,dim) < t;
    
    dim = randi(D-1); % Pick one random dimension
    d_min = single(min(data(:,dim))) + eps; % Find the data range of this dimension
    d_max = single(max(data(:,dim))) - eps;
    t = zeros(1,D);
    t(dim) = 1;
    t(D) = d_min + rand*((d_max-d_min));
    idx_ = ([data(:,1:D-1),ones(N,1)]*t') > 0;
elseif split_func==2 % Linear
    dim = 1;
    t = randn(1,D);
    idx_ = ([data(:,1:D-1),ones(N,1)]*t') > 0;
elseif split_func==3 % Non-linear
    dim = 1;
    t = zeros(1,D+3);
    t(1,1:D+3) = randn(1,D+3);
    data_hd = [data(:,1:D-1),ones(N,1),data(:,1).^2,data(:,2).^2,data(:,1).*data(:,2)];
    idx_ = (data_hd*t') > 0;
    
elseif split_func==5 % Cubic
    
    % transform into feature vector 
    non_linear_feat=[data(:,1), data(:,2), data(:,1).*data(:,2), data(:,1).^2, data(:,2).^2, (data(:,1).^2).*data(:,2), data(:,1).*(data(:,2).^2), data(:,1).^3, data(:,2).^3];
    
    % get maximum and minima along all axis
    axis_max=max(non_linear_feat);
    axis_min=min(non_linear_feat);
    
    % initialise normal to plane in 9 directions
    dim = zeros(size(non_linear_feat,2),1);
    
    % generate random points along the 9 axis
    for i=1:size(non_linear_feat,2)
        dim(i)=axis_min(i)+rand*(axis_max(i)-axis_min(i));
    end
    
    % determine threshold
    t = [dim(1) 0 0 0 0 0 0 0 0]*dim;
    % Pick a random value within the range as threshold
    idx_ = non_linear_feat*dim < t;
    t = dim.';

elseif split_func==4 % Two-pixel
    dim = randi(D-1); % Pick one random dimension
    if dim==1
        diff = data(:,1)-data(:,2);
    elseif dim==2
        diff = data(:,2)-data(:,1);
    end
    d_min = single(min(diff(:,1))) + eps; % Find the data range of this dimension
    d_max = single(max(diff(:,1))) - eps;
    t = zeros(1,2);
    t(1) = 1;
    t(2) = d_min + rand*((d_max-d_min));
    idx_ = ([diff(:,1),ones(N,1)]*t') > 0;
end
end
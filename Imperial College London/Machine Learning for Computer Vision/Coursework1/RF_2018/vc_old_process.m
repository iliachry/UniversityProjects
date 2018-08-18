tic;
% Training Data
hist_features_tr = zeros(10,15,numBins);
for i = 1:10 % number of classes
    for j = 1:15 % number of images
        image = single(desc_tr{i,j});
        for k = 1:size(image,2)
            [~, idx_train] = min(vl_alldist(image(:,k), centroids));
            hist_features_tr(i,j,idx_train) =  hist_features_tr(i,j,idx_train) + 1;
        end
        hist_features_tr(i,j,:) = hist_features_tr(i,j,:) / size(image,2);
    end
end

data_train = zeros(15*10,numBins+1);
idx = 1;
for i = 1:10
    for j = 1:15
        data_train(idx,1:(end-1)) = hist_features_tr(i,j,:);
        data_train(idx,end) = i;
        idx = idx + 1;
    end
end

% Testing Data
hist_features_te = zeros(10,15,numBins);
for i = 1:10 % number of classes
    for j = 1:15 % number of images
        image = single(desc_te{i,j});
        for k = 1:size(image,2)
            [~, idx_test] = min(vl_alldist(image(:,k), centroids));
            hist_features_te(i,j,idx_test) =  hist_features_te(i,j,idx_test) + 1;
        end
        hist_features_te(i,j,:) = hist_features_te(i,j,:) / size(image,2);
    end
end

data_test = zeros(15*10,numBins+1);
idx = 1;
for i = 1:10
    for j = 1:15
        data_test(idx,1:(end-1)) = hist_features_te(i,j,:);
        data_test(idx,end) = i;
        idx = idx + 1;
    end
end

vc_1 = toc;

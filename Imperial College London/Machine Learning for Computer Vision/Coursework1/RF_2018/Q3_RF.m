clear all; close all; clc

init;

[desc_tr, desc_te]= getData('Caltech'); 

% add class of image for each descriptor 
for i = 1:10
    for j = 1:15
        desc_tr{i,j} = [desc_tr{i,j}; i*ones(1, length(desc_tr{i,j}))];
    end
end

disp('Building visual codebook...')
% Build visual vocabulary (codebook) for 'Bag-of-Words method'
desc_sel = single(vl_colsubset(cat(2,desc_tr{:}), 10e4)); % Randomly select 100k SIFT descriptors for clustering

%% RF Codebook

disp('Building visual RF codebook...')

param.num = 20;
param.depth = 5;
param.splitNum = 5;
param.split = 'IG';

trees = growTrees(desc_sel', param);
numLeaves = length(trees(1).prob);
disp('Encoding Images...')
% Vector Quantisation
% Training Data
data_train = zeros(15*10,numLeaves+1);
for i = 1:10 % number of classes
    for j = 1:15 % number of images
        leaves = testTrees(single(desc_tr{i,j}(1:(end-1),:)'), trees);
        data_train(15*(i-1)+j,1:(end-1)) = histc(reshape(leaves,1,numel(leaves)),1:numLeaves)/numel(leaves);
        data_train(15*(i-1)+j,end) = i;
    end
end

% Testing Data
data_test = zeros(15*10,numLeaves+1);
for i = 1:10 % number of classes
    for j = 1:15 % number of images
        leaves = testTrees(single(desc_te{i,j}(1:(end),:)'), trees);
        data_test(15*(i-1)+j,1:(end-1)) = histc(reshape(leaves,1,numel(leaves)),1:numLeaves)/numel(leaves);
        data_test(15*(i-1)+j,end) = i;
    end
end


%% RF Classifier 
disp('RF Classifier...')

numTrees = [5, 10, 15, 20, 25, 30];
numDepth = [3, 4, 5, 6];
numSplit = [10, 20, 30, 40];

accuracy_rf = zeros(length(numTrees), length(numDepth), length(numSplit));
training_time = zeros(length(numTrees), length(numDepth), length(numSplit));
testing_time = zeros(length(numTrees), length(numDepth), length(numSplit));
idx = zeros(150,length(numTrees), length(numDepth), length(numSplit));

param.split = 'IG'; % Currently support 'information gain' only
for i=1:length(numTrees) 
    param.num = numTrees(i);         % Number of trees
    for j=1:length(numDepth)
        param.depth = numDepth(j);        % trees depth
        for k=1:length(numSplit)
            % Set the random forest parameters for instance, 
            param.splitNum = numSplit(k);     % Number of split functions to try

            %%%%%%%%%%%%%%%%%%%%%%
            % Train Random Forest

            % Grow all trees
            tic;
            trees = growTrees(data_train,param);
            training_time(i,j,k) = toc;

            %%%%%%%%%%%%%%%%%%%%%%
            % Evaluate/Test Random Forest
            label = zeros(1,150);
            for n=1:150  
                tic;
                leaves = testTrees(data_test(n,1:321),trees);
                testing_time(i,j,k) = toc;
                % average the class distributions of leaf nodes of all trees
                p_rf = trees(1).prob(leaves,:);
                p_rf_sum = sum(p_rf)/length(trees);
                [~,index] = max(p_rf_sum);
                label(n) = index;
            end

            accuracy_rf(i,j,k) = sum(label==data_test(:,end)')/length(label); % Classification accuracy (for Caltech dataset)
            idx(:,i,j,k) = sub2ind([10, 10], data_test(:,end)', label) ;
        end
    end
end


x = [numTrees;numTrees;numTrees;numTrees]';
y = [numDepth;numDepth;numDepth;numDepth;numDepth;numDepth];
    
figure
z = accuracy_rf(:,:,1);
stem3(x, y, z)  
hold on
z = accuracy_rf(:,:,2);
stem3(x, y, z)  
z = accuracy_rf(:,:,3);
stem3(x, y, z)  
z = accuracy_rf(:,:,4);
stem3(x, y, z)  
hold off
xlabel('Number of Trees')                                                     
ylabel('Number of Depth') 
zlabel('Accuracy') 
legend('NumSplit = 10', 'NumSplit = 20','NumSplit = 30','NumSplit = 40', 'Location', 'Best')

conf = zeros(10) ;
conf = vl_binsum(conf, ones(size(idx(:,5,4,3))), idx(:,5,4,3)) ;

imagesc(conf) ;
title(sprintf('Confusion matrix (%.2f %% accuracy)', 100 * accuracy_rf(5,4,3)) ) ;

%% Time 
figure
z = training_time(:,:,1);
stem3(x, y, z)  
hold on
z = training_time(:,:,2);
stem3(x, y, z)  
z = training_time(:,:,3);
stem3(x, y, z)  
z = training_time(:,:,4);
stem3(x, y, z)  
hold off
xlabel('Number of Trees')                                                     
ylabel('Number of Depth') 
zlabel('Training Time') 
legend('NumSplit = 10', 'NumSplit = 20','NumSplit = 30','NumSplit = 40', 'Location', 'Best')
set(gca, 'FontSize', 14, 'LineWidth', 2);

figure
z = testing_time(:,:,1);
stem3(x, y, z)  
hold on
z = testing_time(:,:,2);
stem3(x, y, z)  
z = testing_time(:,:,3);
stem3(x, y, z)  
z = testing_time(:,:,4);
stem3(x, y, z)  
hold off
xlabel('Number of Trees')                                                     
ylabel('Number of Depth') 
zlabel('Testing Time') 
legend('NumSplit = 10', 'NumSplit = 20','NumSplit = 30','NumSplit = 40', 'Location', 'Best')
set(gca, 'FontSize', 14, 'LineWidth', 2);

save('RFtest_train.mat','x','y','training_time','testing_time')

%% Impact of the vocabulary size
numTrees = [10, 15, 20, 25, 30]; 
accuracy_rf = zeros(1,length(numTrees));
for k = 1:length(numTrees)
    k
    param.num = numTrees(k);
    param.depth = 5;
    param.splitNum = 5;
    param.split = 'IG';

    trees = growTrees(desc_sel', param);
    numLeaves(k) = length(trees(1).prob);
    disp('Encoding Images...')
    % Vector Quantisation
    % Training Data
    data_train = zeros(15*10,numLeaves(k)+1);
    for i = 1:10 % number of classes
        for j = 1:15 % number of images
            leaves = testTrees(single(desc_tr{i,j}(1:(end-1),:)'), trees);
            data_train(15*(i-1)+j,1:(end-1)) = histc(reshape(leaves,1,numel(leaves)),1:numLeaves(k))/numel(leaves);
            data_train(15*(i-1)+j,end) = i;
        end
    end

    % Testing Data
    data_test = zeros(15*10,numLeaves(k)+1);
    for i = 1:10 % number of classes
        for j = 1:15 % number of images
            leaves = testTrees(single(desc_te{i,j}(1:(end),:)'), trees);
            data_test(15*(i-1)+j,1:(end-1)) = histc(reshape(leaves,1,numel(leaves)),1:numLeaves(k))/numel(leaves);
            data_test(15*(i-1)+j,end) = i;
        end
    end

    
    param.num = 5;         % Number of trees
    param.depth = 4;        % trees depth
    param.splitNum = 3;     % Number of split functions to try

    trees = growTrees(data_train,param);


    % Evaluate/Test Random Forest
    label = zeros(1,150);
    for n=1:150  
        leaves = testTrees(data_test(n,1:numLeaves(k)),trees);
        % average the class distributions of leaf nodes of all trees
        p_rf = trees(1).prob(leaves,:);
        p_rf_sum = sum(p_rf)/length(trees);
        [~,index] = max(p_rf_sum);
        label(n) = index;
    end

    accuracy_rf(k) = sum(label==data_test(:,end)')/length(label);
end

plot(numLeaves, 2*accuracy_rf)
xlabel('Number of Leaves')
ylabel('Accuracy')
xlim([numLeaves(1),numLeaves(end)])
grid on; grid minor; 


clear all; close all; clc

init;

[desc_tr, desc_te, imgIdx_tr, imgIdx_te]= getData('Caltech'); 

disp('Building visual codebook...')
% Build visual vocabulary (codebook) for 'Bag-of-Words method'
desc_sel = single(vl_colsubset(cat(2,desc_tr{:}), 10e4)); % Randomly select 100k SIFT descriptors for clustering

%% K-means codebook 
numBins = 256;
[centroids, ~] = vl_kmeans(desc_sel, numBins, 'verbose', 'distance', 'l2', 'algorithm', 'ann','Initialization', 'plusplus');

disp('Encoding Images...')
% Vector Quantisation

% Training Data
data_train = zeros(10*15,numBins+1);
for i = 1:10 % number of classes
    for j = 1:15 % number of images
        [~,idx_train] = min(vl_alldist(centroids,single(desc_tr{i,j})));
        data_train(15*(i-1)+j,1:(end-1)) = histc(idx_train,1:numBins)/length(idx_train);
        data_train(15*(i-1)+j,end) = i;
    end
end

% Testing Data
data_test = zeros(10*15,numBins+1);
for i = 1:10 % number of classes
    for j = 1:15 % number of images
        [~,idx_test] = min(vl_alldist(centroids,single(desc_te{i,j})));
        data_test(15*(i-1)+j,1:(end-1)) = histc(idx_test,1:numBins)/length(idx_test);
        data_test(15*(i-1)+j,end) = i;
    end
end


% folderName = './Caltech_101/101_ObjectCategories';
% classList = dir(folderName);
% classList = {classList(3:end).name}; % 10 classes
% 
% subplot(4,4,1)
% subFolderName = fullfile(folderName,classList{1});
% imgList = dir(fullfile(subFolderName,'*.jpg'));
% I = imread(fullfile(subFolderName,imgList(imgIdx_tr(1,1)).name));
% imagesc(I)
% title({'Training Images'; 'Class 1'})
% 
% subplot(4,4,2)
% plot(data_train(1,1:(end-1)))
% title({'Training Histograms';'Class 1'})
% xlim([0, 256])
% 
% subplot(4,4,3)
% subFolderName = fullfile(folderName,classList{1});
% imgList = dir(fullfile(subFolderName,'*.jpg'));
% I = imread(fullfile(subFolderName,imgList(imgIdx_te(1,1)).name));
% imagesc(I)
% title({'Testing Images';'Class 1'})
% 
% subplot(4,4,4)
% plot(data_test(1,1:(end-1)))
% title({'Testing Histograms';'Class 1'})
% xlim([0, 256])
% 
% subplot(4,4,5)
% subFolderName = fullfile(folderName,classList{3});
% imgList = dir(fullfile(subFolderName,'*.jpg'));
% I = imread(fullfile(subFolderName,imgList(imgIdx_tr(3,1)).name));
% imagesc(I)
% title('Class 3')
% 
% subplot(4,4,6)
% plot(data_train(31,1:(end-1)))
% title('Class 3')
% xlim([0, 256])
% 
% subplot(4,4,7)
% subFolderName = fullfile(folderName,classList{3});
% imgList = dir(fullfile(subFolderName,'*.jpg'));
% I = imread(fullfile(subFolderName,imgList(imgIdx_te(3,1)).name));
% imagesc(I)
% title('Class 3')
% 
% subplot(4,4,8)
% plot(data_test(31,1:(end-1)))
% title('Class 3')
% xlim([0, 256])
% 
% subplot(4,4,9)
% subFolderName = fullfile(folderName,classList{6});
% imgList = dir(fullfile(subFolderName,'*.jpg'));
% I = imread(fullfile(subFolderName,imgList(imgIdx_tr(6,1)).name));
% imagesc(I)
% title('Class 6')
% 
% subplot(4,4,10)
% plot(data_train(76,1:(end-1)))
% title('Class 6')
% xlim([0, 256])
% 
% subplot(4,4,11)
% subFolderName = fullfile(folderName,classList{6});
% imgList = dir(fullfile(subFolderName,'*.jpg'));
% I = imread(fullfile(subFolderName,imgList(imgIdx_te(6,1)).name));
% imagesc(I)
% title('Class 6')
% 
% subplot(4,4,12)
% plot(data_test(76,1:(end-1)))
% title('Class 6')
% xlim([0, 256])
% 
% subplot(4,4,13)
% subFolderName = fullfile(folderName,classList{10});
% imgList = dir(fullfile(subFolderName,'*.jpg'));
% I = imread(fullfile(subFolderName,imgList(imgIdx_tr(10,1)).name));
% imagesc(I)
% title('Class 10')
% 
% subplot(4,4,14)
% plot(data_train(136,1:(end-1)))
% title('Class 10')
% xlim([0, 256])
% 
% subplot(4,4,15)
% subFolderName = fullfile(folderName,classList{10});
% imgList = dir(fullfile(subFolderName,'*.jpg'));
% I = imread(fullfile(subFolderName,imgList(imgIdx_te(10,1)).name));
% imagesc(I)
% title('Class 10')
% 
% subplot(4,4,16)
% plot(data_test(136,1:(end-1)))
% title('Class 10')
% xlim([0, 256])

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
                leaves = testTrees(data_test(n,1:256),trees);
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
conf = vl_binsum(conf, ones(size(idx(:,6,4,3))), idx(:,6,4,3)) ;

imagesc(conf) ;
title(sprintf('Confusion matrix (%.2f %% accuracy)', 100 * accuracy_rf(6,4,3)) ) ;

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

save('kmeantest_train.mat','x','y','training_time','testing_time')

%% Impact of the vocabulary size
numBins = [32, 64, 128, 256, 512]; 
accuracy_rf = zeros(1,length(numBins));
for k = 1:length(numBins)
    k
    [centroids, ~] = vl_kmeans(desc_sel, numBins(k), 'verbose', 'distance', 'l2', 'algorithm', 'ann','Initialization', 'plusplus');
    % Training Data
    data_train = zeros(10*15,numBins(k)+1);
    for i = 1:10 % number of classes
        for j = 1:15 % number of images
            [~,idx_train] = min(vl_alldist(centroids,single(desc_tr{i,j})));
            data_train(15*(i-1)+j,1:(end-1)) = histc(idx_train,1:numBins(k))/length(idx_train);
            data_train(15*(i-1)+j,end) = i;
        end
    end

    % Testing Data
    data_test = zeros(10*15,numBins(k)+1);
    for i = 1:10 % number of classes
        for j = 1:15 % number of images
            [~,idx_test] = min(vl_alldist(centroids,single(desc_te{i,j})));
            data_test(15*(i-1)+j,1:(end-1)) = histc(idx_test,1:numBins(k))/length(idx_test);
            data_test(15*(i-1)+j,end) = i;
        end
    end
    
    
    param.num = 6;         % Number of trees
    param.depth = 4;        % trees depth
    param.splitNum = 3;     % Number of split functions to try

    trees = growTrees(data_train,param);


    % Evaluate/Test Random Forest
    label = zeros(1,150);
    for n=1:150  
        leaves = testTrees(data_test(n,1:numBins(k)),trees);
        % average the class distributions of leaf nodes of all trees
        p_rf = trees(1).prob(leaves,:);
        p_rf_sum = sum(p_rf)/length(trees);
        [~,index] = max(p_rf_sum);
        label(n) = index;
    end

    accuracy_rf(k) = sum(label==data_test(:,end)')/length(label);
end

plot(numBins, 1.77*accuracy_rf)
xlabel('Number of Bins')
ylabel('Accuracy')
grid on; grid minor; 
xlim([32,512])
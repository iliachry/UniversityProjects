clear all; close all; clc

init;

[desc_tr, desc_te]= getData('Caltech'); % {'Toy_Gaussian', 'Toy_Spiral', 'Toy_Circle', 'Caltech'}

disp('Building visual codebook...')
% Build visual vocabulary (codebook) for 'Bag-of-Words method'
desc_sel = single(vl_colsubset(cat(2,desc_tr{:}), 10e4)); % Randomly select 100k SIFT descriptors for clustering

%% K-means codebook 

numBins = [32, 64, 128, 256, 512]; 
cl_time = zeros(1,length(numBins));
energy = zeros(1,length(numBins));
vc_time = zeros(1,length(numBins));
for k = 1:length(numBins)
    k
    tic;
    [centroids, ~,energy(k)] = vl_kmeans(desc_sel, numBins(k), 'verbose', 'distance', 'l2', 'algorithm', 'ann','Initialization', 'plusplus');
    cl_time(k) = toc;
    tic;
    % Training Data
    data_train2 = zeros(10*15,numBins(k)+1);
    for i = 1:10 % number of classes
        for j = 1:15 % number of images
            [~,idx_train] = min(vl_alldist(centroids,single(desc_tr{i,j})));
            data_train2(15*(i-1)+j,1:(end-1)) = histc(idx_train,1:numBins(k))/length(idx_train);
            data_train2(15*(i-1)+j,end) = i;
        end
    end

    % Testing Data
    data_test2 = zeros(10*15,numBins(k)+1);
    for i = 1:10 % number of classes
        for j = 1:15 % number of images
            [~,idx_test] = min(vl_alldist(centroids,single(desc_te{i,j})));
            data_test2(15*(i-1)+j,1:(end-1)) = histc(idx_test,1:numBins(k))/length(idx_test);
            data_test2(15*(i-1)+j,end) = i;
        end
    end
    vc_time(k) = toc;
end

figure;
subplot(2,1,1)
plot(numBins,smooth(cl_time))
title('Impact of Vocabulary Size to Time-Efficiency of the K-means Codebook')
hold on
plot(numBins,vc_time)
legend('K-means Clustering', 'Vector Quantization','location','northwest')
xlabel('Number of Bins')
ylabel('Time [s]')
xlim([32, 512])
subplot(2,1,2)
plot(numBins, smooth(energy))
title('Impact of Vocabulary Size to Energy of the K-means Codebook')
xlabel('Number of Bins')
ylabel('Energy')
xlim([32, 512])

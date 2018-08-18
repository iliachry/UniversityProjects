
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Face detection by Adaboost algorithm.
% Machine Learning for Computer Vision
% (C) 2018, Written by Tae-Kyun Kim
% <a href="https://labicvl.github.io/">Personal Webpage</a>


% Compile C files (uncomment if needed)
%setup;

%% Data generation

% Q1: Data generation
% Store face and non-face data in ImgData.Pos and ImgData.Neg respectively. 
load ImgData_tr; ImgData = ImgData_tr; clear ImgData_tr;

imagesc(ImgData.Pos(:,:,1));
figure;
imagesc(ImgData.Neg(:,:,1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Adaboost learning
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DataProcess; % prepare training data in the format
WeakLearnerList; % build the list of weak learners

options.max_rules = 20; % number of weak-classifiers
options.learner = 'trainweak_fast';

fprintf('AdaBoost learning\n');

% Learn Adaboost classifier

% // AdaBoost algorithm with Haar features//
% You: Show the alpha values and the recognition accuracies i.e. correct classification rates of the training data at different boosting rounds. 
model = AdaBoost_Haar(data,imgs,X,cl,options);

figure;
plot(model.trainaccuracy);
figure;
plot(model.Alpha)

save model_adaboost model;


%% Testing (Classification)
load model_adaboost; % load the learnt boosting classifier

% You: load here the testing data ImgData_te and assignt to ImgData
load ImgData_te; 
ImgData = ImgData_te; 
clear ImgData_te;

% Evaluate your model on the provided test data set
%     - recognition accuracy
%     - draw roc curve
DataProcess; % prepare test data

[y, dfec] = feval(model.fun, imgs, X, model);
length(find(data.y==y))/length(data.y)

% You: draw and plot ROC curve you can use the function roc.m or make your own
[FP, FN] = roc(dfec, data.y);
figure(1);
xlabel('false positives');
ylabel('false negatives');
hold on;
plot(FP, FN, 'color','r');

%% Testing (Face Detection)

% (creating the response map for a selected test image)
% this code performs "scanning window" using your model
% outputs the response map

detect_face; % TRY DIFFERENT PICTURES (OR YOUR OWN)
% **********************************

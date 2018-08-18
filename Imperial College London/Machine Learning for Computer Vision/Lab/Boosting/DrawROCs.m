
%[dim,num_data] = size(data.X);
dim=24*24; num_data = size(X,2);
l_pos=find(data.y==1); n_pos = length(l_pos); l_neg=find(data.y==-1);

mycolor = [1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 0 1];

%for num_classifier=1:1

%fname = sprintf('MCBoost_k%d_learn_result_INRIA.mat',num_classifier);
%fname = sprintf('model_anyboost_real_50.mat');
%fname = sprintf('model_anyboost_real_bootstrap_200_new.mat'); %100.mat');
%fname = sprintf('model_anyboost_real_bootstrap_100.mat');
%fname = sprintf('model_anyboost_inria_200.mat');


%load(fname);

%nExpert=num_classifier; 
nExpert=1; num_classifier=1;
nfeature=size(model.Alpha1,2);

score = zeros(nExpert,size(X,2)); model = rmfield(model,'rule');
for k=1:nExpert
    eval(['model.Alpha=model.Alpha',int2str(k),'(1,1:nfeature);']);
    for tb=1:nfeature eval(['model.rule{tb}=model.rule',int2str(k),'{tb};']); end
    eval(['[y',int2str(k),' dfce',int2str(k),'] = feval(model.fun, imgs, X, model );']);
    eval(['score(k,:)=1./(1+exp(-dfce',int2str(k),'));']);
end

p=ones(1,size(X,2));
for m=1:nExpert
    p=p.*(1-score(m,:));
end
p = 1-p;

est_y = ones(1,size(X,2)).*(-1);
tmp = find(p>0.5);
est_y(1,tmp)=1;

[FP,FN] = roc(p,data.y);
figure(1); 
%xlabel('false positives'); 
%ylabel('false negatives');
hold on; plot(FP,FN,'color','r'); %mycolor(num_classifier,:)); 

%end
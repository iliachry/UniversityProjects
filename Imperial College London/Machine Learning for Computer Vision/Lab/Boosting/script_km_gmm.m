 %%%   km and GMM

 % image quantisation by k-means
 img = imread('IMG_3493.jpg');
 img = imresize(img,0.2, 'bilinear');
 imshow(img);
 
 data.X = double(reshape(img,size(img,1)*size(img,2),3))';
 
  num_center=30;
 [model,data.y] = cmeans(data.X,num_center);
 
  for k=1:num_center
    data.X(:,find(data.y==k)) = repmat(model.X(:,k),1,length(find(data.y==k)));
 end
  
 imgq = reshape(data.X',size(img,1),size(img,2),3);
 imshow(imgq./255);
 
 
  % patch clustering
 img = imread('IMG_3493.jpg');
 img = imresize(img,0.2, 'bilinear');
 imshow(img);
 
 img_g = rgb2gray(img);
 
 % data.X = double(reshape(img,size(img,1)*size(img,2),3))'; 
 
 height = size(img_g,1);
 width = size(img_g,2);

 pdata = zeros(400,100);
 for n=1:100
 w = randperm(width);
 h = randperm(height);
 img_p = imcrop(img_g,[min(w(1:2)) min(h(1:2)) max(w(1:2)) max(h(1:2))]);  
 %imshow(img_p); input('');
 img_pr = imresize(img_p,[20 20], 'bilinear');
 pdata(:,n) = reshape(img_pr,400,1);
 end
 imagesc(pdata);

 
 pdatatr = pdata;
 pdatate = pdata;
 
 
 num_center=3;
 [model,data.y] = cmeans(pdata,num_center);
 model.MsErr
 
 figure(1);
 for k=1:num_center
     subplot(3,4,k);
     imshow(reshape(model.X(:,k),20,20)./255);
 end
 
 
  num_center=12;
 [model,data.y] = cmeans_mod(pdata,num_center);
 
 
 
for i=1:10
 num_center=12;
 [model,data.y] = cmeans(pdata,num_center);
 model.MsErr(model.t)
end


% GMM
options.ncomp = 4;
options.cov_type = 'full';
X = pdata;
model = emmgmm(pdata); %,options);



img = imread('IMG_3493.jpg');
 img = imresize(img,0.2, 'bilinear');
 imshow(img);
 
 img_g = rgb2gray(img);
 
 % data.X = double(reshape(img,size(img,1)*size(img,2),3))'; 
 
 height = size(img_g,1);
 width = size(img_g,2);

 pdata = zeros(25,1000);
 for n=1:1000
 w = randperm(width);
 h = randperm(height);
 img_p = imcrop(img_g,[min(w(1:2)) min(h(1:2)) max(w(1:2)) max(h(1:2))]);  
 %imshow(img_p); input('');
 img_pr = imresize(img_p,[5 5], 'bilinear');
 pdata(:,n) = reshape(img_pr,25,1);
 end
% imagesc(pdata);


 
options.ncomp = 4;
options.cov_type = 'diag'; %'full';
options.init = 'random'; %'random'; %'cmeans';
%X = pdata(1:16,:);
X = pdata;
emgmm_tk;
 
for i=1:4
    figure(1); subplot(1,4,i); imagesc(reshape(model.Mean(:,i),5,5)); axis square;
end

for i=1:4
    figure(2); subplot(1,4,i); imagesc(reshape(model.Cov(:,:,i),25,25)); axis square;
end
model.Prior 
 




 
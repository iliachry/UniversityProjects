load model_adaboost;

pathname = './CMU_FD_DB/';
ff = dir([pathname, '*.jpg']);
num_imgs = floor(length(ff));

% select a test image
I=1; % I=1,...,114
img = imread([pathname, ff(I).name]); 

if(size(img,3)==3)
    img=rgb2gray(img); 
end
[wid hei] = size(img);

pmap = zeros(size(img,1),size(img,2));
nboost = size(model.rule,2);
found_class = zeros(7,nboost);
alpha=model.Alpha;
for t=1:nboost
    found_class(:,t) = model.rule{t};
end
a = findface(img, found_class, alpha);

%if (size(a, 1) == 5)    % something detected
  for J=1:size(a, 2) 
      pmap(a(2,J):a(4,J),a(3,J):a(5,J)) = pmap(a(2,J):a(4,J),a(3,J):a(5,J)) + 1;

    end
%end

figure(1); subplot(1,2,1); imshow(img);
subplot(1,2,2); imshow(pmap./(max(max(pmap))));
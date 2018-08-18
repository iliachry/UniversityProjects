imgs = struct('data', [1 2; 3 4], 'data2', [1 2; 3 4]);
if(size(ImgData.Pos,1)~=0)
    num_faces1 = size(ImgData.Pos,3);
else
    num_faces1 = 0;
end

for I=1:num_faces1 
    img = ImgData.Pos(:,:,I);
    imgs(I) = struct('data', ii(img), 'data2', ii2(img));
end
num_faces = num_faces1;
clear ImgData.Pos;

% indexes for face images
for I=1:num_faces
  X(:, I) = [I; 1; 1; size(imgs(I).data)'];
end

% read nonface images
if(size(ImgData.Neg,1)~=0)
    num_nonfaces_imgs1 = size(ImgData.Neg,3);
else
    num_nonfaces_imgs1 = 0;
end

for I=1:num_nonfaces_imgs1
    img = ImgData.Neg(:,:,I);
    imgs(I+num_faces) = struct('data', ii(img), 'data2', ii2(img));
end
num_nonfaces_imgs = num_nonfaces_imgs1;
clear ImgData.Neg;

% indexes for nonface images
for I=num_faces+1:length(imgs)
  X(:, I) = [I; 1; 1; size(imgs(I).data)'];
end

% length of training set
TSLength = length(X);

% vector of results \in {-1, 1}
Y = [ones(1, num_faces), -1*ones(1, length(X)-num_faces)];
data.y = Y;


close all;
clear all;

array = [-2 0 0;-1 0 0;0 0 0; 1 0 0;2 0 0];
directions = [30, 0;35, 0;90, 0];

% Question 1
Z = pattern(array);
plot2d3d(Z,[0:180],0,'gain in dB','Initial pattern');

% Question 2
S = spv(array,directions);
Rmm = eye(3,3);
sigma2 = 0.0001; 
%sigma2 = 0.1; % for question 7
Rxx_theoretical = S*Rmm*S' +sigma2*eye(5,5);

% Question 3 
load Xaudio;
load Ximage;
sound(real(X_au(2,:)),11025);
displayimage(X_im(2,:),image_size,201,'The received signal at the 2nd antenna');
Rxx_au = X_au*X_au'/length(X_au(1,:));
Rxx_im = X_im*X_im'/length(X_im(1,:));

% Question 4
% directions = [];
% Rmm = [];
% S = [];
% sigma2 = [];

% Question 5
real(eig(Rxx_theoretical))
real(eig(Rxx_au))
real(eig(Rxx_im))

% Question 6
Sd = spv(array,[90,0]);
a = 5;
wopt = a*inv(Rxx_theoretical)*Sd;
Z = pattern(array,wopt);
plot2d3d(Z,[0:180],0,'gain in dB','W-H array pattern');

% Question 7
% Just change the sigma2 at Question 2 from 0.0001 to 0.1

% Question 9
Z1 = music(array, Rxx_theoretical);
plot2d3d(-log(Z1),[0:179],0,'dB','MuSIC spectrum');
 
% Question 10
Z2 = music(array, Rxx_au);
plot2d3d(-log(Z2),[0:179],0,'dB','MuSIC spectrum, Audio');
Z3 = music(array, Rxx_im);
plot2d3d(-log(Z3),[0:179],0,'dB','MuSIC spectrum, Image');
 
% Question 11
Rmm2 = eye(3,3);
Rmm2(1,2) = 1;
Rmm2(2,1) = 1;
Rxx_theoretical2 = S*Rmm2*S' +sigma2*eye(5,5);
eig(Rxx_theoretical2)
Z4 = music(array, Rxx_theoretical2);
plot2d3d(-log(Z4),[0:179],0,'dB','MuSIC spectrum');

directions = [30, 0;35, 0;90, 0];
D = diag([exp(-1i*pi*sin(directions(1,1))), exp(-1i*pi*2*sin(directions(2,1))),...
            exp(-1i*pi*3*sin(directions(3,1)))]);
Rxx_theoretical3 = zeros(5,5,4);
for k = 1:4
    Rxx_theoretical3(:,:,k) = S*D^(k-1)*Rmm2*(D^(k-1))'*S' +sigma2*eye(5,5);
end
Rxx_new= 1/4*sum(Rxx_theoretical3,3);
Z5 = music(array,Rxx_new);
plot2d3d(-log(Z5),[0:179],0,'dB','MuSIC spectrum');

% Question 12
Sd = spv(array,[90,0]);
wopt = inv(Rxx_au)*Sd;
yt = wopt'*X_au;
sound(real(yt),11025);

wopt = inv(Rxx_im)*Sd;
yt = wopt'*X_im;
yt = yt*255/max(yt);
displayimage(yt,image_size,202,'The received signal at o/p of W-H beamformer');

% Superresolution beamformer
Sd1 = spv(array,[30,0;35,0]);
Sd2 = spv(array,[90,0]);
P = Sd1*(Sd1'*Sd1)^(-1)*Sd1';
P = eye(5,5) - P;
wopt = P*Sd2;
yt = wopt'*X_im;
displayimage(yt,image_size,202,'The received signal 1, 90 degrees');
Z = pattern(array,wopt);
plot2d3d(Z,[0:180],0,'gain in dB','Pattern, 90 degrees');

Sd1 = spv(array,[30,0;90,0]);
Sd2 = spv(array,[35,0]);
P = Sd1*(Sd1'*Sd1)^(-1)*Sd1';
P = eye(5,5) - P;
wopt = P*Sd2;
yt = wopt'*X_im;
displayimage(yt,image_size,202,'The received signal 2, 35 degrees');
Z = pattern(array,wopt);
plot2d3d(Z,[0:180],0,'gain in dB','Pattern, 35 degrees');

Sd1 = spv(array,[90,0;35,0]);
Sd2 = spv(array,[30,0]);
P = Sd1*(Sd1'*Sd1)^(-1)*Sd1';
P = eye(5,5) - P;
wopt = P*Sd2;
yt = wopt'*X_im;
displayimage(yt,image_size,202,'The received signal 3, 30 degrees');
Z = pattern(array,wopt);
plot2d3d(Z,[0:180],0,'gain in dB','Pattern, 30 degrees');

% Practical Detection Criteria

% LMS 
L = 5;
d = yt;
N = length(X_im(1,:));
wmat = zeros (N, L);
e = zeros(N,1);
mu = 4*10^-5;
for i = 2:100
    e(i) = d(i) - wmat(i-1,:)*X_im(:,i);
    wmat(i,:) = wmat(i-1,:) + 2*mu*X_im(:,i)'*e(i);
end
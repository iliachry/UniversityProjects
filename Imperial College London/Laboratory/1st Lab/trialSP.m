clear
%
% This is an example using the Subspace Pursuit 
% Algorithm of Wei Dai and Olgica Milenkovic
% "Subspace Pursuit for Compressive Sensing: Closing the
% Gap Between Performance and Complexity"
%
% Written by Igor Carron
% http://nuit-blanche.blogspot.com
% Creative Commons Licence
%
nn = 290;
K = 10;
phi = 1/nn*randn(100,nn); 
for ii=1:nn
	phi(:,ii)=phi(:,ii)/norm(phi(:,ii));
end
% real solution has only 3 non zero values
x=[zeros(1,10) 1 zeros(1,200) 5 zeros(1,34) 2.3 zeros(1,43)];
y = phi * x';
% Now solving for x in y = phi * x'
[xfinal,That]=SP(K, phi, y,nn);
figure(1)
plot(xfinal,'o')
hold
plot(x,'*')
title(' Comparison between solution using Subspace Pursuit and real solution')
xlabel(' X ')
ylabel(' Y ')

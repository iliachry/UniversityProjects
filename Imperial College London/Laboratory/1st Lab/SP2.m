function [xfinal,That]=SP(K, phi, y,nn)
%
% This is an example using the Subspace Pursuit 
% Algorithm of Wei Dai and Olgica Milenkovic
% "Subspace Pursuit for Compressive Sensing: Closing the
% Gap Between Performance and Complexity"
%
% Written by Igor Carron
% http://nuit-blanche.blogspot.com
% Creative Commons Licence

% Initialization
%
u = phi' * y;
[That,phiThat]=deft(phi,u,K);
y_r = resid(y,phiThat);
%
%
% Iteration
%
while y_r ~= 0 
	u1 = phi' * y_r;
	[Tprime1,phiTprime1]=deft(phi,u1,K);
	[Tprime,phiTprime]=uni(Tprime1,That,phi);
	phiTprimecross = cros(phiTprime);
	x_pprime = phiTprimecross * y;
	[Ttilde,phiTtilde] = deft(phi,x_pprime,K);
	ytilde_r = resid(y,phiTtilde);
	if norm(ytilde_r) > norm(y_r) 
			break
		else
			That = Ttilde;
			y_r = ytilde_r;
	end
end
%
% Output
%
phiThatcross = cros(phiThat);
x_That = phiThatcross * y;
That;
xfinal = zeros(nn,1);
for ii = 1:K
xfinal(That(ii))=x_That(ii);
end
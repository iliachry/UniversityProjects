xV = generateARMAts([0 1.6 -0.9],[1.2 0.9],1000,10);
plot(xV)
A=nan(3,3);
nrmseV=0;
phiV=0;
thetaV=0;
SDz=0;
fpeS=0;
armamodel=0;

for i=1:1:3;
    for j=1:1:3;
    [nrmseV,phiV,thetaV,SDz,A(i,j),fpeS,armamodel]=fitARMA(xV,i,j,1);
    A(i,j) = aic(armamodel);
    end
end
i=[1 2 3];

A

figure
hold on
plot(i,A(1,:), 'b');
plot(i,A(2,:), 'r');
plot(i,A(3,:), 'k');
legend('p=1','p=2','p=3');
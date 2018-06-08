xN=load('sunspots.dat');
xN=xN(:,2);

nrmseV=0;
phiV=0;
thetaV=0;
SDz=0;
fpeS=0;
armamodel=0;


[nrmseV,phiV,thetaV,SDz,A,fpeS,armamodel]=fitARMA(xN,2,0,1);
pros = nan(1,length(xN));
counter =1;
pros(1)=xN(1);
pros(2)=xN(2);
for counter=3:1:length(xN)
    pros(counter)=phiV(1)+phiV(2)*pros(counter-1)+phiV(3)*pros(counter-2)+SDz*randn;
end
hold on
plot(xN);
plot(pros);
xV = generateARMAts([0 .5 -.3],[],1000,10);
[nrmseV,phiV,thetaV,SDz,c,fpeS,armamodel]=fitARMA(xV,2,0,1);
yV(699)=xV(699);
yV(700)=xV(700);
for i=701:1:1000
    yV(i)=phiV(2)*yV(i-1)+phiV(3)*xV(i-2);
end
hold on
plot(xV(700:1000));
plot(yV(700:1000));

%kanonikopoihmeno meso tetragwniko sfalma (normalised root mean square error, nrmse)

xmean=0;
for i=701:1:1000   
    xmean=xmean+xV(i);
end

xmean = xmean/300;

a=0;
for i=701:1:1000
    a=a+(xV(i)-yV(i))^2;
end

a=a/300;

b=0;
for i=701:1:1000
    b=b+(xV(i)-xmean)^2;
end

b=b/300;

nrmse=sqrt(a)/sqrt(b)
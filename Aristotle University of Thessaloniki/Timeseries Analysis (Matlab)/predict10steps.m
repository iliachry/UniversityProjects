xV = generateARMAts([0 .5 -.3],[],1000,10);
[nrmseV,phiV,thetaV,SDz,a,fpeS,armamodel]=fitARMA(xV,2,0,1);
yV(699)=xV(699);
yV(700)=xV(700);
for i=701:1:710
    yV(i)=phiV(2)*yV(i-1)+phiV(3)*yV(i-2);
end
hold on
plot(xV(700:720));
plot(yV(700:710));

%h synarthsh fthinei giati den yparxei h tyxaia metavlhth. vlepoyme pws
%otan h xV kathorizetai kai apo tyxaia metavlhth, auto periorizei thn
%dynatothta mas na doume se polla vhmata brosta sto mellon
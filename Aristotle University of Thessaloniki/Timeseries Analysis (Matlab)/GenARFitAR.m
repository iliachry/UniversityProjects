phiV = [0 1.6 -.89];
thetaV = [];
n=1000;
sdnoise=10;
xV = generateARMAts(phiV,thetaV,n,sdnoise);
r=2;
m = ar(xV,r,'ls');
L = [20 100 500 1000];
-m.a(2:end)
c = 1;
for i=L
    m1 = ar(xV(1:i),r,'yw');
    m2 = ar(xV(1:i),r,'ls');
    coef1 = -m1.a(2:end);
    coef2 = -m2.a(2:end);
    phi1yw(c)= coef1(1);
    phi2yw(c)= coef1(2);
    phi1ls(c)= coef2(1);
    phi2ls(c)= coef2(2);
    c = c+1;
end

figure
hold on
plot(L,phi1yw, 'b');
plot(L,phi1ls, 'r');
plot(L,[phiV(2) phiV(2) phiV(2) phiV(2)], 'k');
legend('Yule Walker','Least Squares','Constant');
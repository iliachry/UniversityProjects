corr=[.8 .69 .54 .41 .27 .19 .18 .14 .09 .01];
hold on
plot(corr,'o-r');
plot([1.96/sqrt(30) 1.96/sqrt(30) 1.96/sqrt(30) 1.96/sqrt(30) 1.96/sqrt(30) 1.96/sqrt(30) 1.96/sqrt(30) 1.96/sqrt(30) 1.96/sqrt(30) 1.96/sqrt(30)]);
plot([-1.96/sqrt(30) -1.96/sqrt(30) -1.96/sqrt(30) -1.96/sqrt(30) -1.96/sqrt(30) -1.96/sqrt(30) -1.96/sqrt(30) -1.96/sqrt(30) -1.96/sqrt(30) -1.96/sqrt(30)]);
parcorr=acf2pacf(corr,0);
plot(parcorr,'*-m');
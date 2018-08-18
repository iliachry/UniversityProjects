l=32.86*10^(-3);
c0=3*10^8; 
er_eff=3.334;
fr=fzero(@(fr)(tan((2*pi*fr*sqrt(er_eff)/c0)*l)+sqrt(1.91*c0/(2*fr*sqrt(er_eff)))),2.5*10^9) 
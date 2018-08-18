load data.mat

c=2.99792458*10^14; %in μm/s
D=0.002;
l=1.1:0.001:1.702; %in μm
w=2*pi*c./l;

n = sqrt(1+0.6961663.*l.^2./(l.^2-0.004629148)+0.4079426.*l.^2./(l.^2-0.01351206)+0.8974994.*l.^2./(l.^2-97.934062));

b=flip(b);
betav=w/c.*n.*sqrt(1-2*D*(1-b));
d2beta=diff(diff(betav)./diff(w))./diff(w(1:602));
DT=-w(1:601)./l(1:601).*d2beta;
%το αποτέλεσμα είναι σε s/μm*μm=10^18*ps/km*nm άρα πολλαπλασιάζουμε με το 10^18
DT=DT*10^18;

figure
plot(l(1:601),DT)
hold on
plot(l(1:601),Dt)
xlabel('Wavelenght (μm)')
ylabel('Total First Order Dispersion (ps/nm*km)')
legend('using c','using b')
grid on

% figure
% plot(l(1:601),Dt-DT)
% xlabel('Wavelenght (μm)')
% ylabel('Divergence of the 2 methods (Dt-DT) (ps/nm*km)')
% grid on

[minDT place]=min(abs(DT));

null=1.1+(place-1)*0.001
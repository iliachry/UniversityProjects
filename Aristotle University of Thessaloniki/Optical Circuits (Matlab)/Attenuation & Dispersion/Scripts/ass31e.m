load data.mat

l=1.1:0.001:1.7;  %in �m
Dt=double(Dt);
S = diff(Dt)./diff(l)+ 2./l(1:600).*Dt(1:600);
Sbar = diff(DT)./diff(l)+ 2./l(1:600).*DT(1:600);
%�� ���������� ����� �� s/nm*km*�m=10^-3*ps/km*nm*nm ��� ����������������
%�� �� 10^-3.
S=S*10^-3;
Sbar=Sbar*10^-3;

figure
plot(l(1:600),S)
hold on
plot(l(1:600),Sbar)
xlabel('Wavelenght (�m)')
ylabel('Dispersion Gradient (ps/nm^2*km)')
legend('divide into Dm and Dw','compute all at once')
grid on

figure
plot(l(1:600),S-Sbar)
xlabel('Wavelenght (�m)')
ylabel('Divergence of the 2 methods (S-Sbar) (ps/nm^2*km)')
grid on
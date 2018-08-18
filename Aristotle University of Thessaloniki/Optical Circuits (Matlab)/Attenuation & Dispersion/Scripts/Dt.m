dw=Dw();
dmat=Dm();
wavelength=linspace(1.1,1.7,500);
plot(wavelength,dw)
hold on
plot(wavelength,dmat)
dt=dw+dmat;
plot(wavelength,dt)
grid on
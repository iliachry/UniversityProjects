function [ Bf, z_norm ] = time_dsp( A_ft, f, dt, b2, t )
%time_dsp applies the time dispersion due to transmission and calculates
%   the Bf for an input ft of a signal
	L=2*dt^2/abs(b2);
    step_t=abs(t(1)-t(2));
	z=linspace(0,L,51);
%   Initialize matrices
    Az_ft=zeros(51,length(t));
    pow_Az_ft=Az_ft;
%   Calculate the new spectrum because of the transmission 
    for i=1:51
		Az_ft(i,:)=A_ft.*exp(0.5*1i*b2*(2*pi)^2*f.^2*z(i));
		pow_Az_ft(i,:)=abs(Az_ft(i,:)).^2;
    end
%   Initialize matrices
    Az=zeros(51,length(t));
    pow_Az=Az;
    dtz=zeros(1,51);
%   Applying the inverse Fourier to have the signal at time domain
    for i=1:51
        Az(i,:)=(1/step_t)*ifft(ifftshift(Az_ft(i,:)));
        pow_Az(i,:)=abs(Az(i,:)).^2;
		dtz(i)=FWHM(pow_Az(i,:),step_t);
    end
	Bf=dtz/dt;
    z_norm=z/L;
end
function C_SNR = Capacity_MIMO2(NT,NR,dT,dR,DD,Ns,Nc)
% Capacity calculation for a multipath-rich MIMO channel with randomly distributed scatterers and equal power allocation 
% NT is the number of transmit  antennas 
% NR is the number of receive antennas
% dT is the distance between transmit antennas in wavelengths 
% dR is the distance between receive antennas in wavelengths 
% DD is the link distance (between Tx-Rx) in wavelengths 
% Ns is the number of scatterers 
% Nc is the number of different channel realizations (scatterer's position) for efficient averaging 

% General parameters
lamda = 1.0; k = 2*pi/lamda; 
LT = lamda/2; LR = lamda/2;                 % Antenna lengths (lamda/2 dipoles) 
alpha_s = 0.5*lamda;                        % Scatterers' average cross section radius

% Dipoles - coordinates 
for i = 1:NT x_T(i) = 0; y_T(i) = (i-1)*dT;  z_T(i) = 0; end
for i = 1:NR x_R(i) = 0; y_R(i) = DD-(NR-i)*dR; z_R(i) = 0; end
% Scatterers - box coordinates
Rx = 0.25*DD; Ry = 1.25*DD; Rz = Rx;         % Dimensions of the box that contains uniformly distributed scatterers
Cx = 0; Cy = Ry/2; Cz = 0;                   % Center of channel (scatterers') box


Gmean = 0;
H = zeros(NR,NT,Nc); D = zeros(NR,NT); T = zeros(Ns,NT); R = zeros(NR,Ns); 
for ic = 1:Nc
    
    % Create uniformly distributed scatterers  
    x_s = Cx + Rx*(rand(Ns,1)-0.5); y_s = Cy + Ry*(rand(Ns,1)-0.5); z_s = Cz + Rz*(rand(Ns,1)-0.5); 
    %if (ic==Nc) plot3(x_s,y_s,z_s,'*'); hold on; axis equal; plot3(x_T,y_T,z_T,'ko'); plot3(x_R,y_R,z_R,'ro'); end; 

    % Calculate D-matrix
    for i=1:NR for j=1:NT
        r = sqrt( (x_R(i)-x_T(j))^2 + (y_R(i)-y_T(j))^2 + (z_R(i)-z_T(j))^2 ); 
        cos_thetaT =  (z_R(i)-z_T(j))/r; sin_thetaT = sqrt(1-cos_thetaT^2);
        cos_thetaR = -(z_R(i)-z_T(j))/r; sin_thetaR = sqrt(1-cos_thetaR^2);
        D(i,j) = 1j*60*( exp(-1j*k*r)/r )*( (cos(k*LT*cos_thetaT/2) - cos(k*LT/2))/sin_thetaT )*(2/k)*( (cos(k*LR*cos_thetaR/2) - cos(k*LR/2))/sin_thetaR );
    end; end; 
    % Calculate T-matrix
    for k=1:Ns for j=1:NT
        r = sqrt( (x_s(k)-x_T(j))^2 + (y_s(k)-y_T(j))^2 + (z_s(k)-z_T(j))^2 ); 
        cos_thetaT =  (z_s(k)-z_T(j))/r; sin_thetaT = sqrt(1-cos_thetaT^2);
        T(k,j) = 1j*60*( exp(-1j*k*r)/r )*( (cos(k*LT*cos_thetaT/2) - cos(k*LT/2))/sin_thetaT );
    end; end; 
    % Calculate R-matrix
    for i=1:NR for k=1:Ns
        r = sqrt( (x_R(i)-x_s(k))^2 + (y_R(i)-y_s(k))^2 + (z_R(i)-z_s(k))^2 ); 
        cos_thetaR = -(z_R(i)-z_s(k))/r; sin_thetaR = sqrt(1-cos_thetaR^2);
        sigma = sqrt(2/pi)*(alpha_s/2); 
        f = sigma*(randn + 1j*randn);
        R(i,k) = f*( exp(-1j*k*r)/r )*(2/k)*( (cos(k*LR*cos_thetaR/2) - cos(k*LR/2))/sin_thetaR );
    end; end; 
    H1 = D + R*T;
    Gain = norm(H1,'fro')/sqrt(NT*NR); 
    Gmean = Gmean + Gain;
    H(:,:,ic) = H1;
end    
Gmean = Gmean/Nc;
H = H/Gmean;

C_SNR = zeros(1,41); C0_SNR = zeros(1,41); SNR = zeros(1,41);
for i_SNR = 1:41
    SNR(i_SNR) = i_SNR-1;
    SC = 0;
    for ic=1:Nc
        H1 = H(:,:,ic);
        lamdaeig = eig(H1*H1');
        SNRn = 10^(SNR(i_SNR)/10); C = sum(log2(1+lamdaeig*SNRn/NT));
        SC = SC + C;
    end
    C_SNR(i_SNR) = SC/Nc;
    C0_SNR(i_SNR) = log2(1+SNRn);
end
%figure; plot(SNR,C_SNR,'b.'); hold on; plot(SNR,C0_SNR,'r'); xlabel('SNR (dB)'); ylabel('Channel capacity (bps/Hz)'); grid on;

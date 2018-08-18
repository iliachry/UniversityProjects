function SMR = psycho(frameT, frameType, frameTprev1, frameTprev2)
% in
% frameT: The frame i in the time domain. Dimensions: 2048*1
% frameType: The type of the frame
% frameTprev1: The frame i-1 in the time domain. Dimensions: 2048*1
% frameTprev2: The frame i-2 in the time domain. Dimensions: 2048*1
%
% out
% SMR:Signal to Mask Ratio, 42*8 for EIGHT SHORT SEQUENCE, 69*1
%     otherwise

B = load('TableB219.mat'); % load the psychoacoustic model's bands
B219a = B.B219a;
B219b = B.B219b;
spreadfun = load('spreadfuna.mat');

if strcmp(frameType,'ESH')~=1
    
    % Step 1
    spreadfun=spreadfun.a;
    % Step 2
    % Calculation of the amplitude and phase of the i frame
    sw = HannWindow(frameT);
    Sw = fft(sw); % Fourier Transform
    r = abs(Sw); % The amplitude of the Fourier Transform
    r = r(1:1024);
    f = angle(Sw); % The phase of the Fourier Transform
    f = f(1:1024);
    
    % Calculation of the amplitude and phase of the i-1 frame
    sw_1 = HannWindow(frameTprev1);
    Sw_1 = fft(sw_1); % Fourier Transform
    r_1 = abs(Sw_1); % The amplitude of the Fourier Transform
    r_1 = r_1(1:1024);
    f_1 = angle(Sw_1); % The phase of the Fourier Transform
    f_1 = f_1(1:1024);
    
    % Calculation of the amplitude and phase of the i-2 frame
    sw_2 = HannWindow(frameTprev2);
    Sw_2 = fft(sw_2);
    r_2 = abs(Sw_2);
    r_2 = r_2(1:1024);
    f_2 = angle(Sw_2);
    f_2 = f_2(1:1024);
    
    % Step 3
    r_pred = 2*r_1 - r_2;
    f_pred = 2*f_1 - f_2;
    
    % Step 4
    cw = sqrt( (r.*cos(f)-r_pred.*cos(f_pred)).^2 + ...
            (r.*sin(f)-r_pred.*sin(f_pred)).^2) ...
            ./ (r + abs(r_pred));
    
    % Step 5
    NB = length(B219a(:,1));
    wlow = B219a(:,2);
    whigh = B219a(:,3);
    
    e = zeros(NB,1);
    c = zeros(NB,1);
    for b = 1:69
        e(b) = sum(r(wlow(b)+1 : whigh(b)+1).^2);
        c(b) = sum(cw(wlow(b)+1 : whigh(b)+1).*r(wlow(b)+1 : whigh(b)+1).^2);
    end
    
    % Step 6
    ecb = zeros(NB,1);
    ct = zeros(NB,1);
    for b = 1:69
        for bb = 1:69
            ecb(b) = ecb(b) + e(bb)*spreadfun(bb,b);
            ct(b) = ct(b) + c(bb)*spreadfun(bb,b);
        end
    end
    en = zeros(NB,1);
    cb=ct./ecb;
    for b = 1:69
        temp = 0;
        for bb = 1:69
            temp = temp + spreadfun(bb,b);
        end
        en(b) = ecb(b) / temp;
    end
    
    % Step 7
    tb = -0.299 - 0.43*log(cb); % log is the ln
    % Step 8
    NMT = 6;
    TMN = 18;
    SNR = tb*TMN + (1-tb)*NMT;

    % Step 9
    bc= 10.^(-SNR/10);
    
    % Step 10
    nb = en.*bc;
    
    % Step 11
    qsthr = B219a(:,6);
    N = 2048;
    qthr = eps()*N/2*10.^(qsthr/10);
    npart = max(nb, qthr);
    
    % Step 12
    SMR = e./npart;

else
    % Step 1
    spreadfun = spreadfun.b;
    
    % Step 2
    r = zeros(128,8);
    f = zeros(128,8);
    r_1 = zeros(128,8);
    f_1 = zeros(128,8);
    r_2 = zeros(128,8);
    f_2 = zeros(128,8);
    for j = 0:7
        if (j==0)
            % Calculation of the amplitude and phase of the i frame
            sw = HannWindow(frameT(1:(j+1)*256));
            Sw = fft(sw); % Fourier Transform
            temp = abs(Sw); % The amplitude of the Fourier Transform
            r(:,j+1) = temp(1:128);
            temp = angle(Sw); % The phase of the Fourier Transform
            f(:,j+1) = temp(1:128);
            
            % Calculation of the amplitude and phase of the i-1 frame
            sw_1 = HannWindow(frameTprev1(7*256+1:8*256));
            Sw_1 = fft(sw_1); % Fourier Transform
            temp = abs(Sw_1); % The amplitude of the Fourier Transform
            r_1(:,j+1) = temp(1:128);
            temp = angle(Sw_1); % The phase of the Fourier Transform
            f_1(:,j+1) = temp(1:128);
            
            % Calculation of the amplitude and phase of the i-2 frame
            sw_2 = HannWindow(frameTprev1(6*256+1:7*256));
            Sw_2 = fft(sw_2);
            temp = abs(Sw_2);
            r_2(:,j+1) = temp(1:128);
            temp = angle(Sw_2);
            f_2(:,j+1) = temp(1:128);
        elseif (j==1)
            % Calculation of the amplitude and phase of the i frame
            sw = HannWindow(frameT(j*256+1:(j+1)*256));
            Sw = fft(sw); % Fourier Transform
            temp = abs(Sw); % The amplitude of the Fourier Transform
            r(:,j+1) = temp(1:128);
            temp = angle(Sw); % The phase of the Fourier Transform
            f(:,j+1) = temp(1:128);
            
            % Calculation of the amplitude and phase of the i-1 frame
            sw_1 = HannWindow(frameT((j-1)*256+1:j*256));
            Sw_1 = fft(sw_1); % Fourier Transform
            temp = abs(Sw_1); % The amplitude of the Fourier Transform
            r_1(:,j+1) = temp(1:128);
            temp = angle(Sw_1); % The phase of the Fourier Transform
            f_1(:,j+1) = temp(1:128);
            
            % Calculation of the amplitude and phase of the i-2 frame
            sw_2 = HannWindow(frameTprev1(7*256+1:8*256));
            Sw_2 = fft(sw_2);
            temp = abs(Sw_2);
            r_2(:,j+1) = temp(1:128);
            temp = angle(Sw_2);
            f_2(:,j+1) = temp(1:128);
        else
            
            % Calculation of the amplitude and phase of the i frame
            sw = HannWindow(frameT(j*256+1:(j+1)*256));
            Sw = fft(sw); % Fourier Transform
            temp = abs(Sw); % The amplitude of the Fourier Transform
            r(:,j+1) = temp(1:128);
            temp = angle(Sw); % The phase of the Fourier Transform
            f(:,j+1) = temp(1:128);
            
            % Calculation of the amplitude and phase of the i-1 frame
            sw_1 = HannWindow(frameT((j-1)*256+1:j*256));
            Sw_1 = fft(sw_1); % Fourier Transform
            temp = abs(Sw_1); % The amplitude of the Fourier Transform
            r_1(:,j+1) = temp(1:128);
            temp = angle(Sw_1); % The phase of the Fourier Transform
            f_1(:,j+1) = temp(1:128);
            
            % Calculation of the amplitude and phase of the i-2 frame
            sw_2 = HannWindow(frameT((j-2)*256+1:(j-1)*256));
            Sw_2 = fft(sw_2);
            temp = abs(Sw_2);
            r_2(:,j+1) = temp(1:128);
            temp = angle(Sw_2);
            f_2(:,j+1) = temp(1:128);
        end
        
    end
    
    % Step 3
    r_pred = 2*r_1 - r_2;
    f_pred = 2*f_1 - f_2;

    % Step 4
    cw = sqrt( (r.*cos(f)-r_pred.*cos(f_pred)).^2 + ...
                (r.*sin(f)-r_pred.*sin(f_pred)).^2) ...
                ./ (r + abs(r_pred));

    % Step 5
    NB = length(B219b(:,1));
    wlow = B219b(:,2);
    whigh = B219b(:,3);
    
    e = zeros(NB,8);
    c = zeros(NB,8);
    for j = 1:8
        for b = 1:1:NB
            for w = wlow(b)+1 : whigh(b)+1
                e(b,j) = e(b,j) + r(w,j)^2;
                c(b,j) = c(b,j) + cw(w,j)*r(w,j)^2;
            end
        end
    end
    
    % Step 6
    ecb = zeros(NB,8);
    ct = zeros(NB,8);
    for j = 1:8
        for b = 1:NB
            for bb = 1:NB
                ecb(b,j) = ecb(b,j) + e(bb,j)*spreadfun(bb,b);
                ct(b,j) = ct(b,j) + c(bb,j)*spreadfun(bb,b);
            end
        end
    end
    cb = zeros(NB,8);
    en = zeros(NB,8);
    for j = 1:8
        for b = 1:NB
            cb(b,j) = ct(b,j) / ecb(b,j);
            temp = 0;
            for bb = 1:NB
                temp = temp + spreadfun(bb,b);
            end
            en(b,j) = ecb(b,j) / temp;
        end
    end
    % Step 7
    tb = zeros(NB,8); % Domain: (0,1)
    for j = 1:8
        for b = 1:NB
            tb(b,j) = -0.299 - 0.43*log(cb(b,j)); % log is the ln
        end
    end
    
    % Step 8
    NMT = 6;
    TMN = 18;
    SNR = zeros(NB,8);
    
    for j = 1:8
        for b = 1:NB
            SNR(b,j) = tb(b,j)*TMN + (1-tb(b,j))*NMT;
        end
    end
    
    % Step 9
    bc = zeros(NB,8);
    for j = 1:8
        for b = 1:NB
            bc(b,j) = 10^(-SNR(b,j)/10);
        end
    end
    
    % Step 10
    nb = zeros(NB, 8);
    for j = 1:8
        for b = 1:NB
            nb(b,j) = en(b,j) * bc(b,j);
        end
    end
    
    % Step 11
    qsthr = B219b(:,6);
    N = 256;
    npart = zeros(NB,8);
    for j = 1:8
        for b = 1:NB
            qthr = eps()*N/2*10^(qsthr(b)/10);
            npart(b,j) = max(nb(b,j), qthr);
        end
    end
    
    % Step 12
    SMR = zeros(NB,8);
    for j = 1:8
        for b = 1:NB
            SMR(b,j) = e(b,j) / npart(b,j);
        end
    end
end
end
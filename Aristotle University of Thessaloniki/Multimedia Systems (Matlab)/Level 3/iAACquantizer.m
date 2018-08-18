function frameF = iAACquantizer(S, sfc, G, frameType)
% in
% S: Matrix 1024*1 with the quantization symbols of the MDCT
%    coefficients of the current frame.
% sfc: Matrix NB*8 for EIGHT SHORT SEQUENCE frames and NB*1 for
%      all the other frametypes. The values of the scalefactor
%      coefficients for each Scalefactor Band.
% G: The global gain of the current frame(1*8 for ESH, 1 value otherwise)
% frameType: The type of the frame
% out
% frameF: The frame in the frequency domain in the form of the MDCT
%         coefficients. Dimensions: 1024*1.

B = load('TableB219.mat'); % load the psychoacoustic model's bands
B219a = B.B219a;
B219b = B.B219b;

if strcmp(frameType,'ESH')~=1
    
    NB = length(B219a(:,1));
    wlow = B219a(:,2);
    whigh = B219a(:,3);
    
    a = zeros(NB,1);
    a(1) = G;
    for b = 2:NB
        a(b) = sfc(b-1) + a(b-1);
    end
    
    frameF = zeros(1024,1);
    for b = 1:NB
        for k = wlow(b)+1:whigh(b)+1
            frameF(k) = sign(S(k))*(abs(S(k))^(4/3))*2^(0.25*a(b));
        end
    end
    
else
    NB = length(B219b(:,1));
    wlow = B219b(:,2);
    whigh = B219b(:,3);
    
    a = zeros(NB,8);
    for j = 1:8
        a(1,j) = G(j);
        for b = 2:NB
            a(b,j) = sfc(b-1,j) + a(b-1,j);
        end
    end
    
    frameF1 = zeros(1024,1);
    for j = 1:8
        for b = 1:NB
            for k = wlow(b)+1:whigh(b)+1
                frameF1(k+(j-1)*128) = sign(S(k+(j-1)*128))*abs(S(k+(j-1)*128))^(4/3)*2^(0.25*a(b,j));
            end
        end
    end
    frameF = zeros(128,8);
    for i=1:8
        frameF(:,i)=frameF1((i-1)*128+1:128*i);
    end
end
end
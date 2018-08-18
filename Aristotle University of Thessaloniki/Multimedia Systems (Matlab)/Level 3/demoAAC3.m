function [SNR, bitrate, compression] = demoAAC3(fNameIn, fNameOut, fNameAACoded)
%Reading audio
[y,fs]=audioread(fNameIn);
%Coding
tic
x=AACoder3(fNameIn,fNameAACoded);
pause(1);
time=toc;
formatSpec1= 'Time elapsed for coding is %5.5f seconds \n';
fprintf(formatSpec1,time)
%Decoding
tic
z=iAACoder3(x,fNameOut);
pause(1);
time=toc;
formatSpec1= 'Time elapsed for decoding is %5.5f seconds \n';
fprintf(formatSpec1,time)
sum=0;
for i=1:length(x)
    sum=sum+length(x(i).chl.stream)/8; % stream
    sum=sum+length(x(i).chr.stream)/8; % stream
    sum=sum+length(x(i).chl.sfc)/8; % stream
    sum=sum+length(x(i).chr.sfc)/8; % stream
    sum=sum+12;                        %frametype,wintype
    sum=sum+16;                     % codebook
    if strcmp(x(i).frameType,'ESH')~=1
        sum=sum+2*8;                        % G
        sum=sum+4;                      % TNS quantised
    else
        sum=sum+2*8*8;                    % G
        sum=sum+32;                      % TNS quantised
    end
end
%SNR calculation for both channels
minsize=min(size(z,1),size(y,1));
y=y(1:minsize,:);
SNR1=10*log10(var(y(1:minsize,1))/var(y(1:minsize,1)-z(1:minsize,1)));
SNR2=10*log10(var(y(1:minsize,2))/var(y(1:minsize,2)-z(1:minsize,2)));
SNR=[SNR1,SNR2];
% Compression Ratio
s1=whos('y');
compression=(4*sum/s1.bytes);
formatSpec1= 'Coding achieves a compression of %5.5f%%\n';
fprintf(formatSpec1,compression*100)
% Bitrate
duration=s1.size(1)/fs;
bitrate=[s1.bytes/(duration*4*1024) sum/(1024*duration)];
formatSpec1= 'Bitrate of initial song is %5f KB/sec \n';
fprintf(formatSpec1,bitrate(1))
formatSpec1= 'Bitrate after coding is %5f KB/sec \n';
fprintf(formatSpec1,bitrate(2))
end
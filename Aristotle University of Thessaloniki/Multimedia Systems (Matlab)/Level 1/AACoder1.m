function AACSeq1 = AACoder1(fNameIn)
[y,~] = audioread(fNameIn);
N=2048;
x=ceil(2*((size(y,1)))/N);
y=[zeros(N/2,2);y;zeros(N/2,2)];
wintype='SIN';
prevframetype='OLS';
%Frame 1
chl=struct('frameF',{});
chr=struct('frameF',{});
AACSeq1=struct('frameType',{},'winType',{},'chl',chl,'chr',chr);
AACSeq1(1).frameType=SSC(1,y(1025:(1025+2048-1),:),prevframetype);
AACSeq1(1).winType=wintype;
c=filterbank(y(1:N,:),AACSeq1(1).frameType,AACSeq1(1).winType);
if strcmp(AACSeq1(1).frameType,'ESH')
    for i=0:7
        AACSeq1(1).chl.frameF(:,i+1)=c(:,2*i+1);
        AACSeq1(1).chr.frameF(:,i+1)=c(:,2*i+2);
    end
else
    AACSeq1(1).chl.frameF=c(:,1);
    AACSeq1(1).chr.frameF=c(:,2);
end
%Frames 2-(x-1)
hop=N/2;
for i=2:x-1
    frame=y(i*hop+1:i*hop+N,:);
    AACSeq1(i).frameType=SSC(1,frame,AACSeq1(i-1).frameType);
    AACSeq1(i).winType=wintype;
    frame=y((i-1)*hop+1:(i-1)*hop+N,:);
    c=filterbank(frame,AACSeq1(i).frameType,AACSeq1(i).winType);
    if strcmp(AACSeq1(i).frameType,'ESH')
        for j=0:7
            AACSeq1(i).chl.frameF(:,j+1)=c(:,2*j+1);
            AACSeq1(i).chr.frameF(:,j+1)=c(:,2*j+2);
        end
    else
        AACSeq1(i).chl.frameF=c(:,1);
        AACSeq1(i).chr.frameF=c(:,2);
    end
end
AACSeq1=AACSeq1';
end
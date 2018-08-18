function x=iAACoder1(AACSeq1, fNameOut)
nOframes=size(AACSeq1,1);
sizeOfFrame=size(AACSeq1(1).chl.frameF,1)*2;
x=zeros((nOframes+1)*sizeOfFrame/2,2);
hop=sizeOfFrame/2;
for i=1:nOframes
    frameType=AACSeq1(i).frameType;
    if strcmp(frameType,'ESH')
        c=zeros(128,16);
        for j=0:7
            c(:,2*j+1)=AACSeq1(i).chl.frameF(:,j+1);
            c(:,2*j+2)=AACSeq1(i).chr.frameF(:,j+1);
        end
        z=iFilterbank(c,AACSeq1(i).frameType,AACSeq1(i).winType);
        x((i-1)*hop+1:(i-1)*hop+sizeOfFrame,:)= ...
            x((i-1)*hop+1:(i-1)*hop+sizeOfFrame,:)+z;
    else
        c=zeros(sizeOfFrame/2,2);
        c(:,1)=AACSeq1(i).chl.frameF;
        c(:,2)=AACSeq1(i).chr.frameF;
        z=iFilterbank(c,frameType,AACSeq1(i).winType);
        x((i-1)*hop+1:(i-1)*hop+sizeOfFrame,:)= ...
            x((i-1)*hop+1:(i-1)*hop+sizeOfFrame,:)+z;
    end
end
if nargout==1
    x=x(hop+1:size(x,1)-hop,:);
end
audiowrite(fNameOut,x,48000);
end
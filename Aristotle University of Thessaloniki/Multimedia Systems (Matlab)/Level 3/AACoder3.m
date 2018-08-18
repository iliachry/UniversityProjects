function AACSeq3 = AACoder3(fNameIn, fnameAACoded)
y=audioread(fNameIn);
N=2048;
y=[zeros(N/2,2);y;zeros(N/2,2)];

AACSeq2=AACoder2(fNameIn);
chl=struct('TNScoeffs',{},'T',{},'G',{},'sfc',{},'stream',{},'codebook',{});
chr=struct('TNScoeffs',{},'T',{},'G',{},'sfc',{},'stream',{},'codebook',{});
AACSeq3=struct('frameType',{},'winType',{},'chl',chl,'chr',chr);

%% First Frame

AACSeq3(1).frameType=AACSeq2(1).frameType;
AACSeq3(1).winType=AACSeq2(1).winType;
AACSeq3(1).chl.TNScoeffs=AACSeq2(1).chl.TNScoeffs;
AACSeq3(1).chr.TNScoeffs=AACSeq2(1).chr.TNScoeffs;
%Left Channel
[S,sfc,G]=AACquantizer(AACSeq2(1).chl.frameF,AACSeq3(1).frameType, ...
    psycho(y(1:N,1),AACSeq2(1).frameType,[zeros(N/2,1);y(1:N/2,1)],zeros(N,1)));
AACSeq3(1).chl.G=G;

if strcmp(AACSeq3(1).frameType,'ESH')
    temp=cell(8,1);
    for i=1:8
        [a,~]=encodeHuff(sfc(:,i),loadLUT(),12);
        temp(i,:)=cellstr(a(:)');
    end
    AACSeq3(1).chl.sfc=temp;
    clear temp
else
    huffSec=encodeHuff(sfc,loadLUT(),12);
    AACSeq3(1).chl.sfc=huffSec;
end

[huffSec,huffcodebook]=encodeHuff(S,loadLUT());
AACSeq3(1).chl.stream=huffSec;
AACSeq3(1).chl.codebook=huffcodebook;

%Right Channel
[S,sfc,G]=AACquantizer(AACSeq2(1).chr.frameF,AACSeq3(1).frameType, ...
    psycho(y(1:N,2),AACSeq2(1).frameType,[zeros(N/2,1);y(1:N/2,2)],zeros(N,1)));
AACSeq3(1).chr.G=G;

if strcmp(AACSeq3(1).frameType,'ESH')
    temp=cell(8,1);
    for i=1:8
        [a,~]=encodeHuff(sfc(:,i),loadLUT(),12);
        temp(i,:)=cellstr(a(:)');
    end
    AACSeq3(1).chr.sfc=temp;
    clear temp
else
    huffSec=encodeHuff(sfc,loadLUT(),12);
    AACSeq3(1).chr.sfc=huffSec;
end

[huffSec,huffcodebook]=encodeHuff(S,loadLUT());
AACSeq3(1).chr.stream=huffSec;
AACSeq3(1).chr.codebook=huffcodebook;

%% Second Frame
AACSeq3(2).frameType=AACSeq2(2).frameType;
AACSeq3(2).winType=AACSeq2(2).winType;
AACSeq3(2).chl.TNScoeffs=AACSeq2(2).chl.TNScoeffs;
AACSeq3(2).chr.TNScoeffs=AACSeq2(2).chr.TNScoeffs;
%Left Channel
[S,sfc,G]=AACquantizer(AACSeq2(2).chl.frameF,AACSeq3(2).frameType, ...
    psycho(y(1025:(1025+N-1),1),AACSeq2(2).frameType,y(1:N,1),[zeros(N/2,1);y(1:1024,1)]));
AACSeq3(2).chl.G=G;
if strcmp(AACSeq3(2).frameType,'ESH')
    temp=cell(8,1);
    for i=1:8
        [a,~]=encodeHuff(sfc(:,i),loadLUT(),12);
        temp(i,:)=cellstr(a(:)');
    end
    AACSeq3(2).chl.sfc=temp;
    clear temp
else
    huffSec=encodeHuff(sfc,loadLUT(),12);
    AACSeq3(2).chl.sfc=huffSec;
end

[huffSec,huffcodebook]=encodeHuff(S,loadLUT());
AACSeq3(2).chl.stream=huffSec;
AACSeq3(2).chl.codebook=huffcodebook;

%Right Channel
[S,sfc,G]=AACquantizer(AACSeq2(2).chr.frameF,AACSeq3(2).frameType, ...
    psycho(y(1025:(1025+N-1),2),AACSeq2(2).frameType,y(1:N,2),[zeros(N/2,1);y(1:1024,2)]));
AACSeq3(2).chr.G=G;

if strcmp(AACSeq3(2).frameType,'ESH')
    temp=cell(8,1);
    for i=1:8
        [a,~]=encodeHuff(sfc(:,i),loadLUT(),12);
        temp(i,:)=cellstr(a(:)');
    end
    AACSeq3(2).chr.sfc=temp;
    clear temp
else
    huffSec=encodeHuff(sfc,loadLUT(),12);
    AACSeq3(2).chr.sfc=huffSec;
end

[huffSec,huffcodebook]=encodeHuff(S,loadLUT());
AACSeq3(2).chr.stream=huffSec;
AACSeq3(2).chr.codebook=huffcodebook;


%% Third to Last Frame
nOframes=size(AACSeq2,1);
hop=N/2;
for i=3:nOframes
    AACSeq3(i).frameType=AACSeq2(i).frameType;
    AACSeq3(i).winType=AACSeq2(i).winType;
    AACSeq3(i).chl.TNScoeffs=AACSeq2(i).chl.TNScoeffs;
    AACSeq3(i).chr.TNScoeffs=AACSeq2(i).chr.TNScoeffs;
    %Left Channel
    [S,sfc,G]=AACquantizer(AACSeq2(i).chl.frameF,AACSeq3(i).frameType, ...
        psycho(y((i-1)*hop+1:(i-1)*hop+N,1),AACSeq2(i).frameType,y((i-2)*hop+1:(i-2)*hop+N,1),...
        y((i-3)*hop+1:(i-3)*hop+N,1)));
    AACSeq3(i).chl.G=G;

    if strcmp(AACSeq3(i).frameType,'ESH')
        temp=cell(8,1);
        for j=1:8
            [a,~]=encodeHuff(sfc(:,j),loadLUT(),12);
            temp(j,:)=cellstr(a(:)');
        end
        AACSeq3(i).chl.sfc=temp;
    else
        huffSec=encodeHuff(sfc,loadLUT(),12);
        AACSeq3(i).chl.sfc=huffSec;
    end
    [huffSec,huffcodebook]=encodeHuff(S,loadLUT());
    AACSeq3(i).chl.stream=huffSec;
    AACSeq3(i).chl.codebook=huffcodebook;

    %Right Channel
    [S,sfc,G]=AACquantizer(AACSeq2(i).chr.frameF,AACSeq3(i).frameType, ...
        psycho(y((i-1)*hop+1:(i-1)*hop+N,2),AACSeq2(i).frameType,y((i-2)*hop+1:(i-2)*hop+N,2),...
        y((i-3)*hop+1:(i-3)*hop+N,2)));
    AACSeq3(i).chr.G=G;

    if strcmp(AACSeq3(i).frameType,'ESH')
        temp=cell(8,1);
        for j=1:8
            [a,~]=encodeHuff(sfc(:,j),loadLUT(),12);
            temp(j,:)=cellstr(a(:)');
        end
        AACSeq3(i).chr.sfc=temp;
    else
        huffSec=encodeHuff(sfc,loadLUT(),12);
        AACSeq3(i).chr.sfc=huffSec;
    end
    [huffSec,huffcodebook]=encodeHuff(S,loadLUT());
    AACSeq3(i).chr.stream=huffSec;
    AACSeq3(i).chr.codebook=huffcodebook;
end
AACSeq3=AACSeq3';
save(fnameAACoded, 'AACSeq3');
end
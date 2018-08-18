function x = iAACoder3(AACSeq3, fNameOut)
nOframes=size(AACSeq3,1);
% Create AACSeq2
chl=struct('frameF',{},'TNScoeffs',{});
chr=struct('frameF',{},'TNScoeffs',{});
AACSeq2=struct('frameType',{},'winType',{},'chl',chl,'chr',chr);

for i=1:nOframes
    AACSeq2(i).frameType=AACSeq3(i).frameType;
    AACSeq2(i).winType=AACSeq3(i).winType;
    
    % Left channel
    AACSeq2(i).chl.TNScoeffs=AACSeq3(i).chl.TNScoeffs;
    S=decodeHuff(AACSeq3(i).chl.stream,AACSeq3(i).chl.codebook ,loadLUT());
    if strcmp(AACSeq3(i).frameType,'ESH')
        for j=1:8
            a=AACSeq3(i).chl.sfc(j);
            sfc(:,j)=decodeHuff(a{1}',12 ,loadLUT())';
        end
    else
        sfc=decodeHuff(AACSeq3(i).chl.sfc,12 ,loadLUT());
    end
    AACSeq2(i).chl.frameF=iAACquantizer(S,sfc,AACSeq3(i).chl.G,AACSeq3(i).frameType);
    clear sfc
    % Right channel
    AACSeq2(i).chr.TNScoeffs=AACSeq3(i).chr.TNScoeffs;
    S=decodeHuff(AACSeq3(i).chr.stream,AACSeq3(i).chr.codebook ,loadLUT());
    if strcmp(AACSeq3(i).frameType,'ESH')
        for j=1:8
            a=AACSeq3(i).chr.sfc(j);
            sfc(:,j)=decodeHuff(a{1}',12 ,loadLUT())';
        end
    else
        sfc=decodeHuff(AACSeq3(i).chr.sfc,12 ,loadLUT());
    end
    AACSeq2(i).chr.frameF=iAACquantizer(S,sfc,AACSeq3(i).chr.G,AACSeq3(i).frameType);
    clear sfc
end
if nargout==1
    x = iAACoder2(AACSeq2',fNameOut);
else
    iAACoder2(AACSeq2',fNameOut);
end
end
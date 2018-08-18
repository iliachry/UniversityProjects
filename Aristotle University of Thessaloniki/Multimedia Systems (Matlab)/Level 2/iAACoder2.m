function x = iAACoder2(AACSeq2, fNameOut)
nOframes=size(AACSeq2,1);
% Create AACSeq1
chl=struct('frameF',{});
chr=struct('frameF',{});
AACSeq1=struct('frameType',{},'winType',{},'chl',chl,'chr',chr);
clear chl chr
for i=1:nOframes
    AACSeq1(i).frameType=AACSeq2(i).frameType;
    AACSeq1(i).winType=AACSeq2(i).winType;
    % Left channel
    AACSeq1(i).chl.frameF=iTNS(AACSeq2(i).chl.frameF,AACSeq2(i).frameType, ...
        AACSeq2(i).chl.TNScoeffs);
    % Right channel
    AACSeq1(i).chr.frameF=iTNS(AACSeq2(i).chr.frameF,AACSeq2(i).frameType, ...
        AACSeq2(i).chr.TNScoeffs);
end
if nargout==1
    x = iAACoder1(AACSeq1',fNameOut);
else
    iAACoder1(AACSeq1',fNameOut);
end
end
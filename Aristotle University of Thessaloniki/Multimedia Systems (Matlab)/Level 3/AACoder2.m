function AACSeq2 = AACoder2(fNameIn)
AACSeq1=AACoder1(fNameIn);
chl=struct('frameF',{},'TNScoeffs',{});
chr=struct('frameF',{},'TNScoeffs',{});
AACSeq2=struct('frameType',{},'winType',{},'chl',chl,'chr',chr);
clear chl chr
nOframes=size(AACSeq1,1);
for i=1:nOframes
    AACSeq2(i).frameType=AACSeq1(i).frameType;
    AACSeq2(i).winType=AACSeq1(i).winType;
    % Left Channel
    [frameFout,TNScoeffs]=TNS(AACSeq1(i).chl.frameF,AACSeq1(i).frameType);
    AACSeq2(i).chl.TNScoeffs=TNScoeffs;
    AACSeq2(i).chl.frameF=frameFout;
    % Right Channel
    [frameFout,TNScoeffs]=TNS(AACSeq1(i).chr.frameF,AACSeq1(i).frameType);
    AACSeq2(i).chr.TNScoeffs=TNScoeffs;
    AACSeq2(i).chr.frameF=frameFout;
end
AACSeq2=AACSeq2';
end
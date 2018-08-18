function frameFin = iTNS(frameFout, frameType, TNScoeffs)
    
if strcmp(frameType,'ESH')~=1
    frameFin = filter(1, [1 -TNScoeffs(1) -TNScoeffs(2) -TNScoeffs(3) -TNScoeffs(4)], frameFout);
else
    frameFin = zeros(128, 8);
    for i = 1:1:8
        frameFin(:,i) = filter(1, [1 -TNScoeffs(:,i)'], frameFout(:,i));
    end
end
end
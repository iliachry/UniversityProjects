function x = spreadingfun(i, j, frameType)

B = load('TableB219.mat'); % load the psychoacoustic model's bands
B219a = B.B219a;
B219b = B.B219b;

if strcmp(frameType,'ESH')~=1
    bval = B219a(:,5);
    if i >= j
        tmpx = 3*(bval(j) - bval(i));
    else
        tmpx = 1.5*(bval(j) - bval(i));
    end
    
    tmpz = 8*min((tmpx-0.5)^2 - 2*(tmpx-0.5),0);
    tmpy = 15.811389 + 7.5*(tmpx + 0.474) - 17.5*(1 + (tmpx+0.474)^2)^(0.5);
    
    if tmpy < -100
        x = 0;
    else
        x = 10^((tmpz+tmpy)/10);
    end
else
    bval = B219b(:,5);
    if i >= j
        tmpx = 3*(bval(j) - bval(i));
    else
        tmpx = 1.5*(bval(j) - bval(i));
    end
    
    tmpz = 8*min((tmpx-0.5)^2 - 2*(tmpx-0.5),0);
    tmpy = 15.811389 + 7.5*(tmpx + 0.474) - 17.5*(1 + (tmpx+0.474)^2)^(0.5);
    
    if tmpy < -100
        x = 0;
    else
        x = 10^((tmpz+tmpy)/10);
    end
end

end
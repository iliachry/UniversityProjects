function frameT = iFilterbank(frameF, frameType, winType)
N=2*size(frameF,1);
if strcmp(frameType,'OLS')
    if strcmp(winType,'SIN')
        window=SinWindow(N);
        iframe1=imdct4(frameF(:,1));
        iframe2=imdct4(frameF(:,2));
        frameT(:,1)=iframe1.*window';
        frameT(:,2)=iframe2.*window';
    else
        window=KBDWindow(N,6);
        iframe1=imdct4(frameF(:,1));
        iframe2=imdct4(frameF(:,2));
        frameT(:,1)=iframe1.*window';
        frameT(:,2)=iframe2.*window';    
    end
elseif strcmp(frameType,'ESH')
    N=N*8;
    size1=N/8;
    frameT=zeros(N,2);
    if strcmp(winType,'SIN')
        window=SinWindow(size1);
        for i=0:7
            frame1=imdct4(frameF(:,2*i+1));
            frame2=imdct4(frameF(:,2*i+2));
            frameT(449+(size1/2)*i:449+(size1/2)*i+size1-1,1)=frameT(449+(size1/2)*i:449+(size1/2)*i+size1-1,1)...
                +frame1.*window';
            frameT(449+(size1/2)*i:449+(size1/2)*i+size1-1,2)=frameT(449+(size1/2)*i:449+(size1/2)*i+size1-1,2)...
                +frame2.*window';
        end
    else
        window=KBDWindow(size1,4);
        for i=0:7
            frame1=imdct4(frameF(:,2*i+1));
            frame2=imdct4(frameF(:,2*i+2));
            frameT(449+(size1/2)*i:449+(size1/2)*i+size1-1,1)=frameT(449+(size1/2)*i:449+(size1/2)*i+size1-1,1)+frame1.*window';
            frameT(449+(size1/2)*i:449+(size1/2)*i+size1-1,2)=frameT(449+(size1/2)*i:449+(size1/2)*i+size1-1,2)+frame2.*window';
        end
    end
elseif strcmp( frameType, 'LSS' )
    size1=N/8;
    if strcmp(winType,'SIN')
        win1=SinWindow(N);
        win2=SinWindow(size1);
        window=[win1(1:N/2), ones(1,448), win2(size1/2+1:size1),zeros(1,448)];
        iframe1=imdct4(frameF(:,1));
        iframe2=imdct4(frameF(:,2));
        frameT(:,1)=iframe1.*window';
        frameT(:,2)=iframe2.*window';    
    else       
        win1=KBDWindow(N,6); %Long Kaiser
        win2=KBDWindow(size1,4); %Short Kaiser
        window=[win1(1:N/2),ones(1,448),win2(size1/2+1:size1),zeros(1,448)];
        iframe1=imdct4(frameF(:,1));
        iframe2=imdct4(frameF(:,2));
        frameT(:,1)=iframe1.*window';
        frameT(:,2)=iframe2.*window';    
    end
else
   size1=N/8;
    if strcmp(winType,'SIN')
        win1=SinWindow(N);
        win2=SinWindow(size1);
        window=[zeros(1,448) win2(1:size1/2) ones(1,448) win1(N/2+1:N)];
        iframe1=imdct4(frameF(:,1));
        iframe2=imdct4(frameF(:,2));
        frameT(:,1)=iframe1.*window';
        frameT(:,2)=iframe2.*window';
    else
        win1=KBDWindow(N,6); %Long Kaiser
        win2=KBDWindow(size1,4); %Short Kaiser
        window=[zeros(1,448) win2(1:size1/2) ones(1,448) win1(N/2+1:N)];
        iframe1=imdct4(frameF(:,1));
        iframe2=imdct4(frameF(:,2));
        frameT(:,1)=iframe1.*window';
        frameT(:,2)=iframe2.*window';
    end    
end
end
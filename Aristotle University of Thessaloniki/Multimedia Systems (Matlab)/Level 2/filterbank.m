function frameF = filterbank(frameT, frameType, winType)
N=size(frameT,1);
if strcmp(frameType,'OLS')
    if strcmp(winType,'SIN')
        window=SinWindow(N);
        windowed1=frameT(:,1)'.*window;
        windowed2=frameT(:,2)'.*window;
        frameF(1,:)=mdct4(windowed1)';
        frameF(2,:)=mdct4(windowed2)';
    else
        window=KBDWindow(N,6);
        windowed1=frameT(:,1)'.*window;
        windowed2=frameT(:,2)'.*window;
        frameF(1,:)=mdct4(windowed1)';
        frameF(2,:)=mdct4(windowed2)';
    end
elseif strcmp(frameType,'ESH')
    size1=N/8;
    if strcmp(winType,'SIN')
        window=SinWindow(size1);
        frameF=zeros(16,size1/2);
        for i=0:7
            cframe1=(frameT(449+(size1/2)*i:449+(size1/2)*i+size1-1,1))'.*window;
            cframe2=(frameT(449+(size1/2)*i:449+(size1/2)*i+size1-1,2))'.*window;
            frameF(2*i+1,:)=mdct4(cframe1);
            frameF(2*i+2,:)=mdct4(cframe2);
        end
    else
        window=KBDWindow(size1,4);
        frameF=zeros(16,size1/2);
        for i=0:7
            cframe1=(frameT(449+(size1/2)*i:449+(size1/2)*i+size1-1,1))'.*window;
            cframe2=(frameT(449+(size1/2)*i:449+(size1/2)*i+size1-1,2))'.*window;
            frameF(2*i+1,:)=mdct4(cframe1);
            frameF(2*i+2,:)=mdct4(cframe2);
        end
    end
elseif strcmp( frameType, 'LSS' )
    size1=N/8;
    if strcmp(winType,'SIN')
        win1=SinWindow(N);
        win2=SinWindow(size1);
        window=[win1(1:N/2), ones(1,448), win2(size1/2+1:size1),zeros(1,448)];
        windowed1=frameT(:,1)'.*window;
        windowed2=frameT(:,2)'.*window;
        frameF(1,:)=mdct4(windowed1)';
        frameF(2,:)=mdct4(windowed2)';
    else
        win1=KBDWindow(N,6); %Long Kaiser
        win2=KBDWindow(size1,4); %Short Kaiser
        window=[win1(1:N/2),ones(1,448),win2(size1/2+1:size1),zeros(1,448)];
        windowed1=frameT(:,1)'.*window;
        windowed2=frameT(:,2)'.*window;
        frameF(1,:)=mdct4(windowed1)';
        frameF(2,:)=mdct4(windowed2)';
    end
else
   size1=N/8;
    if strcmp(winType,'SIN')
        win1=SinWindow(N);
        win2=SinWindow(size1);
        window=[zeros(1,448) win2(1:size1/2) ones(1,448) win1(N/2+1:N)];
        windowed1=frameT(:,1)'.*window;
        windowed2=frameT(:,2)'.*window;
        frameF(1,:)=mdct4(windowed1)';
        frameF(2,:)=mdct4(windowed2)';
    else
        win1=KBDWindow(N,6); %Long Kaiser
        win2=KBDWindow(size1,4); %Short Kaiser
        window=[zeros(1,448) win2(1:size1/2) ones(1,448) win1(N/2+1:N)];
        windowed1=frameT(:,1)'.*window;
        windowed2=frameT(:,2)'.*window;
        frameF(1,:)=mdct4(windowed1)';
        frameF(2,:)=mdct4(windowed2)';
    end
end
frameF=frameF';
end
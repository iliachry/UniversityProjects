function frameType = SSC(frameT, nextFrameT, prevFrameType)
if strcmp(prevFrameType,'LSS')
    frameType='ESH';
elseif strcmp(prevFrameType,'LPS')
    frameType='OLS';
else
    frame_length=2048;
    l=8;
    regions=frame_length/(2*l);
    Decision_matrix=['OLS', 'OLS';'OLS' 'LSS';'OLS' 'ESH';'OLS' 'LPS'; ...
        'LSS' 'OLS';'LSS' 'LSS';'LSS' 'ESH';'LSS' 'LPS' ; ...
        'ESH' 'OLS';'ESH' 'LSS';'ESH' 'ESH';'ESH' 'LPS'; ...
        'LPS' 'OLS';'LPS' 'LSS';'LPS' 'ESH';'LPS' 'LPS'];
    Decision_matrix=cellstr(Decision_matrix);
    Decision_matrix2=['OLS';'LSS';'ESH';'LPS';'LSS';'LSS';'ESH';'ESH';'ESH';'ESH';'ESH';'ESH'; ...
        'LPS';'ESH';'ESH';'LPS'];
    % Filter H
    b=[0.7548 -0.7548];
    a=[1  -0.5095];
    category=repmat(char(0),2,3);
    for i=1:2
            Filtered_Seg=filter(b,a,nextFrameT(:,i));  %Filtering
            Filtered_Seg=Filtered_Seg(576:576+1024,1);
            %Finding Energy
            Energy=zeros(1,l);
            for j=1:l
                temp=Filtered_Seg((j-1)*regions+1:regions*j);
                Energy(j)=sumsqr(temp);
            end
            %Finding Attack Values
            attack_values=zeros(1,l);
            sum1=Energy(1);  % Sum of energies of the previous
            attack_values(1)=NaN;
            for j=2:l
                attack_values(j)=Energy(j)/((1/j)*sum1);
                sum1=sum1+Energy(j);
            end
            % Categorising
            flag=0;
            for j=2:l
                if (attack_values(j)>10) && (Energy(j)>10^-3)
                    flag=1;
                    break
                end
            end
            if flag==1
                if strcmp(prevFrameType,'OLS')
                    category(i,1:3)='LSS';
                else
                    category(i,1:3)='ESH';
                end
            elseif flag==0
                if strcmp(prevFrameType,'OLS')
                    category(i,1:3)='OLS';
                else
                    category(i,1:3)='LPS';
                end
            end
    end
category1=char((strcat(category(1,:),category(2,:)))); 
for j=1:16
    if strfind(category1,Decision_matrix(j,:))==1
        frameType=Decision_matrix2(j,:);
        break
    end
end
end   
end
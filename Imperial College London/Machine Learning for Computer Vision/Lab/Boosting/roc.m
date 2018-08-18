function [FP,FN]=roc(dfce,y)

num_data=length(dfce);
n1=length(find(y==1));
n2=length(find(y==-1));

[dfce,inx]=sort(dfce);
y = y(inx);

FP=zeros(1,num_data);
FN=zeros(1,num_data);

wrong1=0;
wrong2=n2;

for i=1:num_data,
  if y(i) == 1,
    wrong1=wrong1+1;
  else
    wrong2=wrong2-1;
  end
  
  FP(i)=wrong2/n2;
  FN(i)=wrong1/n1;
end

return;

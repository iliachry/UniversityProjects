function y=FindAlpha_mcboost_haar(x,model,k,imgs,X,num_data,nExpert,T,t,score) 


eval(['model.Alpha',int2str(k),'(t)=x;']);
eval(['model.Alpha=model.Alpha',int2str(k),';']);

[y, tmp]=feval(model.fun, imgs, X, model);

score(k,:) = 1./(1+exp(-tmp));
        
p=ones(1,num_data);
for m=1:nExpert
    p=p.*(1-score(m,:));
end
p = 1-p;
       
tmp = (p.^T).*(1-p).^(1-T);
L = sum(log(tmp));
y=-L;
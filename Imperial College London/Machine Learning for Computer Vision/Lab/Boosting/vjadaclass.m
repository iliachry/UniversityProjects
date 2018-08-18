function [y,dfce] = vjadaclass(imgs,X,model)

dfce = [];
for i=1:length(model.rule),

    curr_y = vj(model.rule{i}, imgs, X);
  
   if isempty(dfce),
     dfce = curr_y*model.Alpha(i);
   else
     dfce = dfce + curr_y*model.Alpha(i);
   end
end

 y = zeros(size(dfce));
 y(find(dfce>=0)) = 1;
 y(find(dfce<0)) = -1;

return;
% EOF
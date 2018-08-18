function [min_x,min_y,X,Y]=gridsearch(Min,Max,Grid,nloops,fun,varargin)
%  
% Input:
%  Min [dim x 1] Minimum point of the grid.
%  Max [dim x 1] Maximum point of the grid.
%  Grid [dim x 1] Number of point in the grid, i.e. grid density.
%  nloops [1x1] Number of nested loops of the grid search.
%  fun [string] Identifies the minimized function.
%  varargin [cell] Additional arguments of the minimized function.
%
% Output:
%  min_x [dim x 1] Found minimum.
%  min_y [1x1] min_y = fun(min_x).
%  X [dim x n] Points which the grid search checked through.
%  Y [1 x n] Y(i)=fun(X(:,i)).
%

num_variables=length(Min);

if num_variables > length(Grid),
   Grid = Grid*ones(size(Min));
end

if Grid > 1, step=(Max-Min)./(Grid-1); else step = 0; end
x=Min;

min_y = inf;
stop = 0;

X = [];
Y = [];

while ~stop,
   
   y = feval(fun, x, varargin{:});

   X = [X,x(:)];
   Y = [Y,y];
   
   if y < min_y,
      min_y = y;
      min_x = x;
   end
   
   x(1) = x(1) + step(1);

   if Grid > 1,
   
     for i=1:num_variables,
      if x(i)-step(i)/2 > Max(i),
         x(i)=Min(i);
         if i+1 <= length(x),
           x(i+1)=x(i+1)+step(i+1);
         else
            stop=1;
         end
      end
     end
   else 
     stop = 1;
   end
end

if nloops > 1,

   tmp=2*step./Grid;
   Min = min_x - step + tmp;
   Max = min_x + step - tmp;    
   
   [x, y, tmpX, tmpY]=gridsearch( Min, Max, Grid, nloops-1, fun, varargin{:});
      
   if y < min_y,
      min_y = y;
      min_x = x;
   end
   
   X = [X,tmpX];
   Y = [Y,tmpY];

end

return;
% EOF
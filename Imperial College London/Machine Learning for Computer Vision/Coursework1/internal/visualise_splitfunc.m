function visualise_splitfunc(idx_best,data,dim,t,ig_best,iter,split_func) % Draw the split line

r = [-1.5 1.5]; % Data range

subplot(2,2,1);
[N,D] = size(data);
if split_func==1
    if dim == 1
        th = -t(3);
        plot([th th],[r(1),r(2)],'r');
    else
        th = -t(3);
        plot([r(1),r(2)],[th th],'r');
    end
elseif split_func==2
    x = -1.5:0.1:1.5;
    y = -(t(1).*x+t(3))./t(2);
    plot (x,y,'r');
elseif split_func==3
    % Here is the grid range
    u = linspace(-1.5, 1.5, 50);
    v = linspace(-1.5, 1.5, 50);
    
    z = zeros(length(u), length(v));
    % Evaluate z = theta*x over the grid
    for i = 1:length(u)
        for j = 1:length(v)
            z(i,j) = [u(i), v(j),1,u(i)^2,v(i)^2,u(i)*v(i)]*t';
        end
    end
    z = z'; % important to transpose z before calling contour
    
    % Plot z = 0
    % Notice you need to specify the range [0, 0]
    contour(u, v, z, [-100000000 0 100000000],'k')
elseif split_func==5
    
    % Here is the grid range
    u = linspace(-1.5, 1.5, 50);
    v = linspace(-1.5, 1.5, 50);
    z = zeros(length(u), length(v));
    
    % Evaluate z = theta*x over the grid
    for i = 1:length(u)
        for j = 1:length(v)
            %z(i,j) = [u(i), v(j),1,u(i)^2,v(i)^2,u(i)*v(i)]*t';
            z(i,j) = [u(i), v(j), u(i).*v(j), u(i).^2, v(j).^2, (u(i).^2).*v(j), u(i).*(v(j).^2), u(i).^3, v(j).^3]*t';
        end
    end
    z = z'; % important to transpose z before calling contour
    
    % Plot z = 0
    % Notice you need to specify the range [0, 0]
    contour(u, v, z, [-100000000 0 100000000],'k')   
    
elseif split_func==4
    x = -1.5:0.1:1.5;
    if dim==1
        y = x + t(2);
    elseif dim==2
        y = x - t(2);
    end
    plot (x,y,'r');
end
hold on;
plot(data(~idx_best,1), data(~idx_best,2), '*', 'MarkerEdgeColor', [.8 .6 .6], 'MarkerSize', 10);
hold on;
plot(data(idx_best,1), data(idx_best,2), '+', 'MarkerEdgeColor', [.6 .6 .8], 'MarkerSize', 10);

hold on;
plot(data(data(:,end)==1,1), data(data(:,end)==1,2), 'o', 'MarkerFaceColor', [.9 .3 .3], 'MarkerEdgeColor','k');
hold on;
plot(data(data(:,end)==2,1), data(data(:,end)==2,2), 'o', 'MarkerFaceColor', [.3 .9 .3], 'MarkerEdgeColor','k');
hold on;
plot(data(data(:,end)==3,1), data(data(:,end)==3,2), 'o', 'MarkerFaceColor', [.3 .3 .9], 'MarkerEdgeColor','k');

if ~iter
    title(sprintf('BEST Split [%i]. IG = %4.2f',dim,ig_best));
else
    title(sprintf('Trial %i - Split [%i]. IG = %4.2f',iter,dim,ig_best));
end
axis([r(1) r(2) r(1) r(2)]);
hold off;

% histogram of base node
subplot(2,2,2);
tmp = hist(data(:,end), unique(data(:,end)));
bar(tmp);
axis([0.5 3.5 0 max(tmp)]);
title('Class histogram of parent node');
subplot(2,2,3);
bar(hist(data(idx_best,end), unique(data(:,end))));
axis([0.5 3.5 0 max(tmp)]);
title('Class histogram of left child node');
subplot(2,2,4);
bar(hist(data(~idx_best,end), unique(data(:,end))));
axis([0.5 3.5 0 max(tmp)]);
title('Class histogram of right child node');
hold off;
end
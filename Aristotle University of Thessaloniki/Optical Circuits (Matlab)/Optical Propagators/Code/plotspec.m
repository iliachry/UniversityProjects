function plotspec

global h_n1 h_n2 h_h  h_err h_v1 h_v2 h_o1 h_o2 h_pop_h h_pop_map;

%Creation of the Non-Normalized Dispersion graphs

Co = 2.9979 * 10^8 ;

%Take Primary  Input from edit-text boxes
n1   = str2num(get(h_n1,'String'));
n2   = str2num(get(h_n2,'String'));
h    = str2num(get(h_h ,'String'));
omega1 = str2num(get(h_o1,'String')) ;
omega2 = str2num(get(h_o2,'String')) ;
omega = linspace(omega1,omega2,100) ;

%Error Check -> Case of Empty Matrices
err = [n1 n2 h omega1 omega1];
if length(err) ~=5
    set(h_err,'String','Invalid Input(s) => Expression is not a number')
    error('Invalid Input(s) => Expression is not a number')
end

%Define the unit-size of Guiding Layer Height
val = get(h_pop_h,'Value');
if val == 1
    h = h * 10^-3 ; %milli meters
elseif val == 2
    h = h * 10^-6 ; %micro meters
elseif val == 3
    h = h * 10^-9 ; %nano  meters
end

%Call on the dispersion function
[ beta , n_effective , num_max , missed ] = disper0( omega , h , n1 , n2 );

%Boundary Lines of the beta/omega dispersion graph
Slope1 = Co * beta(:,1) / n1 ;
Slope2 = Co * beta(:,1) / n2 ;

%Determine Colormap to use
val = get(h_pop_map,'Value');  
if val == 1
    eval('map=winter(num_max);');
elseif val ==2
    eval('map=spring(num_max);');
elseif val ==3
    eval('map=summer(num_max);');
elseif val ==4
    eval('map=autumn(num_max);');
elseif val ==5
    eval('map=jet(num_max);');
elseif val ==6
    eval('map=hsv(num_max);');
elseif val ==7
    eval('map=hot(num_max);');
end

%ocof == Omega Cut Off Frequency
for i=1:num_max
    ocof(i) = (i-1) *  pi * Co / (  h * sqrt( n1^2 - n2^2 ) );
end

%Dispersion Plot
set(gca,'ColorOrder',map,'NextPlot','replacechildren','Box','on')
plot(beta(:,:),omega,'LineWidth',2);
hold on
%Radiation Modes
vect1 = [ 0  max(omega)*n2/Co -max(omega)*n2/Co] ;
vect2 = [ 0  max(omega)        max(omega) ] ;
fill(vect1,vect2,[0.85 0.85 0.85])
text(0.03*max(beta(:,1)),0.9*max(omega),'Radiation Modes','FontSize',14,'FontAngle','italic','color','r')
hold on
%Colorbar Stuff
colormap(map)
h_bar2 = colorbar('horiz') ;
mode_final = sprintf( 'TE.%d',num_max-1 );
set(h_bar2,'Xlim',[0 1] ,'XTick',[0 1],'XTickLabel',str2mat('TE.0' , mode_final))
set(get(h_bar2,'XLabel'),'String','Order of Modes Present From Lowest to Highest','FontSize',10)
%Cut-Off Frequencies
for i = 1:num_max
    h_ocof = plot( [ 0 min(beta(:,i)) ] , ocof(i)*[1 1] ,':');
    plot( 0 , ocof(i) ,  'Marker' , 'o', 'MarkerSize', 5 ,'MarkerFaceColor',map(i,:),'MarkerEdgeColor',map(i,:) );
    set(h_ocof,'Color', map(i,:) )
    hold on
end
%The symmetric plot of modes for negative betas
plot(- beta(:,:),omega,'LineWidth',2)
hold on
%Plot the slopes
plot( beta(:,1) , Slope1 , 'k' , 'LineWidth' , 2)
hold on
plot( beta(:,1) , Slope2 , 'k' , 'LineWidth' , 2)
hold on
%Symmetric Negative Plots
plot( -beta(:,1) , Slope1 , 'k' , 'LineWidth' , 2)
hold on
plot( -beta(:,1) , Slope2 , 'k' , 'LineWidth' , 2)
grid on
hold off
set(gca,'Layer','Top')
title('Dispersion graph \omega = f ( \beta )','FontSize',14)
xlabel('Phase Constant \beta [ rad / m ]','FontSize',10)
ylabel('Angular Frequency \omega [ rad / sec ]','FontSize',10)
axis( [min(beta(:,1))  max(beta(:,1)) min(omega)  max(omega) ] ) 
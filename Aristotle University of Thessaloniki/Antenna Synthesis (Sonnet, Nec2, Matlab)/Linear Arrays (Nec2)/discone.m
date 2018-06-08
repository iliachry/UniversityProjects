%Construction of a discone antenna
%
%author: Ilias Chrysovergis
%date: March 2016

%parameters: r      = disc radius
%            l      = cone's wires length
%            2*theta0 = cone's apperture angle
%            d      = distance between the cone and the disc

function [ nec_file ] = discone( r,l,theta0,d,wavelength )
    nec_file = fopen('discone_antenna.nec','w');
    phi = 0;
    for i=1:1:8
       theta = pi/2;
       fprintf(nec_file,'GW %.d 13 %.6f %.6f %.6f %.6f %.6f %.6f %.6f \n',i,0,0,d,r*sin(theta)*cos(phi),r*sin(theta)*sin(phi),d,wavelength/100);
       phi = phi + pi/4;
    end
    phi = 0;
    for i=9:1:16
        fprintf(nec_file,'GW %.d 21 %.6f %.6f %.6f %.6f %.6f %.6f %.6f \n',i,0,0,0,l*sin(theta0)*cos(phi),l*sin(theta0)*sin(phi),-l*cos(theta0),wavelength/100);
        phi = phi + pi/4;
    end
    fprintf(nec_file,'GW 17 1 %.6f %.6f %.6f %.6f %.6f %.6f %.6f \n',0,0,0,0,0,d,wavelength/100);
    fprintf(nec_file,'GE -1\n');
    fprintf(nec_file,'GN -1\n');
    fprintf(nec_file,'EK');
    fprintf(nec_file,'EN');
    fclose('all');
end


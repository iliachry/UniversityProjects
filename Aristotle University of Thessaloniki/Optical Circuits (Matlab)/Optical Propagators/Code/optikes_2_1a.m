wavelength1=1.55;
wavelength2=1.31;
n1=3.45;
n2=1.45;
n3=1.34;
flag1=true;
flag2=true;
for h = 0.2:0.0001:0.35
    [neff_TE,neff_TM]=APDWG(wavelength1,h,n1,n2,n3);
    if length(neff_TE)>1 && flag1==true
        Hmax_TE = h;
        flag1=false;
    end
    if length(neff_TM)>1 && flag2==true
        Hmax_TM = h;
        flag2=false;
    end

end

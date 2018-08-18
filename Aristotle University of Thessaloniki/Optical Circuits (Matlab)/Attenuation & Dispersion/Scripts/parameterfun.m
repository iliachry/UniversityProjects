function F = parameterfun(b,V)
F=[sqrt(1-b)*besselj(1,V*sqrt(1-b))*besselk(0,V*sqrt(b))-sqrt(b)*besselk(1,V*sqrt(b))*besselj(0,V*sqrt(1-b))];
end

function sw = HannWindow(s)
N = length(s);
sw = s.*(0.5 - 0.5*cos(pi*((0:N-1)+0.5)/N))';
end
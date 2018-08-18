function quant=quantizer(a)
for i = 1:1:length(a)
        if a(i) < -0.7
            a(i) = -0.75;
        elseif -0.7 <= a(i) && a(i) < -0.6
            a(i) = -0.65; 
        elseif -0.6 <= a(i) && a(i) < -0.5
            a(i) = -0.55; 
        elseif -0.5 <= a(i) && a(i) < -0.4
            a(i) = -0.45; 
        elseif -0.4 <= a(i) && a(i) < -0.3
            a(i) = -0.35; 
        elseif -0.3 <= a(i) && a(i) < -0.2
            a(i) = -0.25; 
        elseif -0.2 <= a(i) && a(i) < -0.1
            a(i) = -0.15; 
        elseif -0.1 <= a(i) && a(i) < 0
            a(i) = -0.05; 
        elseif 0 <= a(i) && a(i) < 0.1
            a(i) = 0.05;  
        elseif 0.1 <= a(i) && a(i) < 0.2
            a(i) = 0.15; 
        elseif 0.2 <= a(i) && a(i) < 0.3
            a(i) = 0.25;
        elseif 0.3 <= a(i) && a(i) < 0.4
            a(i) = 0.35; 
        elseif 0.4 <= a(i) && a(i) < 0.5
            a(i) = 0.45; 
        elseif 0.5 <= a(i) && a(i) < 0.6
            a(i) = 0.55; 
        elseif 0.6 <= a(i) && a(i) < 0.7
            a(i) = 0.65;             
        else
            a(i) = 0.75;
        end   
end
quant=a;
end
% build list of weak classifiers

sizeX = 24; sizeY = 24;
cl = zeros(7, 21780);

idx = 1;
for type=1:5
  for startX=0:2:(sizeX-4)
    for startY=0:2:(sizeY-4)
      for endX=(startX+4):2:sizeX
        for endY=(startY+4):2:sizeY
            cl(:, idx) = [type; startX/sizeX; startY/sizeY; endX/sizeX; ...
                endY/sizeY; 0; 1];
            idx = idx + 1;
        end;
      end;
    end;
  end;
end;
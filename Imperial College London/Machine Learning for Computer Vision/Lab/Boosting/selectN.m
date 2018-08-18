function index = selectN(distr, N)
  
  index = zeros(1, N);
  
  idx = sum(distr) * rand(1, N);
  idx = sort(idx);

  J = 1;
  I = 1;
  K=1;
  s = 0;
  TSLength = length(distr);
  while I <= TSLength
    s = s + distr(I);
    while idx(J) < s
      index(J) = I;
      J = J + 1;
      if J > N 
	return;
      end
    end
    I = I + 1;
  end
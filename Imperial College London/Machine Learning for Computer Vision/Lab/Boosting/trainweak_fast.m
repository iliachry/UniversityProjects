function cl_best = trainweak_fast(imgs, X, Y, clist, D)

  n_data = size(X,2);  

  index = selectN(D, n_data); index = unique(index);
  newX = X(:, index);
  newY = Y(index);
  newD = D(index);
  
  
  idx2 = index;
  
  idx3 = zeros(1,size(idx2,2));
  for i=1:size(idx2,2)
    idx3(i) = find(idx2(i)==index);
  end
  
    
  TSLength = length(newX);
  cl = clist;
  
  step = 500;          % due to memory limits
  [tmp, cllen] = size(cl);
  J = 0;
  
  err = zeros(1,cllen);
  
  while cllen > 0          
    start = J * step + 1;
    if (step < cllen)
      finish = (J + 1) * step;
    else
      finish = J * step + cllen;
    end
    evals = realvj(clist(:, start:finish), imgs, newX);

    for I = start:finish
      sevals = [evals(I-start+1, :); newY; newD];
      %sevals = sortcols(sevals)';
      sevals = sortrows(sevals');
      
      pos_thresh = unique(sevals(idx3,1))';
      pos_thresh = (pos_thresh(1:end-1) + pos_thresh(2:end))/2;
         
      [thresh, parity, sum] = findparthresh(sevals, pos_thresh);
      cl(6, I) = thresh;
      cl(7, I) = parity;
      err(1,I) = sum;
    end
    
    cllen = cllen - step;
    %fprintf('%d \n',cllen);
    J = J + 1;
  end


  % find best weak classifier
  best = find(err==min(err));
  best_idx = best(1);
    
  
  % save best weak classifier
  cl_best = cl(:, best_idx);

    
  clear evals;


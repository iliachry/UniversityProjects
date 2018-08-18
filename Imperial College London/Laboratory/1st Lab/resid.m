function y_r = resid(y,phiI)
y_r = y-phiI*inv(phiI'*phiI)*phiI'*y;


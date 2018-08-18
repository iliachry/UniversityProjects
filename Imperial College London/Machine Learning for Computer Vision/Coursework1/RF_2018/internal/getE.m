function H = getE(X) % Entropy
cdist= histc(X(:,end), unique(X(:,end)));
cdist= cdist/sum(cdist);
cdist= cdist .* log(cdist);
H = -sum(cdist);
end
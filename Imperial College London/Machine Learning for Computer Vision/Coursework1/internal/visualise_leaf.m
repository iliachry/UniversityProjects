function visualise_leaf( trees )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
for L = 1:16
try
subplot(4,4,L);
bar(trees(randi([1,length(trees)],1,1)).leaf(L).prob);
axis([0.5 3.5 0 1]);
end
end

end


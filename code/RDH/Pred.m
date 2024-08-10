%% Predicts a pixel value based on its neighbors
% Takes the average of the up (u), left (l), down (d), and right (r) neighbors
function rst=Pred(u,l,d,r)
    rst=floor((u+l+d+r)/4);
end
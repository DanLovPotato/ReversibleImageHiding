function CDs = standard_dev(blocks)
%this function is to calculate standard deviations of all blocks 
%and of all their colour channes

[~,~,r] = size(blocks);
CDs = zeros(1,r);

for i = 1:r  %scan all tiles
    tile = blocks(:,:,i);
    CDs(1,i) = std(tile,1,'all');
end 



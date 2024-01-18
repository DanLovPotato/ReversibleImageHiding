function S_tiles = re_transform(C_tiles,seqn,layer)

global block_delta block_rot block_trunc

[~,~,r] = size(C_tiles); 
S_tiles = C_tiles;
 
%calcualte an inverse map of tiles from camouflage->secret
tile_idx = [1:1:r];
[~,I]= sort(seqn);
seqn = tile_idx(I);

for i = 1:r
    
    %read out the corresponding camouflage block
    C_tile = C_tiles(:,:,i);
    
    %rotate each block in an anti-clockwise direction
    angle = block_rot(layer,i);
    tile_img = uint8(C_tile);
     
    rot_img = rot90(tile_img,-angle);
    tile_img = double(rot_img);
    
    %add the truncated residuals back to the pixels
    temp1_idx = find(block_trunc(2,:)==i);  
    if isempty(temp1_idx) == 0   %check if the tile number had any over/underflow
        temp1 = block_trunc(:,temp1_idx); 
        temp2_idx = find(temp1(1,:)==layer);
        if isempty(temp2_idx) == 0 %check if it is right color layer
            temp2 = temp1(3:end,temp2_idx);
            tile_img(temp2(1,:)) = tile_img(temp2(1,:))+temp2(2,:);
        end 
    end
    
    %subtract delta_u from each value
    delta = block_delta(layer,i);
    if mod(delta,2)==0
        delta = 4*delta;
    else 
        delta = -4*delta;
    end 
    
    tile_img = tile_img-delta;
  
    S_tiles(:,:,seqn(i)) = tile_img;
end


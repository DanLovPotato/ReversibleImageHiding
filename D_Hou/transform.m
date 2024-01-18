function S_tiles_trans = transform(S_tiles, T_tiles, seqn, layer)
%the function is to return a transformed S tiles
%input: secret blcoks, target blocks, secret block order, target block order
%output: transformed secret blocks in an orignal order(1,2,3,....)

global block_delta block_rot block_trunc

[~,~,r] = size(S_tiles);
S_tiles_trans = S_tiles;

for i = 1:r 
    %calculate delta_u from eqn(5) 
    S_tile = S_tiles(:,:,i);
    T_tile = T_tiles(:,:,seqn(i));
    delta_u = mean(T_tile,'all')-mean(S_tile,'all');
    
    %modify delta_u according to eqn(6)
    delta_u = round(delta_u); 
    
    %modify delta_u according to eqn(8) and eqn(9)
    Ov_max =  max(max(S_tile))+delta_u;
    Un_min =  min(min(S_tile))+delta_u;
    
    Thred = 1; 
    if (delta_u > 0) && (Ov_max-255 > 0) 
        if (Ov_max-255) < Thred
            delta_u = delta_u+255-Ov_max;
        else
             delta_u = delta_u-Thred; 
        end
    elseif (delta_u < 0) && (Un_min < 0) 
        Un_min = abs(Un_min);
        if Un_min < Thred
           delta_u = delta_u+Un_min;
        else 
           delta_u = delta_u+Thred;
        end 
    end
    
    %modify delta_u according to eqn(10)
    if delta_u >= 0
        delta_u = 8*round(delta_u/8); 
    else 
        delta_u = 8*floor(delta_u/8)+4; 
    end
      
    
    %transform the secret tile by delta_u using eqn(5)
    S_tile_trans =  S_tile + delta_u;
    block_delta(layer,seqn(i)) = abs(delta_u)/4; %collect information: delta
    
    %Record the residuals/positions of truncations using eqn(11)
     R_pos_over = find(S_tile_trans > 255); 
     l = length(R_pos_over);
     if l~=0
         R_val_over = S_tile_trans(R_pos_over)-255; 
         block_trunc = [block_trunc [ones(l,1)*layer ones(l,1)*seqn(i) R_pos_over R_val_over]'];
         S_tile_trans(R_pos_over) = 255; 
     end
     
     R_pos_under = find(S_tile_trans<0);
     l = length(R_pos_under);
     if l~=0
        R_val_under = -S_tile_trans(R_pos_under); 
        block_trunc = [block_trunc [ones(l,1)*layer ones(l,1)*seqn(i) R_pos_under -R_val_under]'];
        S_tile_trans(R_pos_under) = 0; 
     end
     
     %rotate the image and find optimal angle with repect to target image
     tile_img = uint8(S_tile_trans); 
     errors = zeros(1,4);
     errors(1,1) = sum(sum((S_tile_trans - T_tile).^2));
     
     temp = errors(1,1);
     block_rot(layer,seqn(i)) = 0;   %collect information: rotation
     for k = 2:4
         rot_img = rot90(tile_img,k-1);
         errors(1,k) = sum(sum((double(rot_img) - T_tile).^2));
         if temp > errors(1,k)
             S_tile_trans = double(rot_img);
             temp = errors(1,k);
             block_rot(layer,seqn(i)) = k-1;
         end
     end
     
    %save the transformed block as a block in the target image
    S_tiles_trans(:,:,seqn(i)) = S_tile_trans; 
end 



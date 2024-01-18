function camouflage_img = img_creation(secret_img, target_img, key)

% This function is responsible for camouflage creation, which takes
% Input: A secret image, target image and a secret key P
% Output: A camouflage image

global block_order block_delta block_rot block_trunc
%%%%%%%%%%%
% step 0: read the color channels of secret/target image 
% to 4*4 tiles 
%%%%%%%%%%%

S_img = imread(secret_img); %read the secret image
T_img = imread(target_img); %read the target image

[row_pixels,col_pixels,layers] = size(T_img);
block_numb = 4; 
km = floor(row_pixels/block_numb);
kn = floor(col_pixels/block_numb); 
camouflage_img = zeros(km*block_numb,kn*block_numb,layers);

block_order = zeros(layers,km*kn);
block_delta = zeros(layers,km*kn);
block_rot = zeros(layers,km*kn);
block_trunc = zeros(4,1);

for clor = 1:layers 

S = S_img(:,:,clor);
T = T_img(:,:,clor);

%%%%%%%%%%%
% step 1: divide each color channel of secret/target image 
% to 4*4 tiles 
%%%%%%%%%%%


%divide images into 4*4 blocks(in raster order)
S_blocks = blocklised(S, block_numb);
T_blocks = blocklised(T, block_numb); 
%%%%%%%%%%%
% step 2: cluster each colour channel of both images to K classes with
% respect to their Standard Deviations(SDs)
%%%%%%%%%%%

%standard deviations for tiles in both images
S_SDs = standard_dev(S_blocks);
T_SDs = standard_dev(T_blocks); 

%first,cluster the secret image into K classes using K-means
%then the target image according accordingly 
K = 3; 
map_seq = S_map_T(S_SDs,T_SDs,K); 

%collect block_order
block_order(clor,:) = map_seq;

%%%%%%%%%%%
% step 3: Assign a compound index to each tile according to the
% class indexes and the scanning order
%%%%%%%%%%%




%%%%%%%%%%%
%step4-7 are all implemented in the function 'transform'.
%step 4: calcualte delta_u for all corresponding tiles 
%step 5: Record the residuals/positions of truncations due to overflow/underflow
%Step 6: Rotate each transformed tile into the optimal one 
%Step 7: Replace each target tile with the corresponding transformed tile
%%%%%%%%%%%

S_blocks_trans = transform(S_blocks, T_blocks, map_seq, clor);

%%%%%%%%%%%
%Step 8: Combine three color channels to generate the transformed image
%%%%%%%%%%%

T = assemble(S_blocks_trans,km,kn);
camouflage_img(:,:,clor) = T;

%%%%%%%%%%%
%Step 9: compress parameters: 
%       class_idx, delta_u,rot_direction, trunc_res
%%%%%%%%%%%





%%%%%%%%%%%
%Step 10: Encrypt parameters with the key P, 
%         and embed to the transformed image by RDH
%%%%%%%%%%%




end

save block_order.mat 'block_order'
save block_delta.mat 'block_delta'
save block_rot.mat 'block_rot'
save block_trunc.mat 'block_trunc'

camouflage_name = strcat('hidden',secret_img);
imwrite(uint8(camouflage_img),camouflage_name);
end

%img_creation('woman.png','man.png',0);
%img_recovery('final.png',0);

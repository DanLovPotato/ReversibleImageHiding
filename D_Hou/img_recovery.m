function  secret_img= img_recovery(camouflage_img, key)

% This function is responsible for secret image recovery, which takes
% Input: a camouflage image and the secret key P.
% Output: the secret image

global block_order block_delta block_rot block_trunc

%%%%%%%%%%%
% step 0: read the camouflage image
%%%%%%%%%%%
C_img = imread(camouflage_img);

[row_pixels,col_pixels,layers] = size(C_img);
block_numb = 4; 
km = floor(row_pixels/block_numb);
kn = floor(col_pixels/block_numb); 
secret_img = zeros(km*block_numb,kn*block_numb,layers);

%%%%%%%%%%%
%Step 1: Extract the encrypted sequence 
%        and restore the transformed image with the RDH scheme.
%%%%%%%%%%%





%%%%%%%%%%%
%Step 2: Decrypt and decompress:  
%        class_idx, delta_u,rot_direction, trunc_res
%%%%%%%%%%%





block_order = importdata('block_order.mat');
block_delta = importdata('block_delta.mat');
block_rot = importdata('block_rot.mat');
block_trunc = importdata('block_trunc.mat');


%%%%%%%%%%%
%Step 3: recover each tile from rot_direction sequence
%Step 4: recover each pixel from overflow/underflow residule
%Step 5:  Calculate the SD of each transformed tile
%Step 6:  assign a compound index to it
%Step 7: restore delta_u, hence the secret tile 
%Step 8: Combine color channels to restore the secret image
%%%%%%%%%%%

for clor = 1:layers 
C = C_img(:,:,clor);
C_blocks = blocklised(C,block_numb); 


map_seq = block_order(clor,:);
S_blcoks = re_transform(C_blocks,map_seq,clor); 

S = assemble(S_blcoks,km,kn);
secret_img(:,:,clor) = S;

end 

%write the recovered secret image to a picture format,eg .png
secret_name = strcat('recovered',camouflage_img);
imwrite(uint8(secret_img),secret_name);

secret_img=uint8(secret_img)

subplot(1,2,1);imshow(C_img,'Border','tight'); title('输入的伪装图像');
subplot(1,2,2);imshow(secret_img,'Border','tight'); title('提取出的秘密图像');

end 



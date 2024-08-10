clear
clc
close all;
addpath ..\data\ ;
addpath RDH\;
addpath utilities\;
s=imread('woman.png');% secrect image
c=imread('man.png');% target image
[m,n]=size(s(:,:,1)); % Get the size of the secret image
 
%---------------------------------
%First round of transformation
%---------------------------------
block1=16;  % Block size for the first round

% Calculate number of blocks in the first round
km1=floor(m/block1);
kn1=floor(n/block1);
ss1=s(1:km1*block1,1:kn1*block1,:);
cc1=c(1:km1*block1,1:kn1*block1,:);

% Initialize iteration counter for first round
i1=0
i1=i1+1;

% Perform the first round of transformation
[transform_rmse1(i1),class_bits1(i1),bpp1(i1),C1,sc1]=transform1(ss1,cc1,8,4,block1);

%---------------------------------
%Second round of transformation
%---------------------------------
  
block2 = 4; % Block size for the second round 
 
% Calculate number of blocks in the second round
km2 = floor(m / block2);
kn2 = floor(n / block2);
ss2 = s(1:km2*block2, 1:kn2*block2, :); 
cc2 = c(1:km2*block2, 1:kn2*block2, :);

% Initialize iteration counter for second round
i2 = 0;
i2 = i2 + 1;

% Load intermediate transformed image from first round
s2 = imread('..\results\transfer1.png');
ss2 = s2(1:km2*block2, 1:kn2*block2, :);
% Perform the second round of transformation
[transform_rmse2(i2), class_bits2(i2), bpp2(i2), C2, sc2] = transform2(ss2, cc2, 10, 4, block2);

%---------------------------------
% RDH in two layers
%---------------------------------
res = Sachnev(C2, 0.7 * bpp1); % Apply RDH to the transformed image
ree = uint8(res);
mse = appraise(ree(:), cc2(:)); % Compute Mean Squared Error (MSE)
res = Sachnev(res, 0.3 * bpp2); % Apply RDH for the second round

% Reshape the result to the correct dimensions
[m, n] = size(sc2(:,:,1));
res = reshape(res, m, n, 3);
res = uint8(res);

% RMS between stego and target image
stego_rmse = appraise(res, cc2);

% Save the final stego image
imwrite(res, '../results/final.png');
 
% Display images
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
subplot(2,2,1); imshow(s, 'Border', 'tight'); title('Secret Image');
subplot(2,2,2); imshow(c, 'Border', 'tight'); title('Target Image');
subplot(2,2,3); imshow(s2, 'Border', 'tight'); title('First Round Transformed Image');
subplot(2,2,4); imshow(res, 'Border', 'tight'); title('Second Round Transformed Image');

%psnr
psnr1=imcpsnr(s2,c);
psnr2=imcpsnr(res,c);

%ssim
ssim2 = ssim(res, c);
ssim1 = ssim(s2, c);

%entropy 
I = res;
[C, L] = size(I); 
Img_size = C * L; 
G = 256; 
H_x1 = 0;
nk = zeros(G, 1);
for i = 1:C
    for j = 1:L
        Img_level = I(i, j) + 1; % Get pixel value
        nk(Img_level) = nk(Img_level) + 1; 
    end
end

for k = 1:G
    Ps(k) = nk(k) / Img_size; % Probability of each pixel level
    if Ps(k) ~= 0
        H_x1 = -Ps(k) * log2(Ps(k)) + H_x1; % Entropy calculation
    end
end

% Display stats
disp('-------------------------------------------------------');
disp(['Transform RMSE (Round 1): ', num2str(transform_rmse1)]);
disp(['Transform RMSE (Round 2): ', num2str(transform_rmse2)]);
disp(['Stego RMSE: ', num2str(stego_rmse)]);
disp(['PSNR (Round 1): ', num2str(psnr1)]);
disp(['PSNR (Round 2): ', num2str(psnr2)]);
disp(['SSIM (Round 1): ', num2str(ssim1)]);
disp(['SSIM (Round 2): ', num2str(ssim2)]);
disp(['Entropy of the final stego image: ', num2str(H_x1)]);
disp('--------------------------------------------------------');











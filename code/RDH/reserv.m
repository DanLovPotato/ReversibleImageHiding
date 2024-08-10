clear all;   
clc
I = imread('..\data\mosaic.png');   
s = imread('..\data\bus.png');

[m, n] = size(I(:,:,1));
C = [I(:,:,1) I(:,:,2) I(:,:,3)];
% Perform the embedding process using the Sachnev algorithm
res = Sachnev(C, 0.78);
% Reshape the result back into the original image dimensions
res = reshape(res, m, n, 3);
res = uint8(res);
appraise(res, s)

imwrite(res, 'embeded1.png');

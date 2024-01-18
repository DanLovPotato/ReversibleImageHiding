%[filename,pathname]=uigetfile({'*.jpg';'*bmp';'*gif'},'选择原图片'); 
I = imread('原图.bmp'); 
I1 = imread('本文方法.bmp'); 
I2 = imread('Hou方法.bmp'); 


I1=rgb2gray(I1); 
I2=rgb2gray(I2); 

%五种边缘检测 
figure('Name','laplace算子'); 
subplot(2,3,1); 
imshow(I); 
title('原目标图像'); 

BW4=edge(I1,'LOG',0.012); 
subplot(2,3,2); 
imshow(BW4); 
title('本文方法') 

BW4=edge(I2,'LOG',0.012); 
subplot(2,3,3); 
imshow(BW4); 
title('Hou et al.方法') 


I=rgb2gray(I); 
BW4=edge(I,'LOG',0.012); 
subplot(2,3,4); 
imshow(BW4); 
title('') 




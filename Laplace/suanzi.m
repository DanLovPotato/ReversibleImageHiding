%[filename,pathname]=uigetfile({'*.jpg';'*bmp';'*gif'},'ѡ��ԭͼƬ'); 
I = imread('ԭͼ.bmp'); 
I1 = imread('���ķ���.bmp'); 
I2 = imread('Hou����.bmp'); 


I1=rgb2gray(I1); 
I2=rgb2gray(I2); 

%���ֱ�Ե��� 
figure('Name','laplace����'); 
subplot(2,3,1); 
imshow(I); 
title('ԭĿ��ͼ��'); 

BW4=edge(I1,'LOG',0.012); 
subplot(2,3,2); 
imshow(BW4); 
title('���ķ���') 

BW4=edge(I2,'LOG',0.012); 
subplot(2,3,3); 
imshow(BW4); 
title('Hou et al.����') 


I=rgb2gray(I); 
BW4=edge(I,'LOG',0.012); 
subplot(2,3,4); 
imshow(BW4); 
title('') 




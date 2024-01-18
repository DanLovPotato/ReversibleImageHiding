clear
clc
close all;
%����ͼ�����ݿ�
addpath testimage\ ;
addpath RDH\;

s=imread('woman.png');%%%%%%%%%����ͼ
c=imread('man.png');%%%%%%%%%Ŀ��ͼ
 [m,n]=size(s(:,:,1));
 
 %transform_rmse=zeros(5,1);
 %stego_rmse=zeros(5,1);
 %class_bits=zeros(5,1);
 % bpp=zeros(5,1);
 
%  for block2=4:4:16
  block1=16; %%%%%%%%%%%%%%%%%%%%%%%%%first round
  
  km1=floor(m/block1);
  kn1=floor(n/block1);
  ss1=s(1:km1*block1,1:kn1*block1,:);
  cc1=c(1:km1*block1,1:kn1*block1,:);
 i1=0
 i1=i1+1;
 [transform_rmse1(i1),class_bits1(i1),bpp1(i1),C1,sc1]=transform1(ss1,cc1,8,4,block1);
 %unction [transform_rmse,class_bits,bpp,C1,sc]=transform1(ss1,cc1,km1,T1,block1)
 %%%%%%%%%%%%%%%%%&&&&&&&&&&&&&&&&&&&&&&&&&&&&%second round
  
 block2=4;     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% second round
 
  km2=floor(m/block2);
  kn2=floor(n/block2);
  ss2=s(1:km2*block2,1:kn2*block2,:);
  cc2=c(1:km2*block2,1:kn2*block2,:);
 i2=0
 i2=i2+1;
s2=imread('transfer1.png');%����ͼ
ss2=s2(1:km2*block2,1:kn2*block2,:); 
 [transform_rmse2(i2),class_bits2(i2),bpp2(i2),C2,sc2]=transform2(ss2,cc2,10,4,block2);
 
 
 %% RDH in two layers



res=Sachnev(C2,0.7*bpp1);
ree=uint8(res);
mse = appraise(ree(:),cc2(:));
res=Sachnev(res,0.3*bpp2);
[m,n]=size(sc2(:,:,1));
res=reshape(res,m,n,3);
res=uint8(res);
stego_rmse = appraise(res,cc2)



imwrite(res,'final.png');%% final stego image
 
subplot(2,2,1);imshow(s,'Border','tight');title('����ͼ��');
subplot(2,2,2);imshow(c,'Border','tight'); title('Ŀ��ͼ��');
subplot(2,2,3);imshow(s2,'Border','tight');title('��һ�ֱ仯ͼ��');
subplot(2,2,4);imshow(res,'Border','tight'); title('�ڶ��ֱ仯ͼ��');   

%  end
 
% % km2= 128
%  [transform_rmse,stego_rmse,class_bits,bpp]=transform(ss2,cc2,4,10)


%psnr
psnr1=imcpsnr(s2,c);
psnr2=imcpsnr(res,c);
%psnr2=imcpsnr(final_image1,Tar_Image1);

%ssim
img1=res;
img2= c;
ssim2=ssim(img1,img2)
ssim1=ssim(s2,c)


%---------------------------------
%��һ��ͼ�����ֵ
%---------------------------------
I=res;
[C,L]=size(I); %��ͼ��Ĺ��
Img_size=C*L; %ͼ�����ص���ܸ���
G=256; %ͼ��ĻҶȼ�
H_x1=0;
nk=zeros(G,1);%����һ��G��1�е�ȫ�����
for i=1:C
for j=1:L
Img_level=I(i,j)+1; %��ȡͼ��ĻҶȼ�
nk(Img_level)=nk(Img_level)+1; %ͳ��ÿ���Ҷȼ����صĵ���
end
end
for k=1:G  %ѭ��
Ps(k)=nk(k)/Img_size; %����ÿһ�����ص�ĸ���
if Ps(k)~=0; %������ص�ĸ��ʲ�Ϊ��
H_x1=-Ps(k)*log2(Ps(k))+H_x1; %����ֵ�Ĺ�ʽ
end
end
H_x1  %��ʾ��ֵ











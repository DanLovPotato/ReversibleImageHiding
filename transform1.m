function [transform_rmse,class_bits,bpp,C1,sc]=transform1(ss,cc,KM,T,block)
 %% add RDH path 
addpath RDH\;

% ss(:,:,1)=sss(:,:,1)';
% ss(:,:,2)=sss(:,:,2)';
% ss(:,:,3)=sss(:,:,3)';
%   cc=imresize(cc,1/8);
%   imwrite(cc,'r.png');
%   cc=imread('r.png');
%     cc=imresize(cc,8);
ss=double(ss);
cc=double(cc);
 sc=cc;
% block=4;
%% transformation for RGB    KM + move blocks+ number 
for i=1:3
[sc(:,:,i),th_vector(i,:),rot_vector(i,:),place_vector(i,:)]=shift(ss(:,:,i),cc(:,:,i),KM,T,block);
end
%% find redu  OVERFLOW  找溢出
sc_liner=sc(:);
 redu=find((sc_liner>=255)|(sc_liner<=0));
L_redu=length(redu);
flow=zeros(1,L_redu);
for i=1:L_redu
    if sc_liner(redu(i))>1
        flow(i)=sc_liner(redu(i))-255;
        sc_liner(redu(i))=255;
    end
    if sc_liner(redu(i))<1
        flow(i)=0-sc_liner(redu(i));
        sc_liner(redu(i))=0;
    end
end
[m,n]=size(ss(:,:,1));
sc=reshape(sc_liner,m,n,3);
save rot rot_vector;save tag place_vector;save th th_vector;save flow flow;
% rotate/ place where overflow/  threshold / overflow多少
%% rotate information  ROTATE
rot_inf=de2bi(rot_vector(:));
rot_inf=rot_inf(:)';
num=m*n*3*5/(block*block);
L2=length(dec2bin(num));
num_flow=3*m*n/2;
%% class information   算block排序的信息的比特位
L_flow=length(dec2bin(num_flow));
re1=huffman(place_vector(:));

class_bits=length(re1)*16/(m*n*3);

L_inf=de2bi(length(re1),L2);


%% detal U information   秘密图像块与目标图像快像素平均值的差值2
re2=huffman(th_vector(:));

%% redu information  溢出位置二进制2
re3=huffman(flow');
L_flowinf=de2bi(length(re3),L_flow);
%% total additional information
messstream=[rot_inf L_inf re1' L_flowinf re3' re2'];
save mess messstream;
bpp=length(messstream)/(m*n*3)   %   AI/PIXELS

transform_rmse = appraise(sc,cc)

sc=uint8(sc);
imwrite(sc,'transfer1.png');%%created stego image before RDH

C1=[sc(:,:,1) sc(:,:,2) sc(:,:,3)];

%% RDH in two layers
%res=Sachnev(C,0.7*bpp);
% ree=uint8(res);
% mse = appraise(ree(:),cc(:));
% res=Sachnev(res,0.3*bpp);
% [m,n]=size(sc(:,:,1));
% res=reshape(res,m,n,3);
% res=uint8(res);

 %stego_rmse = appraise(res,cc)


%imwrite(res,strcat(num2str(block),'.png'));%% final stego image









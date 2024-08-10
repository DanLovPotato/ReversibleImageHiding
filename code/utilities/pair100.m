clear;clc
% addpath imagedatabase\;
cd='D:\houdd\matlab_code_RIT_kmeans\imagedatabase\';
a=dir(cd);
b=a(3:end);
n=length(b);
bpp=zeros(n,1);
transform_rmse=zeros(n,1);
stego_rmse=zeros(n,1);

%  parpool(12);

for i=1:n
    strcat(cd,b(i).name,'\secret.tiff')
    strcat(cd,b(i).name,'\target.tiff')
    ss=imread(strcat(cd,b(i).name,'\secret.tiff'));
    cc=imread(strcat(cd,b(i).name,'\target.tiff'));
   [transform_rmse(i),stego_rmse(i),class_bits,bpp(i)]=transform(ss,cc,10,10);
end
%   poolobj=gcp('nocreate');
%   delete(poolobj)

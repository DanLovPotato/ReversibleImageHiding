function MSSIM=get_ssim(img,imgn)

img=double(img);
imgn=double(imgn);
    block=8;
   
    [m,n,k]=size(img);
    m=m/block;
    n=n/block;
    L=length(img(:))/(block*block);
    tmp=zeros(1,L);
    
    num=0;
 for ii=1:k
    for i=1:m
       for j=1:n
           num=num+1;
          tmp(num)= SSIM(img((i-1)*block+1:block*i,(j-1)*block+1:block*j,ii),imgn((i-1)*block+1:block*i,(j-1)*block+1:block*j,ii));        
       end    
    end
 end
    MSSIM=mean(tmp);

   
clc
clear
%%recover secret image
gim=imread('final.bmp');
gim=double(gim);
% mess=load('matlab.mat');
% t=extract(ss,messstream);
cc=imread('final.bmp');
rot_vector=importdata('rot.mat');
place_vector=importdata('tag.mat');
th_vector=importdata('th.mat');
flow=importdata('flow.mat');
gim_liner=gim(:);
 redu=find((gim_liner==255)|(gim_liner==0));
L_redu=length(redu);

for i=1:L_redu
    if gim_liner(redu(i))==0
       gim_liner(redu(i))=gim_liner(redu(i))-flow(i);
        
    end
    if gim_liner(redu(i))==255
         gim_liner(redu(i))=gim_liner(redu(i))+flow(i);
    end
end
[m,n]=size(gim(:,:,1));
gim=reshape(gim_liner,m,n,3);
for i=1:3
secret(:,:,i)=recover(gim(:,:,i),rot_vector(i,:),place_vector(i,:),th_vector(i,:));
end


secret=uint8(secret);

 mse=sum(abs(secret(:)-cc(:)))
mse = appraise(secret,cc )
 imwrite(secret,'secret.png');


% s=gim(1:8,1:8,1);
% tt=recover(s,rot_vector(1,:),place_vector(1,:),th_vector(1,:))
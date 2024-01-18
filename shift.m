%% shift transformation
function [b,th_vector,rot_vector,tag]=shift(s,c,KM,T,block)
% block=4;
% T=10;
[sm,sn]=size(s);
b=double(zeros(sm,sn));
% KM=1;

sm=sm/block;
sn=sn/block;
vector_L=sm*sn;
th_vector=zeros(1,sm*sn);
tag=zeros(1,sm*sn);
sb=tag;
cb=tag;
t=zeros(block,block);
tc=zeros(block,block);
ts=tc;
k=0;
for i=1:sm
    for j=1:sn
       
     k=k+1;   
    tc=(c(block*(i-1)+1:block*i,block*(j-1)+1:block*j));
   ts=(s(block*(i-1)+1:block*i,block*(j-1)+1:block*j));
   [sb(k),mens(k)]=bis(ts);

    [cb(k),menc(k)]=bis(tc);
    end
end
q_sb=round(sb);
q_cb=round(cb);
 class_s=zeros(KM,vector_L/2+100);
 class_c=class_s;
 
 %%%%%*********kemans 
 [class_index,cls_L]=K_means(sb',KM);
 for i=1:KM
    class_s(i,1:length(class_index{i}))=class_index{i};
 end
 %%%%%*********kemans 
% [class_s,cls_L]=classfy_s(sb);%% cluster for secret image
class_c=classfy_c(cb,cls_L,KM);%% cluster for target image

k=0;
for i=1:KM
    for j=1:cls_L(i)
        %DELTA U    DONT ADD STRICTLY
      k=k+1;
       keyc=class_c(i,j);
        kcr=floor((keyc-1)/sn);
        kcc=mod(keyc-1,sn);
   
        keys=class_s(i,j);  
         ksr=floor((keys-1)/sn);
        ksc=mod(keys-1,sn);
           tag(keys)=i-1;  
      tc=(c(block*kcr+1:block*(kcr+1),block*kcc+1:block*(kcc+1)));
   ts=(s(block*ksr+1:block*(ksr+1),block*ksc+1:block*(ksc+1)));   
        
        
   th=round(mean(mean(tc))-mean(mean(ts)));
                      
   
                                t=ts+th;
                               %% modification for detal u to control overflow/underflow
                                if(max(t(:))>255)
                                        if((max(max(t))-255)<T)
                                           
                                       th=th-(max(max(t))-255);    
%                                        t=ts+th;
                                        else
                                            th=th-T;
                                        end
                                end
                                
                                if(min(t(:))<0)
                                       if ((0-min(min(t)))<T)
                                          
                                           th=th+(0-min(min(t)));    
%                                            t=ts+th;
                                       else
                                           th=th+T;
                                       end
                                end
                                
                                

%                                while (length(find(t(:)>255))+(length(find(t(:)<0)))>0)
%                                    t_liner=t(:);
%                          
%                                    if(length(find(t(:)>255))>0)
% 
%                                    pover=t_liner(find(t_liner>255));
%                                    th=th-(min(pover)-255);
%                                    end
%                                    
%                                    if(length(find(t(:)<0))>0)
%                                     punder=t_liner(find(t_liner<0));
%                                    th=th+(0-max(punder));
%                                    end
% 
%                                        t=ts+th;
%                                end  



                               
%                             while (max(t(:))>255||min(t(:))<0)
%                                 
%                                       if max(max(t))>255
%                                        th=th-(max(max(t))-255);                                   
%                                        end
% 
%                                        if min(min(t))<0                         
%                                            th=th+(0-min(min(t)));                                    
%                                        end
%                                   t=ts+th;
%                              end
                               
                         %%   quantization for detal u   SMALL
                       if th>0
                       th=8*round((th)/8);
                       end
                       
                         if th<0
                       th=8*floor(th/8)+4;
                         end
                t=ts+th;
                
                 th_vector(keys)=abs(th/4);
                 
   %% find optimal direction
  tt=t;                     
t1=uint8(t);
t1=double(t1);
b1=sum(sum((t1-tc).^2));

t2=rot90(t1,1);
b2=sum(sum((t2-tc).^2));

t3=rot90(t1,2);
b3=sum(sum((t3-tc).^2));

t4=rot90(t1,3);
b4=sum(sum((t4-tc).^2));
rot=0;  
bs=b1;

if b2<bs
    bs=b2;
   t=rot90(tt,1);
   rot=1;
end
    if b3<bs
    bs=b3;
    t=rot90(tt,2);
   rot=2;
    end
if b4<bs
    bs=b4;
   t=rot90(tt,3);
   rot=3;
end

rot_vector(keys)=rot;
   b(block*kcr+1:block*(kcr+1),block*kcc+1:block*(kcc+1))=t;
    end
end
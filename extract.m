function secret=extract(gim,mess)
[m,n]=size(gim);
secret=zeros(m,n/3,3);
L_rot=m*n/8;
start=1;
clc
 rot_stream(1:L_rot)=mess(1:L_rot);

start=start+L_rot;
L_rot=L_rot/2;
rot=reshape(rot_stream,L_rot,2);
rot_vector=bi2de(rot);
rot=reshape(rot_vector,3,L_rot/3);
ro=importdata('rot.mat');
sum(abs(rot(:)-ro(:)))
save rot rot;
%
num=m*n*5/16;
L_num=length(dec2bin(num));

L_stream(1:L_num)=mess(start:(start+L_num-1));

start=start+L_num;
L_place=bi2de(L_stream);


place_stream(1:L_place)=mess(start:(start+L_place-1));

start=start+L_place;

% place_vector=dehuffman(place_stream');
L_p=length(place_vector)/3;
place=reshape(place_vector,3,L_p);

tag=importdata('tag.mat');
sum(abs(place(:)-tag(:)))
save tag place;

%%%
fl=importdata('flow.mat');
num=m*n/2;
L_num=length(dec2bin(num));


L_stream(1:L_num)=mess(start:(start+L_num-1));

start=start+L_num;
L_place=bi2de(L_stream);

place_stream(1:L_place)=mess(start:(start+L_place-1));
flow=dehuffman(place_stream');
% sum(abs(fl(:)-flow(:)))
save flow flow;

% 
thh=importdata('th.mat');


L_th=(length(mess)-start+1);
th_stream(1:L_th)=mess(start:end);

th_vector=dehuffman(th_stream');
L_t=length(th_vector)/3;
th=reshape(th_vector,3,L_t);

 sum(abs(thh(:)-th(:)))
save th th;

for i=1:3
secret(:,:,i)=recover(gim(:,:,i),rot(i,:),place(i,:),th(i,:));
end

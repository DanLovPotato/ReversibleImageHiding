function val = RDH_endcoder(img,key)
%this function is used to embed a sequence of binary data into an image
%both row and column numbers must be even numbers

test_imgage = img;
img = test_imgage(:,:,1);
C_img = imread(img);
block_order = load('block_order.mat').block_order;
data = block_order(1,:);
P = length(data);

%1)Find all cells according to the Cross embedding scheme
pxls = C_img(2:end-1,2:end-1);
u = pxls(1:2:end); 
res = RDH_endcoder('man',0);

%2) For each cell compute: predicted value, prediction errors,local variance

N = length(u);
L_dots = C_img(2:2:2*N);
pxls = C_img(1:end,2:end);
T_dots = pxls(1:2:2*N);
B_dots = pxls(3:2:2*N);
pxls = C_img(1:end,3:end);
R_dots = pxls(2:2:2*N);

u_dash = floor((L_dots+B_dots+R_dots+T_dots)/4);
d = u-u_dash;

delta_v1 = abs(L_dots-T_dots); 
delta_v2 = abs(T_dots-R_dots); 
delta_v3 = abs(R_dots-B_dots); 
delta_v4 = abs(B_dots-L_dots);
delta_v_bar = (delta_v1+delta_v2+delta_v3+delta_v4)/4;
mu =((delta_v1-delta_v_bar).^2+(delta_v2-delta_v_bar).^2+(delta_v3-delta_v_bar).^2+(delta_v4-delta_v_bar).^2)/4;

%3) Sort cells according to the local variances and produce d_sort
[mu_sort,map]= sort(mu); 
d_sort = d(map);
S_LBS = d_sort(1:34); 

%4)Find appropriate threshold values Tn,Tp using payload size P
E = d_sort(35:P+35); 
Tp = max(E);
Tn = abs(min(E));

%5)create the location map L


end
i=imread('ԭĿ��ͼ��.bmp');

R=i(:,:,1);	
G=i(:,:,2);
B=i(:,:,3);
histogramR=imhist(R);
histogramG=imhist(G);
histogramB=imhist(B);

x=0:1:255;
figure('Name','ԭĿ��ͼ��'); 

plot(x,histogramR, 'r');%������ֱ��ͼ
fill([x,fliplr(x)],[zeros(size(histogramR')),fliplr(histogramR')],'r');		%�����ɫ
hold on
plot(x,histogramG, 'g');
fill([x,fliplr(x)],[zeros(size(histogramG')),fliplr(histogramG')],'g');
hold on
plot(x,histogramB, 'b');
fill([x,fliplr(x)],[zeros(size(histogramB')),fliplr(histogramB')],'b');








i=imread('pepper.bmp');

R=i(:,:,1);	
G=i(:,:,2);
B=i(:,:,3);
histogramR=imhist(R);
histogramG=imhist(G);
histogramB=imhist(B);

x=0:1:255;
figure('Name','����ͼ��'); 

plot(x,histogramR, 'r');%������ֱ��ͼ
fill([x,fliplr(x)],[zeros(size(histogramR')),fliplr(histogramR')],'r');		%�����ɫ
hold on
plot(x,histogramG, 'g');
fill([x,fliplr(x)],[zeros(size(histogramG')),fliplr(histogramG')],'g');
hold on
plot(x,histogramB, 'b');
fill([x,fliplr(x)],[zeros(size(histogramB')),fliplr(histogramB')],'b');









i=imread('��һ��.bmp');

R=i(:,:,1);	
G=i(:,:,2);
B=i(:,:,3);
histogramR=imhist(R);
histogramG=imhist(G);
histogramB=imhist(B);

x=0:1:255;
figure('Name','��һ������ͼ��'); 

plot(x,histogramR, 'r');%������ֱ��ͼ
fill([x,fliplr(x)],[zeros(size(histogramR')),fliplr(histogramR')],'r');		%�����ɫ
hold on
plot(x,histogramG, 'g');
fill([x,fliplr(x)],[zeros(size(histogramG')),fliplr(histogramG')],'g');
hold on
plot(x,histogramB, 'b');
fill([x,fliplr(x)],[zeros(size(histogramB')),fliplr(histogramB')],'b');

 




set(gcf,'color','w');
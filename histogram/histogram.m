i=imread('原目标图像.bmp');

R=i(:,:,1);	
G=i(:,:,2);
B=i(:,:,3);
histogramR=imhist(R);
histogramG=imhist(G);
histogramB=imhist(B);

x=0:1:255;
figure('Name','原目标图像'); 

plot(x,histogramR, 'r');%画连续直方图
fill([x,fliplr(x)],[zeros(size(histogramR')),fliplr(histogramR')],'r');		%填充颜色
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
figure('Name','秘密图像'); 

plot(x,histogramR, 'r');%画连续直方图
fill([x,fliplr(x)],[zeros(size(histogramR')),fliplr(histogramR')],'r');		%填充颜色
hold on
plot(x,histogramG, 'g');
fill([x,fliplr(x)],[zeros(size(histogramG')),fliplr(histogramG')],'g');
hold on
plot(x,histogramB, 'b');
fill([x,fliplr(x)],[zeros(size(histogramB')),fliplr(histogramB')],'b');









i=imread('第一轮.bmp');

R=i(:,:,1);	
G=i(:,:,2);
B=i(:,:,3);
histogramR=imhist(R);
histogramG=imhist(G);
histogramB=imhist(B);

x=0:1:255;
figure('Name','第一轮生成图像'); 

plot(x,histogramR, 'r');%画连续直方图
fill([x,fliplr(x)],[zeros(size(histogramR')),fliplr(histogramR')],'r');		%填充颜色
hold on
plot(x,histogramG, 'g');
fill([x,fliplr(x)],[zeros(size(histogramG')),fliplr(histogramG')],'g');
hold on
plot(x,histogramB, 'b');
fill([x,fliplr(x)],[zeros(size(histogramB')),fliplr(histogramB')],'b');

 




set(gcf,'color','w');
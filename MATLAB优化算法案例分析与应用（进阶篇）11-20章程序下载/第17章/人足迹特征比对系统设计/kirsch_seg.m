%% kirsch模板  方向算子
clc,clear,close all
warning off
[filename ,pathname]=...
    uigetfile({'*.bmp';'*.jpg';},'选择图片'); %选择图片路径
str = [pathname filename];%合成路径+文件名
im = imread(str);  % 读图   
% i= rgb2gray(im);
    hsi=rgb2hsi(im);
    H = hsi(:, :, 1);
    S = hsi(:, :, 2);
    I = hsi(:, :, 3);
    a= I; 
a = medfilt2(a,[5,5]);  % 中值滤波
b=[-5 3 3;-5 0 3;-5 3 3]/1512;
c=[3 3 3;-5 0 3;-5 -5 3]/1512; 
d=[3 3 3;3 0 3;-5 -5 -5]/1512;
e=[3 3 3;3 0 -5; 3 -5 -5]/1512; 
f=[3 3 -5;3 0 -5;3 3 -5]/1512;
g=[3 -5 -5;3 0 -5;3 3 3]/1512; 
h=[-5 -5 -5;3 0 3;3 3 3]/1512;
i=[-5 -5 3;-5 0 3;3 3 3]/1512; 
b=conv2(a,b,'same');b=abs(b);
c=conv2(a,c,'same');c=abs(c); 
d=conv2(a,d,'same');d=abs(d);
e=conv2(a,e,'same');e=abs(e);
f=conv2(a,f,'same');f=abs(f);
g=conv2(a,g,'same');g=abs(g); 
h=conv2(a,h,'same');h=abs(h);
i=conv2(a,i,'same');i=abs(i); 
p=max(b,c);
p=max(d,p);
p=max(e,p);
p=max(f,p);
p=max(g,p);
p=max(h,p);
p=max(i,p); 
figure,
subplot(2,4,1),imshow(b,[]),
subplot(2,4,2),imshow(c,[]),
subplot(2,4,3),imshow(d,[]),
subplot(2,4,4),imshow(e,[]),
subplot(2,4,5),imshow(f,[]),
subplot(2,4,6),imshow(g,[]), 
subplot(2,4,7),imshow(h,[]),
subplot(2,4,8),imshow(i,[])
figure,
subplot(121),imshow(im,[]);title('原始图像')
subplot(122),imshow(p,[]);title('kirsch模板')


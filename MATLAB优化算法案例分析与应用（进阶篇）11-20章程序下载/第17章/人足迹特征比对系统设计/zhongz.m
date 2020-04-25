clc,clear,close all
[filename ,pathname]=...
    uigetfile({'*.bmp';'*.jpg';},'选择图片'); %选择图片路径
str = [pathname filename];%合成路径+文件名
I = imread(str);%读图
obj=I;
r=obj(:,:,1);g=obj(:,:,2);b=obj(:,:,3);
objn=imnoise(g,'salt & pepper',0.04);%加入少许椒盐噪声
% figure,imshow(objn);title('加入椒盐噪声的图像');
K1=medfilt2(objn,[3,3]);%3x3模板中值滤波
K2=medfilt2(objn,[5,5]);%5x5模板中值滤波
% figure,imshow(K1);title('3x3模板中值滤波图像');
% figure,imshow(K2);title('5x5模板中值滤波图像');
subplot(121),imshow(g);title('R Plane 图像');
subplot(122),imshow(K2);title('5x5模板中值滤波图像');
%% 读取焊缝图像
clc,clear,close all
obj=imread('1.jpg');
r=obj(:,:,1);g=obj(:,:,2);b=obj(:,:,3);
%% 去噪中值滤波
objn=imnoise(g,'salt & pepper',0.04);%加入少许椒盐噪声
K1=medfilt2(objn,[3,3]);%3x3模板中值滤波
K2=medfilt2(objn,[5,5]);%5x5模板中值滤波
figure('color',[1,1,1])
subplot(121),imshow(objn);xlabel('加噪图像')
subplot(122),imshow(K1);xlabel('去噪图像')


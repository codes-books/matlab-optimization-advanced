%%
clc,clear,close all
[filename ,pathname]=...
    uigetfile({'*.bmp';'*.jpg';},'选择图片'); %选择图片路径
str = [pathname filename];%合成路径+文件名
I = imread(str);%读图
i=1;
I2=imadjust(I,[60/255,180/255],[0,1]);%图像增强--灰度级直接变换
figure(1),
subplot(121),imshow(I)
subplot(122),imhist(I(:,:,i))
figure(2),
subplot(121),imshow(I2)
subplot(122),imhist(I2(:,:,i))
clc,clear
close all;
[filename ,pathname]=...
    uigetfile({'*.bmp';'*.jpg';},'选择图片'); %选择图片路径
str = [pathname filename];%合成路径+文件名
rgb = imread(str);%读图
subplot(221),imshow(rgb);title('RGB')
gray = rgb2gray(rgb);
subplot(222),imshow(gray);title('RGB 2 Gray')
r = rgb(:,:,1);
g = rgb(:,:,2);
b = rgb(:,:,3);
subplot(234),imshow(r);title('R')
subplot(235),imshow(g);title('G')
subplot(236),imshow(b);title('B')



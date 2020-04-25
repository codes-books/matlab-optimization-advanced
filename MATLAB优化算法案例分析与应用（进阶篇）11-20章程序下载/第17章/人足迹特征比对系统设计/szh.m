%% 图像数字化
clc
clear
close all;
warning off
[filename ,pathname]=...
    uigetfile({'*.bmp';'*.jpg';},'选择图片'); %选择图片路径
str = [pathname filename];%合成路径+文件名
ps = imread(str);%读图
subplot(211),imshow(ps)
background=imopen(ps,strel('disk',4));
background=rgb2gray(background);
% imshow(background);
subplot(212),surf(double(background(1:4:end,1:4:end))),zlim([0 256]);
set(gca,'Ydir','reverse');
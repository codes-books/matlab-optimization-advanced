%% sobel算子
clc,clear,close all
[filename ,pathname]=...
    uigetfile({'*.bmp';'*.jpg';},'选择图片'); %选择图片路径
str = [pathname filename];%合成路径+文件名
im = imread(str);               %  读图
% i= rgb2gray(im);
    hsi=rgb2hsi(im);
    H = hsi(:, :, 1);
    S = hsi(:, :, 2);
    I = hsi(:, :, 3);
    i= I; 
i = medfilt2(i,[5,5]);  % 中值滤波
subplot(1,2,1);
imshow(im);title('原图像');     % 显示原图像
% m=fspecial('sobel');         % 应用sobel算子图像边缘检测
% j=filter2(m,i);              % sobel算子滤波锐化
j = edge(i,'sobel');
subplot(1,2,2);imshow(j);
title('sobel算子图像边缘检测');   % 显示sobel算子图像边缘检测

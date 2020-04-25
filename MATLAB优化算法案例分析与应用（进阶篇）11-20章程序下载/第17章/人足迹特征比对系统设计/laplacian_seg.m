%%  laplacian算子图像边缘检测
clc,clear,close all
[filename ,pathname]=...
    uigetfile({'*.bmp';'*.jpg';},'选择图片'); %选择图片路径
str = [pathname filename];%合成路径+文件名
i = imread(str);  % 读图   
% i= rgb2gray(im);
    hsi=rgb2hsi(i);
    H = hsi(:, :, 1);
    S = hsi(:, :, 2);
    I = hsi(:, :, 3);
    im= I; 
im = medfilt2(im,[5,5]);  % 中值滤波
subplot(1,2,1);
imshow(i);title('原图像');                     % 显示原图像
m=fspecial('laplacian');                       % 应用 laplacian算子图像边缘检测
j=filter2(m,im);                      %  laplacian算子滤波锐化
subplot(1,2,2);
imshow(j,[]);title(' laplacian算子图像边缘检测');  % 显示 laplacian算子图像边缘检测

%% 二阶微分运算
clc,clear,close all
im=imread('coloredChips.png');              % 读入图像
i= rgb2gray(im);
subplot(2,2,1);
imshow(im);title('原图像');          % 显示原图像
m=fspecial('laplacian');            % 应用 laplacian算子锐化图像
j=filter2(m,i);                     %  laplacian算子滤波锐化
subplot(2,2,2);
imshow(j);title(' laplacian算子锐化图像');  % 显示 laplacian算子锐化图像

subplot(2,2,3);
imshow(im);title('原图像');          % 显示原图像
m=fspecial('log');                  % 应用 log算子锐化图像
j=filter2(m,i);                     %  log算子滤波锐化
subplot(2,2,4);
imshow(j);title(' log算子锐化图像');  % 显示 log算子锐化图像

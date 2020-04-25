clc,clear,close all
warning off
im=imread('1.jpg');    % 读图
im_gray=rgb2gray(im);  % 转为灰度图像
R=im(:,:,1);G=im(:,:,2);B=im(:,:,3);
hsv_im=rgb2hsv(R,G,B); % RGB到HSV
subplot(121),subimage(im) % 显示图像
axis off
title('RGB')
subplot(122),subimage(hsv_im)
axis off
title('HSV')




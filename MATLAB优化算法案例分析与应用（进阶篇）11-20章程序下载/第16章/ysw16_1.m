clc,clear,close all
warning off
im=imread('1.jpg');    % ��ͼ
im_gray=rgb2gray(im);  % תΪ�Ҷ�ͼ��
R=im(:,:,1);G=im(:,:,2);B=im(:,:,3);
hsv_im=rgb2hsv(R,G,B); % RGB��HSV
subplot(121),subimage(im) % ��ʾͼ��
axis off
title('RGB')
subplot(122),subimage(hsv_im)
axis off
title('HSV')




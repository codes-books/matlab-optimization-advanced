clc,clear
close all;
[filename ,pathname]=...
    uigetfile({'*.bmp';'*.jpg';},'ѡ��ͼƬ'); %ѡ��ͼƬ·��
str = [pathname filename];%�ϳ�·��+�ļ���
rgb = imread(str);%��ͼ
subplot(221),imshow(rgb);title('RGB')
gray = rgb2gray(rgb);
subplot(222),imshow(gray);title('RGB 2 Gray')
r = rgb(:,:,1);
g = rgb(:,:,2);
b = rgb(:,:,3);
subplot(234),imshow(r);title('R')
subplot(235),imshow(g);title('G')
subplot(236),imshow(b);title('B')



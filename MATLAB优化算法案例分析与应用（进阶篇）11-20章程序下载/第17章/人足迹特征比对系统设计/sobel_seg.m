%% sobel����
clc,clear,close all
[filename ,pathname]=...
    uigetfile({'*.bmp';'*.jpg';},'ѡ��ͼƬ'); %ѡ��ͼƬ·��
str = [pathname filename];%�ϳ�·��+�ļ���
im = imread(str);               %  ��ͼ
% i= rgb2gray(im);
    hsi=rgb2hsi(im);
    H = hsi(:, :, 1);
    S = hsi(:, :, 2);
    I = hsi(:, :, 3);
    i= I; 
i = medfilt2(i,[5,5]);  % ��ֵ�˲�
subplot(1,2,1);
imshow(im);title('ԭͼ��');     % ��ʾԭͼ��
% m=fspecial('sobel');         % Ӧ��sobel����ͼ���Ե���
% j=filter2(m,i);              % sobel�����˲���
j = edge(i,'sobel');
subplot(1,2,2);imshow(j);
title('sobel����ͼ���Ե���');   % ��ʾsobel����ͼ���Ե���

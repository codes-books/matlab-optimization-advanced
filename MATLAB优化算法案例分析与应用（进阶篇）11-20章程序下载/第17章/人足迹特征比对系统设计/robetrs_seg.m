%% Roberts����
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
imshow(im);title('ԭͼ��');              % ��ʾԭͼ�� 
j = edge(i,'Roberts') ;                   % Ӧ��Roberts����ͼ���Ե���
subplot(1,2,2); 
imshow(j); title('Roberts����ͼ���Ե���'); % ��ʾRoberts����ͼ���Ե���




%%  laplacian����ͼ���Ե���
clc,clear,close all
[filename ,pathname]=...
    uigetfile({'*.bmp';'*.jpg';},'ѡ��ͼƬ'); %ѡ��ͼƬ·��
str = [pathname filename];%�ϳ�·��+�ļ���
i = imread(str);  % ��ͼ   
% i= rgb2gray(im);
    hsi=rgb2hsi(i);
    H = hsi(:, :, 1);
    S = hsi(:, :, 2);
    I = hsi(:, :, 3);
    im= I; 
im = medfilt2(im,[5,5]);  % ��ֵ�˲�
subplot(1,2,1);
imshow(i);title('ԭͼ��');                     % ��ʾԭͼ��
m=fspecial('laplacian');                       % Ӧ�� laplacian����ͼ���Ե���
j=filter2(m,im);                      %  laplacian�����˲���
subplot(1,2,2);
imshow(j,[]);title(' laplacian����ͼ���Ե���');  % ��ʾ laplacian����ͼ���Ե���

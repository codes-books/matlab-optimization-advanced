clc,clear,close all
[filename ,pathname]=...
    uigetfile({'*.bmp';'*.jpg';},'ѡ��ͼƬ'); %ѡ��ͼƬ·��
str = [pathname filename];%�ϳ�·��+�ļ���
I = imread(str);%��ͼ
obj=I;
r=obj(:,:,1);g=obj(:,:,2);b=obj(:,:,3);
objn=imnoise(g,'salt & pepper',0.04);%��������������
% figure,imshow(objn);title('���뽷��������ͼ��');
K1=medfilt2(objn,[3,3]);%3x3ģ����ֵ�˲�
K2=medfilt2(objn,[5,5]);%5x5ģ����ֵ�˲�
% figure,imshow(K1);title('3x3ģ����ֵ�˲�ͼ��');
% figure,imshow(K2);title('5x5ģ����ֵ�˲�ͼ��');
subplot(121),imshow(g);title('R Plane ͼ��');
subplot(122),imshow(K2);title('5x5ģ����ֵ�˲�ͼ��');
%% ��ȡ����ͼ��
clc,clear,close all
obj=imread('1.jpg');
r=obj(:,:,1);g=obj(:,:,2);b=obj(:,:,3);
%% ȥ����ֵ�˲�
objn=imnoise(g,'salt & pepper',0.04);%��������������
K1=medfilt2(objn,[3,3]);%3x3ģ����ֵ�˲�
K2=medfilt2(objn,[5,5]);%5x5ģ����ֵ�˲�
figure('color',[1,1,1])
subplot(121),imshow(objn);xlabel('����ͼ��')
subplot(122),imshow(K1);xlabel('ȥ��ͼ��')


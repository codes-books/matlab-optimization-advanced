%%
clc,clear,close all
[filename ,pathname]=...
    uigetfile({'*.bmp';'*.jpg';},'ѡ��ͼƬ'); %ѡ��ͼƬ·��
str = [pathname filename];%�ϳ�·��+�ļ���
I = imread(str);%��ͼ
i=1;
I2=imadjust(I,[60/255,180/255],[0,1]);%ͼ����ǿ--�Ҷȼ�ֱ�ӱ任
figure(1),
subplot(121),imshow(I)
subplot(122),imhist(I(:,:,i))
figure(2),
subplot(121),imshow(I2)
subplot(122),imhist(I2(:,:,i))
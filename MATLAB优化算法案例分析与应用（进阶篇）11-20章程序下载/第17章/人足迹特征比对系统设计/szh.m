%% ͼ�����ֻ�
clc
clear
close all;
warning off
[filename ,pathname]=...
    uigetfile({'*.bmp';'*.jpg';},'ѡ��ͼƬ'); %ѡ��ͼƬ·��
str = [pathname filename];%�ϳ�·��+�ļ���
ps = imread(str);%��ͼ
subplot(211),imshow(ps)
background=imopen(ps,strel('disk',4));
background=rgb2gray(background);
% imshow(background);
subplot(212),surf(double(background(1:4:end,1:4:end))),zlim([0 256]);
set(gca,'Ydir','reverse');
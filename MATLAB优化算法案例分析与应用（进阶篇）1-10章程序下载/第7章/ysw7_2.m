% ���άͼ�η���ά��
clc        % ����
clear all; % ɾ��workplace����
close all; % �ص���ʾͼ�δ���
% Read the image
[sFileName,sPath]=uigetfile('*.*','Load Image');
sFullFileName=[sPath,sFileName];
im = imread(sFullFileName);
im1 =imresize(im,[32 32]);  % ͼ��ѹ�����ߴ絽32*32���ߴ�̫��PC����̫��
im1(:,:,1) = medfilt2(im1(:,:,1),[3,2]);   % ��ֵ�˲�
im1(:,:,2) = medfilt2(im1(:,:,2),[3,2]);   % ��ֵ�˲�
im1(:,:,3) = medfilt2(im1(:,:,3),[3,2]);   % ��ֵ�˲�
D = myfractal(im1);         % wait a long time
disp(['����ά��Ϊ:   ',num2str(D)])


% 求二维图形分形维数
clc        % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口
% Read the image
[sFileName,sPath]=uigetfile('*.*','Load Image');
sFullFileName=[sPath,sFileName];
im = imread(sFullFileName);
im1 =imresize(im,[32 32]);  % 图像压缩到尺寸到32*32，尺寸太大，PC运算太慢
im1(:,:,1) = medfilt2(im1(:,:,1),[3,2]);   % 中值滤波
im1(:,:,2) = medfilt2(im1(:,:,2),[3,2]);   % 中值滤波
im1(:,:,3) = medfilt2(im1(:,:,3),[3,2]);   % 中值滤波
D = myfractal(im1);         % wait a long time
disp(['分形维数为:   ',num2str(D)])


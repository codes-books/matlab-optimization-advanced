%% 多算子融合
clc,clear,close all
warning off
[filename ,pathname]=...
    uigetfile({'*.bmp';'*.jpg';},'选择图片'); %选择图片路径
str = [pathname filename];%合成路径+文件名
im = imread(str);               %  读图
if size(im,3)==1
    a=im;
else
    hsi=rgb2hsi(im);
    H = hsi(:, :, 1);
    S = hsi(:, :, 2);
    I = hsi(:, :, 3);
    a= I; 
%     a= rgb2gray(im);
end
a = medfilt2(a,[5,5]);  % 中值滤波
b = edge(a,'sobel');    %% sobel算子
c = edge(a,'prewitt');  %% prewitt算子
d = edge(a,'canny') ;   %% canny算子
e = edge(a,'Roberts') ; %% Roberts算子
f = kirsch_algorithm(a); %% kirsch方向算子
p=max(b,c);
p=min(d,p);
p=max(e,p);
p=max(f,p);
figure,
subplot(2,3,1),imshow(im);title('原始图像')
subplot(2,3,2),imshow(b);title('sobel算子')
subplot(2,3,3),imshow(c);title('prewitt算子')
subplot(2,3,4),imshow(d);title('canny算子')
subplot(2,3,5),imshow(e);title('Roberts算子')
subplot(2,3,6),imshow(f);title('kirsch方向算子')
figure,
subplot(121),imshow(im);title('原始图像')
subplot(122),imshow(p);title('多算子融合')


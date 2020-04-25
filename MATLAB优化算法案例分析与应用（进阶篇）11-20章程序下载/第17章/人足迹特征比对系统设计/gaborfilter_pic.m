clc,clear,close all
[filename ,pathname]=...
    uigetfile({'*.bmp';'*.jpg';},'选择图片'); %选择图片路径
str = [pathname filename];%合成路径+文件名
I = imread(str);%读图
obj=I;
r=obj(:,:,1);g=obj(:,:,2);b=obj(:,:,3);
% 转化为灰度图像
if size(I,3)==1
    im = I;
else
    im = rgb2gray(I);
end
[G,gabout] = gaborfilter(im,0.5,0.5,1,1);
figure,
subplot(121),imshow(g);title('灰度图像');
subplot(122),imshow(gabout,[]);title('Gagor滤波图像')

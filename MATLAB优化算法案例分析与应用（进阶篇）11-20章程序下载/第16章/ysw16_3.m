clc,clear,close all
warning off
im=imread('1.jpg');    % 读图
im_gray=rgb2gray(im);  % 转为灰度图像
R=im(:,:,1);G=im(:,:,2);B=im(:,:,3);
ycrcb_im =  rgb2ycrcb(R,G,B);
ycrcb_im = im2uint8(ycrcb_im);
Cr = ycrcb_im(:,:,2);
Cb = ycrcb_im(:,:,3);
bw = zeros(size(R,1),size(R,2));  % 初始化矩阵
for i =1:size(R,1)
    for j=1:size(R,2)
        if Cr(i,j)>=105&&Cr(i,j)<=118 && Cb(i,j)>=105&&Cb(i,j)<=162
            bw(i,j)=1;
        else
            bw(i,j)=0;
        end
    end
end
subplot(121),subimage(ycrcb_im) % 显示图像
axis off
title('YCrCb')
subplot(122),subimage(bw)
axis off
title('BW')
   
% 合成RGB颜色空间
r = im(:, :, 1);  % R通道
g = im(:, :, 2);  % G通道
b = im(:, :, 3);  % B通道
bw = im2bw(bw);
r1=immultiply(r,bw);  % 交运算
g1=immultiply(g,bw);  % 交运算
b1=immultiply(b,bw);  % 交运算
pic=cat(3,r1,g1,b1);    % 合成3-D
figure,
subplot(121),subimage(im) % 显示图像
axis off
subplot(122),subimage(pic)



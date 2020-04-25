clc,clear,close all
warning off
im=imread('1.jpg');    % ��ͼ
im_gray=rgb2gray(im);  % תΪ�Ҷ�ͼ��
R=im(:,:,1);G=im(:,:,2);B=im(:,:,3);
ycrcb_im =  rgb2ycrcb(R,G,B);
ycrcb_im = im2uint8(ycrcb_im);
Cr = ycrcb_im(:,:,2);
Cb = ycrcb_im(:,:,3);
bw = zeros(size(R,1),size(R,2));  % ��ʼ������
for i =1:size(R,1)
    for j=1:size(R,2)
        if Cr(i,j)>=105&&Cr(i,j)<=118 && Cb(i,j)>=105&&Cb(i,j)<=162
            bw(i,j)=1;
        else
            bw(i,j)=0;
        end
    end
end
subplot(121),subimage(ycrcb_im) % ��ʾͼ��
axis off
title('YCrCb')
subplot(122),subimage(bw)
axis off
title('BW')
   
% �ϳ�RGB��ɫ�ռ�
r = im(:, :, 1);  % Rͨ��
g = im(:, :, 2);  % Gͨ��
b = im(:, :, 3);  % Bͨ��
bw = im2bw(bw);
r1=immultiply(r,bw);  % ������
g1=immultiply(g,bw);  % ������
b1=immultiply(b,bw);  % ������
pic=cat(3,r1,g1,b1);    % �ϳ�3-D
figure,
subplot(121),subimage(im) % ��ʾͼ��
axis off
subplot(122),subimage(pic)



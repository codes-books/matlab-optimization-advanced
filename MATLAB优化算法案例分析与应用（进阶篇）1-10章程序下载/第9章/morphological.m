%% 颜色特征提取
clc,clear,close all
I=imread('1.jpg');
r=I(:,:,1);
g=I(:,:,2);
b=I(:,:,3);
HF1=b-g*0.0-r*0.70;
% imshow(HF1)
HF2=HF1 > 55;
% imshow(HF2)
% colormap(gray);
HF2=bwareaopen(HF2,1000);
% figure(1),imagesc(HF2)
cc=bwconncomp(HF2);
s  = regionprops(HF2, {'centroid','area'});
HF2(labelmatrix(cc)~=2)=0;
HF2=imfill(HF2,'holes');
se=strel('disk',5);
HF2=imdilate(HF2,se); % dilate
HF2=imerode(HF2,se);  % erode
% imshow(HF2)
%%
r1=immultiply(r,HF2);
g1=immultiply(g,HF2);
b1=immultiply(b,HF2);
HF3=cat(3,r1,g1,b1);
%%
subplot(131),imshow(I);title('original pic')
subplot(132),imshow(HF2);title('bw pic')
subplot(133),imshow(HF3);axis tight
title('morphological edge detection')
set(gca,'xtick',[]);set(gca,'ytick',[]);


clc,clear,close all
warning off
feature jit off       % 加速代码执行，提高运行时间
rgb=imread('xbb.jpg');  % 加载图像
% imshow(rgb);
r = rgb(:, :, 1);  % R通道
g = rgb(:, :, 2);  % G通道
b = rgb(:, :, 3);  % B通道
[m,n]=size(r);
cform = makecform('srgb2lab'); % color transformation structure
J = applycform(rgb,cform);     % color space transformation
M=graythresh(J(:,:,3));        % 阈值
BW2=im2bw(J(:,:,3),M);         %二值化
BW2= bwareaopen(BW2, 300);     %剔除小块
% imshow(BW2)
cc=bwconncomp(BW2);            % 连通性检查
s  = regionprops(BW2, {'centroid','area'});  %标记块重心
[~, id] = max([s.Area]);     % 找出最大块的标号
BW2(labelmatrix(cc)~=id)=0;  % 非最大块置为背景
r1=immultiply(r,~BW2);  % 交运算
g1=immultiply(g,~BW2);  % 交运算
b1=immultiply(b,~BW2);  % 交运算
xbb=cat(3,r1,g1,b1);    % 合成3-D
figure;imshow(xbb);     % 显示
%%
for i=1:m
    for j=1:n
      if (r1(i,j)>=145&&r1(i,j)<=255)&&(g1(i,j)>=50&&g1(i,j)<=255)&&(b1(i,j)>=20&&b1(i,j)<=220)%改皮肤色
            r1(i,j)=150;g1(i,j)=250;b1(i,j)=250;
      end
      if (r1(i,j)>=240&&r1(i,j)<=255)&&(g1(i,j)>=240&&g1(i,j)<=255)&&(b1(i,j)>=220&&b1(i,j)<=255)%改背景白色
            r1(i,j)=255;g1(i,j)=0;b1(i,j)=255;
      end
      if (r1(i,j)>=0&&r1(i,j)<=2)&&(g1(i,j)>=0&&g1(i,j)<=2)&&(b1(i,j)>=0&&b1(i,j)<=2)%改背景黑色
            r1(i,j)=200;g1(i,j)=255;b1(i,j)=0;
      end
      if (r1(i,j)>=0&&r1(i,j)<=170)&&(g1(i,j)>=0&&g1(i,j)<=172)&&(b1(i,j)>=0&&b1(i,j)<=180)%改头发黑色
            r1(i,j)=120;g1(i,j)=155;b1(i,j)=255;
      end
    end
end
color11=cat(3,r1,g1,b1);
subplot(121),imshow(rgb);title('原始图像')
subplot(122),imshow(color11);title('分割后图像')
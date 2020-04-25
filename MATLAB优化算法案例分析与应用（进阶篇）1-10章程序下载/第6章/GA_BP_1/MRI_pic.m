function im_sep= MRI_pic(num)
% num： data文件中的切片图像的第num张MRI图像
% im_sep : 分解出来的大脑组织
%% 大脑头像预处理
% clc,clear,close all
warning off
load('data.mat');       % 加载MRI图像数据,整个头颅图像
% 从13 - 31   （32-44取反）
if num <13 || num>31
    msgbox('num数字不对！num在13-31之间！！！');
else
    
im_org = data(:,:,num);  % 第 i 帧图像
% figure,imshow(im_org);title('原始图像');  % 显示原图像
max_level = double(max(data(:))); 
if size(im_org,3)==1
    im = im_org;
else
    im = rgb2gray(im_org);
end
% figure,imshow(im);title('切片伪彩色图像');  % 显示伪彩色图像
% colorbar       % 插入颜色栏
% colormap jet   % change colormap

%%
im = permute(im,[3 2 1]); % 重置矩阵的维数
for i=1:3
    im = flipdim(im,i);
end
im(im<=40/255) = 0;       % 剔除灰度值低的部分（脑袋和背景）
im(im>=100/255) = 0;      % 剔除灰度值高的部分（颅骨和其他的组织）
im(:,:,1) = 0;            % 剔除大脑灰白质下面的部分灰度部分
blk = ones([1 7 7]);      % 块操作
% im = imerode(im,blk);   % 腐蚀
% 分离大脑脑组织
lev = graythresh(double(im)/max_level) * max_level;  % 阈值
bw = (im>=lev);                % 二值化
bw = imrotate(squeeze(bw),90); % 变异复原
% 去掉小块
cc=bwconncomp(bw);                          % 连通域操作
s  = regionprops(bw, {'centroid','area'});  % 标记中心
[A, id] = max([s.Area]);
bw(labelmatrix(cc)~=id)=0;
bw = imdilate(bw,blk);         % 膨胀
im_sep = immultiply(im_org,bw);
% figure,imshow(im_sep);title('seperate brain,gray matter and white matter')

%% 大脑灰白质提取
% lev2 = 50/255;  % 阈值
% L = zeros(size(im_sep));          %0=背景
% L(im_sep<lev2 & im_sep>0) = 2;    %2=灰质
% L(im_sep>=lev2) = 3;              %3=白质
% L = mat2gray(L);
% figure,imshow(L);title('灰白质分割图')
%%
% edge_L = edge_ysw(L);  % 边缘分割
% figure,imshow(edge_L);title('灰白质边缘检测图')
%%
end
end

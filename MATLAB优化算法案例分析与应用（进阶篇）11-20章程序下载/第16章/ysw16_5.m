clc,clear,close all
warning off
imaqmem(7e08);   % 申请内存空间
waitopen;
feature jit off       % 加速代码执行，提高运行时间

vid = videoinput('winvideo',1,'YUY2_320x240');  %摄像头参数
% Set the properties of the video object
set(vid, 'FramesPerTrigger', Inf);    % 帧触发器设置 
set(vid, 'ReturnedColorspace', 'rgb') % RGB颜色空间
vid.FrameGrabInterval = 5;            % 帧数间隔
% 启动摄像头设备
start(vid)
% 采集100帧后，接触循环
while(vid.FramesAcquired<=100)

data = getsnapshot(vid);  % 拍摄图像
diff_im = imsubtract(data(:,:,1), rgb2gray(data)); % 做差
diff_im = medfilt2(diff_im, [3 3]);                % 中值滤波
diff_im = imadjust(diff_im);                       % 自适应直方图处理
level = graythresh(diff_im);                       % 求全局阈值
bw = im2bw(diff_im,level);                         % 二值化处理
BW5 = imfill(bw,'holes');                          % 填充空洞
bw6 = bwlabel(BW5, 8);                             % 标记二值化图
stats = regionprops(bw6,['basic']);                 % 连通域处理basic mohem nist
[N,M]=size(stats);
if (bw==0)         % 如果和背景相当，无移动目标
     break;
else
     tmp = stats(1);
for i = 2 : N
    if stats(i).Area > tmp.Area  % 面积比较
        tmp = stats(i);
    end
end
bb = tmp.BoundingBox; % 画识别物体方框
bc = tmp.Centroid;    % 物体中心

imshow(data)   %　画图
hold on
rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
hold off
end
end

stop(vid);       % 停止
flushdata(vid);  % 清楚缓存数据

% 清楚所有的变量
clear all

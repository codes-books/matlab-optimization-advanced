clc,clear,close all
warning off
feature jit off       % 加速代码执行，提高运行时间

Ima=imread('1.jpg');                 %% 读入图象
RIma=Ima(:,:,1);GIma=Ima(:,:,2);BIma=Ima(:,:,3);
HSVIma = rgb2hsv(Ima);                    %% 转换图象格式
H = HSVIma(:,:,1);                     %% 提取色相图象
V = HSVIma(:,:,3);                     %% 提取明亮度图象
%%
figure('color',[1,1,1])
subplot(2,2,1),imshow(Ima);title('输入的检测皮肤的图象');
subplot(2,2,2),imshow(H);title('色度H分量')
subplot(2,2,3),imshow(V);title('亮度V分量')
H1 = im2bw(H,0.16);      % 二值化
H1 = ~H1;                % 取反操作
H1 = bwareaopen(H1,100);  % 剔除小块
subplot(2,2,4),imshow(H1);title('人肤色分割')

%%
R = immultiply(RIma,H1);  % 交运算
G = immultiply(GIma,H1);  % 交运算
B = immultiply(BIma,H1);  % 交运算
im = cat(3,R,G,B);        % 合成3-D数组
figure('color',[1,1,1])
subplot(1,2,1),imshow(Ima);title('输入的检测皮肤的图象');
subplot(1,2,2),imshow(im);title('输出的检测皮肤的图象');


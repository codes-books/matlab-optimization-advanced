% 图像边缘纹理处理
% 提取每幅图像研究位置的坐标，保持在eyelocs
clc,clear;close all
warning off
geshi = { '*.bmp','Bitmap image (*.bmp)';...
         '*.jpg','JPEG image (*.jpg)';...
       '*.*','All Files (*.*)'};
[FileName FilePath] = uigetfile(geshi,'导入外部数据',...
'*.bmp','MultiSelect','on');% 选中所有的图片
% 如果选择了图片文件，生成图片文件的完整路径，否则退出程序，不再运行后面命令
if ~isequal([FileName,FilePath],[0,0]);
    FileFullName = strcat(FilePath,FileName);
else
    return;
end
n = length(FileFullName);  % 选择的图片文件个数
for i = 1 : n
    irow=[];icol=[];img=[];
    % 依次读取每一张图片
    im = imread(FileFullName{i}); % 读取图像
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
    p = im2bw(p);
    [y,x] = find(p == 1);
    obj = p(min(y):max(y),min(x):max(x),:);
    obj = imresize(obj,[250,120]);
    imwrite(obj,strcat('.\bw_pic_corr\',num2str(i),'.bmp'),'bmp');
end
    
    
    
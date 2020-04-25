% ͼ���Ե������
% ��ȡÿ��ͼ���о�λ�õ����꣬������eyelocs
clc,clear;close all
warning off
geshi = { '*.bmp','Bitmap image (*.bmp)';...
         '*.jpg','JPEG image (*.jpg)';...
       '*.*','All Files (*.*)'};
[FileName FilePath] = uigetfile(geshi,'�����ⲿ����',...
'*.bmp','MultiSelect','on');% ѡ�����е�ͼƬ
% ���ѡ����ͼƬ�ļ�������ͼƬ�ļ�������·���������˳����򣬲������к�������
if ~isequal([FileName,FilePath],[0,0]);
    FileFullName = strcat(FilePath,FileName);
else
    return;
end
n = length(FileFullName);  % ѡ���ͼƬ�ļ�����
for i = 1 : n
    irow=[];icol=[];img=[];
    % ���ζ�ȡÿһ��ͼƬ
    im = imread(FileFullName{i}); % ��ȡͼ��
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
    a = medfilt2(a,[5,5]);  % ��ֵ�˲�
    b = edge(a,'sobel');    %% sobel����
    c = edge(a,'prewitt');  %% prewitt����
    d = edge(a,'canny') ;   %% canny����
    e = edge(a,'Roberts') ; %% Roberts����
    f = kirsch_algorithm(a); %% kirsch��������
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
    
    
    
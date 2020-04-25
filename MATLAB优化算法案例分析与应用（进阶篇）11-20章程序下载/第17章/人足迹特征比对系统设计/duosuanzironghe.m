%% �������ں�
clc,clear,close all
warning off
[filename ,pathname]=...
    uigetfile({'*.bmp';'*.jpg';},'ѡ��ͼƬ'); %ѡ��ͼƬ·��
str = [pathname filename];%�ϳ�·��+�ļ���
im = imread(str);               %  ��ͼ
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
figure,
subplot(2,3,1),imshow(im);title('ԭʼͼ��')
subplot(2,3,2),imshow(b);title('sobel����')
subplot(2,3,3),imshow(c);title('prewitt����')
subplot(2,3,4),imshow(d);title('canny����')
subplot(2,3,5),imshow(e);title('Roberts����')
subplot(2,3,6),imshow(f);title('kirsch��������')
figure,
subplot(121),imshow(im);title('ԭʼͼ��')
subplot(122),imshow(p);title('�������ں�')


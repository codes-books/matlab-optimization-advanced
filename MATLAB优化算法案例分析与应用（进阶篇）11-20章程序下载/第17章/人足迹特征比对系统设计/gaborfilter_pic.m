clc,clear,close all
[filename ,pathname]=...
    uigetfile({'*.bmp';'*.jpg';},'ѡ��ͼƬ'); %ѡ��ͼƬ·��
str = [pathname filename];%�ϳ�·��+�ļ���
I = imread(str);%��ͼ
obj=I;
r=obj(:,:,1);g=obj(:,:,2);b=obj(:,:,3);
% ת��Ϊ�Ҷ�ͼ��
if size(I,3)==1
    im = I;
else
    im = rgb2gray(I);
end
[G,gabout] = gaborfilter(im,0.5,0.5,1,1);
figure,
subplot(121),imshow(g);title('�Ҷ�ͼ��');
subplot(122),imshow(gabout,[]);title('Gagor�˲�ͼ��')

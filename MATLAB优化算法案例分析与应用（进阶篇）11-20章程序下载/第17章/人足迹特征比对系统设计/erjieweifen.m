%% ����΢������
clc,clear,close all
im=imread('coloredChips.png');              % ����ͼ��
i= rgb2gray(im);
subplot(2,2,1);
imshow(im);title('ԭͼ��');          % ��ʾԭͼ��
m=fspecial('laplacian');            % Ӧ�� laplacian������ͼ��
j=filter2(m,i);                     %  laplacian�����˲���
subplot(2,2,2);
imshow(j);title(' laplacian������ͼ��');  % ��ʾ laplacian������ͼ��

subplot(2,2,3);
imshow(im);title('ԭͼ��');          % ��ʾԭͼ��
m=fspecial('log');                  % Ӧ�� log������ͼ��
j=filter2(m,i);                     %  log�����˲���
subplot(2,2,4);
imshow(j);title(' log������ͼ��');  % ��ʾ log������ͼ��

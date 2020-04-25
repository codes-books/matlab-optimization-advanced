clc,clear,close all
warning off
feature jit off       % ���ٴ���ִ�У��������ʱ��

Ima=imread('1.jpg');                 %% ����ͼ��
RIma=Ima(:,:,1);GIma=Ima(:,:,2);BIma=Ima(:,:,3);
HSVIma = rgb2hsv(Ima);                    %% ת��ͼ���ʽ
H = HSVIma(:,:,1);                     %% ��ȡɫ��ͼ��
V = HSVIma(:,:,3);                     %% ��ȡ������ͼ��
%%
figure('color',[1,1,1])
subplot(2,2,1),imshow(Ima);title('����ļ��Ƥ����ͼ��');
subplot(2,2,2),imshow(H);title('ɫ��H����')
subplot(2,2,3),imshow(V);title('����V����')
H1 = im2bw(H,0.16);      % ��ֵ��
H1 = ~H1;                % ȡ������
H1 = bwareaopen(H1,100);  % �޳�С��
subplot(2,2,4),imshow(H1);title('�˷�ɫ�ָ�')

%%
R = immultiply(RIma,H1);  % ������
G = immultiply(GIma,H1);  % ������
B = immultiply(BIma,H1);  % ������
im = cat(3,R,G,B);        % �ϳ�3-D����
figure('color',[1,1,1])
subplot(1,2,1),imshow(Ima);title('����ļ��Ƥ����ͼ��');
subplot(1,2,2),imshow(im);title('����ļ��Ƥ����ͼ��');


clc,clear,close all
warning off
feature jit off       % ���ٴ���ִ�У��������ʱ��
rgb=imread('xbb.jpg');  % ����ͼ��
% imshow(rgb);
r = rgb(:, :, 1);  % Rͨ��
g = rgb(:, :, 2);  % Gͨ��
b = rgb(:, :, 3);  % Bͨ��
[m,n]=size(r);
cform = makecform('srgb2lab'); % color transformation structure
J = applycform(rgb,cform);     % color space transformation
M=graythresh(J(:,:,3));        % ��ֵ
BW2=im2bw(J(:,:,3),M);         %��ֵ��
BW2= bwareaopen(BW2, 300);     %�޳�С��
% imshow(BW2)
cc=bwconncomp(BW2);            % ��ͨ�Լ��
s  = regionprops(BW2, {'centroid','area'});  %��ǿ�����
[~, id] = max([s.Area]);     % �ҳ�����ı��
BW2(labelmatrix(cc)~=id)=0;  % ��������Ϊ����
r1=immultiply(r,~BW2);  % ������
g1=immultiply(g,~BW2);  % ������
b1=immultiply(b,~BW2);  % ������
xbb=cat(3,r1,g1,b1);    % �ϳ�3-D
figure;imshow(xbb);     % ��ʾ
%%
for i=1:m
    for j=1:n
      if (r1(i,j)>=145&&r1(i,j)<=255)&&(g1(i,j)>=50&&g1(i,j)<=255)&&(b1(i,j)>=20&&b1(i,j)<=220)%��Ƥ��ɫ
            r1(i,j)=150;g1(i,j)=250;b1(i,j)=250;
      end
      if (r1(i,j)>=240&&r1(i,j)<=255)&&(g1(i,j)>=240&&g1(i,j)<=255)&&(b1(i,j)>=220&&b1(i,j)<=255)%�ı�����ɫ
            r1(i,j)=255;g1(i,j)=0;b1(i,j)=255;
      end
      if (r1(i,j)>=0&&r1(i,j)<=2)&&(g1(i,j)>=0&&g1(i,j)<=2)&&(b1(i,j)>=0&&b1(i,j)<=2)%�ı�����ɫ
            r1(i,j)=200;g1(i,j)=255;b1(i,j)=0;
      end
      if (r1(i,j)>=0&&r1(i,j)<=170)&&(g1(i,j)>=0&&g1(i,j)<=172)&&(b1(i,j)>=0&&b1(i,j)<=180)%��ͷ����ɫ
            r1(i,j)=120;g1(i,j)=155;b1(i,j)=255;
      end
    end
end
color11=cat(3,r1,g1,b1);
subplot(121),imshow(rgb);title('ԭʼͼ��')
subplot(122),imshow(color11);title('�ָ��ͼ��')
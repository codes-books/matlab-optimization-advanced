clc,clear,close all
warning off
imaqmem(7e08);   % �����ڴ�ռ�
waitopen;
feature jit off       % ���ٴ���ִ�У��������ʱ��

vid = videoinput('winvideo',1,'YUY2_320x240');  %����ͷ����
% Set the properties of the video object
set(vid, 'FramesPerTrigger', Inf);    % ֡���������� 
set(vid, 'ReturnedColorspace', 'rgb') % RGB��ɫ�ռ�
vid.FrameGrabInterval = 5;            % ֡�����
% ��������ͷ�豸
start(vid)
% �ɼ�100֡�󣬽Ӵ�ѭ��
while(vid.FramesAcquired<=100)

data = getsnapshot(vid);  % ����ͼ��
diff_im = imsubtract(data(:,:,1), rgb2gray(data)); % ����
diff_im = medfilt2(diff_im, [3 3]);                % ��ֵ�˲�
diff_im = imadjust(diff_im);                       % ����Ӧֱ��ͼ����
level = graythresh(diff_im);                       % ��ȫ����ֵ
bw = im2bw(diff_im,level);                         % ��ֵ������
BW5 = imfill(bw,'holes');                          % ���ն�
bw6 = bwlabel(BW5, 8);                             % ��Ƕ�ֵ��ͼ
stats = regionprops(bw6,['basic']);                 % ��ͨ����basic mohem nist
[N,M]=size(stats);
if (bw==0)         % ����ͱ����൱�����ƶ�Ŀ��
     break;
else
     tmp = stats(1);
for i = 2 : N
    if stats(i).Area > tmp.Area  % ����Ƚ�
        tmp = stats(i);
    end
end
bb = tmp.BoundingBox; % ��ʶ�����巽��
bc = tmp.Centroid;    % ��������

imshow(data)   %����ͼ
hold on
rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
hold off
end
end

stop(vid);       % ֹͣ
flushdata(vid);  % �����������

% ������еı���
clear all

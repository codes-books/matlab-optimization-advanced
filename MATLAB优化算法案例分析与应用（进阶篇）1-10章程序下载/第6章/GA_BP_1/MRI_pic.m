function im_sep= MRI_pic(num)
% num�� data�ļ��е���Ƭͼ��ĵ�num��MRIͼ��
% im_sep : �ֽ�����Ĵ�����֯
%% ����ͷ��Ԥ����
% clc,clear,close all
warning off
load('data.mat');       % ����MRIͼ������,����ͷ­ͼ��
% ��13 - 31   ��32-44ȡ����
if num <13 || num>31
    msgbox('num���ֲ��ԣ�num��13-31֮�䣡����');
else
    
im_org = data(:,:,num);  % �� i ֡ͼ��
% figure,imshow(im_org);title('ԭʼͼ��');  % ��ʾԭͼ��
max_level = double(max(data(:))); 
if size(im_org,3)==1
    im = im_org;
else
    im = rgb2gray(im_org);
end
% figure,imshow(im);title('��Ƭα��ɫͼ��');  % ��ʾα��ɫͼ��
% colorbar       % ������ɫ��
% colormap jet   % change colormap

%%
im = permute(im,[3 2 1]); % ���þ����ά��
for i=1:3
    im = flipdim(im,i);
end
im(im<=40/255) = 0;       % �޳��Ҷ�ֵ�͵Ĳ��֣��Դ��ͱ�����
im(im>=100/255) = 0;      % �޳��Ҷ�ֵ�ߵĲ��֣�­�Ǻ���������֯��
im(:,:,1) = 0;            % �޳����ԻҰ�������Ĳ��ֻҶȲ���
blk = ones([1 7 7]);      % �����
% im = imerode(im,blk);   % ��ʴ
% �����������֯
lev = graythresh(double(im)/max_level) * max_level;  % ��ֵ
bw = (im>=lev);                % ��ֵ��
bw = imrotate(squeeze(bw),90); % ���츴ԭ
% ȥ��С��
cc=bwconncomp(bw);                          % ��ͨ�����
s  = regionprops(bw, {'centroid','area'});  % �������
[A, id] = max([s.Area]);
bw(labelmatrix(cc)~=id)=0;
bw = imdilate(bw,blk);         % ����
im_sep = immultiply(im_org,bw);
% figure,imshow(im_sep);title('seperate brain,gray matter and white matter')

%% ���ԻҰ�����ȡ
% lev2 = 50/255;  % ��ֵ
% L = zeros(size(im_sep));          %0=����
% L(im_sep<lev2 & im_sep>0) = 2;    %2=����
% L(im_sep>=lev2) = 3;              %3=����
% L = mat2gray(L);
% figure,imshow(L);title('�Ұ��ʷָ�ͼ')
%%
% edge_L = edge_ysw(L);  % ��Ե�ָ�
% figure,imshow(edge_L);title('�Ұ��ʱ�Ե���ͼ')
%%
end
end

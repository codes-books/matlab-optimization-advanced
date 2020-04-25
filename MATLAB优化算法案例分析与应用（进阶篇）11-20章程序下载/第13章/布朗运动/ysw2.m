% ���β����˶���ģ��
clc,clear,close all
warning off
n=50;         % ������t�ĳ��ȡ�
t = (0:1:n)'/n; 
h = 1;        % ��������
r = 3;        % ��
alpha = 0.8;  % ��
W = [0; cumsum(randn(n,1))]/sqrt(n);
y = (r - (alpha^2)/2)*t + alpha*W*sqrt(h);
X = exp(y); % ����Brown�˶�ת�Ʒ��̡�
plot(t,X); %���ƶ�ά����Brown�˶�ͼ��
title('��ά����Brown�˶�');
xlabel('t')
ylabel('S')

%%
% ���β����˶���ģ��
clc,clear,close all
warning off
r = 3;        % ��
alpha = 0.8;  % ��
n=50;         % ������t�ĳ��ȡ�
t = (0:1:n)'/n; 
T = 1;        % t
[X] = geometric_brownian(n,r,alpha,T)
plot(t,X); %���ƶ�ά����Brown�˶�ͼ��
title('��ά����Brown�˶�');
xlabel('t')
ylabel('S')



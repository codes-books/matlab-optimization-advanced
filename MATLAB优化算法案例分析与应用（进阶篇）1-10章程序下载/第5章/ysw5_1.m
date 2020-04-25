clc,clear,close all
warning off      % ��������
N = 1000;        % �źŹ۲ⳤ��
a1 = 0.99;       % һ��AR����
sigma = 0.0731; % ���԰���������
v = sqrt(sigma)*randn(N,1); % ����v��n�����԰�����
u0 = [0];      % ��ʼ����
num = 1;       % ����ϵ��
den = [1,a1];  % ��ĸϵ��
Zi = filtic(num,den,u0);    % �˲����ĳ�ʼ����
un = filter(num,den,v,Zi);   % ������������u(n), N x 1 x trials
figure,stem(un),title('����ź�');grid on;

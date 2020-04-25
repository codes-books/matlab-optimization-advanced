clc,clear;close all
warning off
X0 = xlsread('����','7#','B3:B29');  % EXCEL����
X1 = xlsread('����','7#','E3:E29');  % EXCEL����
X2 = xlsread('����','7#','G3:G29');  % EXCEL����
X3 = xlsread('����','7#','I3:I29');  % EXCEL����
X4 = xlsread('����','7#','K3:K29');  % EXCEL����
X5 = xlsread('����','7#','M3:M29');  % EXCEL����
X6 = xlsread('����','7#','O3:O29');  % EXCEL����
% initial value
a1 = 1; % ֲ������C ϵ��
a2 = 1; % ��������Q ϵ��
b = 1;  % ��������Q ָ��
a3 = 1; % ������ʼ��ˮ������ ϵ��
a4 = 1; % SS����Ũ�� ϵ��
a5 = 1; % ��������m  ϵ��
a6 = 1; % �¶�����%  ϵ��
a7 = 1; % ������     ϵ��
xs = [a1;a2;b;a3;a4;a5;a6;a7];       % ��ʼֵ
xdata = [X1,X2,X3,X4,X5,X6];
[x,resnorm] = lsqcurvefit(@myfun1,xs,xdata,X0)
% ������ϵ��
a1 = x(1); % ֲ������C ϵ��
a2 = x(2); % ��������Q ϵ��
b = x(3);  % ��������Q ָ��
a3 = x(4); % ������ʼ��ˮ������ ϵ��
a4 = x(5); % SS����Ũ�� ϵ��
a5 = x(6); % ��������m  ϵ��
a6 = x(7); % �¶�����%  ϵ��
a7 = x(8); % ������     ϵ��
for i = 1:length(X0)
    X0_fit(i) = a1*X1(i)+a2*(X2(i))^(b)+a3*X3(i)+a4*X4(i)+a5*log(X5(i))+a6*X6(i)+a7;
    err(i) = X0_fit(i)-X0(i);  % ������
end
figure('color',[1,1,1])
subplot(121),plot(X0_fit,'r','linewidth',2);hold on
plot(X0,'b','linewidth',2);hold off;axis tight
legend('���ֵ','ʵ��ֵ');title('SS��Ũ��������%')
subplot(122),plot(err,'g','linewidth',2);hold off;
axis tight;legend('���');title('SS��Ũ��������% -- ���')
% ���������
clc,clear;close all
warning off
format long
% global X0 X1 X2 X3 X4 X5 X6
X0 = xlsread('����','1#','B3:B30');  % EXCEL����
X1 = xlsread('����','1#','E3:E30');  % EXCEL����
X2 = xlsread('����','1#','G3:G30');  % EXCEL����
X3 = xlsread('����','1#','I3:I30');  % EXCEL����
X4 = xlsread('����','1#','K3:K30');  % EXCEL����
X5 = xlsread('����','1#','M3:M30');  % EXCEL����
X6 = xlsread('����','1#','O3:O30');  % EXCEL����
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





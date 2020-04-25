% �����˶�ģ��
clc,clear,close all
warning off
t0 = 0;  % start time
tf = 5;  % end time
h = 0.1; % ��������
t=t0:h:tf;    % ����ʱ������Ϊ[t0,tf],��������Ϊh��
n=length(t);  % ������t�ĳ��ȡ�
x=randn(1,n); % ����1�У�n�� N(0,1)�������
w=zeros(1,n); % ת����
for k=1:n-1
    w(1,k+1)=w(1,k)+x(1,k)*sqrt(h); % ����Brown�˶�ת�Ʒ��̡�
end
plot(t,w); %���ƶ�άBrown�˶�ͼ��
title('��άBrown�˶�');
xlabel('t')
ylabel('W')
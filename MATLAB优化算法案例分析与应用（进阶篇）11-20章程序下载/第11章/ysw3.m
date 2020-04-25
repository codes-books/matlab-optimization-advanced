%% ������ú��Ũ�������ӳ���ϵ��ģ
clc,clear,close all
ysw1;        % ��������
x=[v1,v3, v4];      % ����
y=[Pc1, Pc3 ,Pc4];  % ú��
figure('color',[1 1 1])
scatter(x,y,'.')
xlabel('����(m/s)');  ylabel(' ú��Ũ��(g/m3)');  grid off; axis tight

p = polyfit(x,y,1)  % ���
Pc=p(1)*x+p(2);
hold on
plot(x,Pc,'r*--')

%% ��������˹Ũ�������ӳ���ϵ��ģ
clc,clear,close all
ysw1;               % ��������
x=[v1,v4];          % ����
y=[Pg1,Pg4];        % ��˹
figure('color',[1 1 1])
scatter(x,y,'.')
xlabel('����(m/s)');  ylabel(' ú��Ũ��(g/m3)');  grid off; axis tight

p = polyfit(x,y,1)  % ���
Pc=p(1)*x+p(2);
hold on
plot(x,Pc,'r*--')

%% ������ʪ�������ӳ���ϵ��ģ
clc,clear,close all
ysw1;               % ��������
data = data1;
n=size(data);
datay=data(:,2);   %��Ϊ ���� Ŀ�����
datax4=data(:,5);  %��Ϊ �¶� ����
datax5=data(:,6);  %��Ϊ ʪ�� ����
figure('Color',[1 1 1]);
subplot(121),scatter(datay,datax4,'.')
xlabel('����(m/s)');   ylabel('�¶�');  grid off;  axis tight

subplot(122),scatter(datay,datax5,'.')
xlabel('����(m/s)');   ylabel('ʪ��');  grid off;  axis tight






%% ������1
%% draw surf1
clc,clear,close all
%���������������
load data1.mat; %ԭʼ�������������ķ�ʽ�����workplace�ļ���
data = data1;
n=size(data);
datax1=data(:,1);  %��Ϊ ʱ��� ����
datay=data(:,2);   %��Ϊ ͨ���� Ŀ�����
datax2=data(:,3);  %��Ϊ ��˹ ����
datax3=data(:,4);  %��Ϊ ú�� ����
datax4=data(:,5);  %��Ϊ �¶� ����
datax5=data(:,6);  %��Ϊ ʪ�� ����

datax22=0.6:0.01:0.8; %��Ϊ ��˹ ����
datax33=7:1/20:8;     %��Ϊ ú�� ����
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax3,datax2,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 ������������ڲ�
figure('Color',[1 1 1]);
surf(datax22,datax33,datay3);
xlabel('��˹');  ylabel('ú��');  zlabel('ͨ����');  grid on; axis tight

%% draw surf2
clc,clear,close all
%���������������
load data1.mat; %ԭʼ�������������ķ�ʽ�����workplace�ļ���
data = data1;
n=size(data);
datax1=data(:,1);  %��Ϊ ʱ��� ����
datay=data(:,2);   %��Ϊ ͨ���� Ŀ�����
datax2=data(:,3);  %��Ϊ ��˹ ����
datax3=data(:,4);  %��Ϊ ú�� ����
datax4=data(:,5);  %��Ϊ �¶� ����
datax5=data(:,6);  %��Ϊ ʪ�� ����

datax22=0.6:0.01:0.8;       %��Ϊ ��˹ ����
datax33=12.5:5/20:17.5;     %��Ϊ �¶� ����
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax4,datax2,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 ������������ڲ�
figure('Color',[1 1 1]);
surf(datax22,datax33,datay3);
xlabel('��˹');   ylabel('�¶�');   zlabel('ͨ����');  grid on;  axis tight

%% draw surf3
clc,clear,close all
%���������������
load data1.mat; %ԭʼ�������������ķ�ʽ�����workplace�ļ���
data = data1;
n=size(data);
datax1=data(:,1);  %��Ϊ ʱ��� ����
datay=data(:,2);   %��Ϊ ͨ���� Ŀ�����
datax2=data(:,3);  %��Ϊ ��˹ ����
datax3=data(:,4);  %��Ϊ ú�� ����
datax4=data(:,5);  %��Ϊ �¶� ����
datax5=data(:,6);  %��Ϊ ʪ�� ����

datax22=0.6:0.01:0.8;       %��Ϊ ��˹ ����
datax33=12.5:4/20:16.5;     %��Ϊ ʪ�� ����
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax5,datax2,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 ������������ڲ�
figure('Color',[1 1 1]);
surf(datax22,datax33,datay3);
xlabel('��˹');   ylabel('ʪ��');   zlabel('ͨ����');  grid on;  axis tight

%% draw surf4
clc,clear,close all
%���������������
load data1.mat; %ԭʼ�������������ķ�ʽ�����workplace�ļ���
data = data1;
n=size(data);
datax1=data(:,1);  %��Ϊ ʱ��� ����
datay=data(:,2);   %��Ϊ ͨ���� Ŀ�����
datax2=data(:,3);  %��Ϊ ��˹ ����
datax3=data(:,4);  %��Ϊ ú�� ����
datax4=data(:,5);  %��Ϊ �¶� ����
datax5=data(:,6);  %��Ϊ ʪ�� ����

datax22=7:1/20:8;           %��Ϊ ú�� ����
datax33=12.5:5/20:17.5;     %��Ϊ �¶� ����
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax4,datax3,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 ������������ڲ�
figure('Color',[1 1 1]);
surf(datax22,datax33,datay3);
xlabel('ú��');   ylabel('�¶�');   zlabel('ͨ����');  grid on;  axis tight

%% draw surf5
clc,clear,close all
%���������������
load data1.mat; %ԭʼ�������������ķ�ʽ�����workplace�ļ���
data = data1;
n=size(data);
datax1=data(:,1);  %��Ϊ ʱ��� ����
datay=data(:,2);   %��Ϊ ͨ���� Ŀ�����
datax2=data(:,3);  %��Ϊ ��˹ ����
datax3=data(:,4);  %��Ϊ ú�� ����
datax4=data(:,5);  %��Ϊ �¶� ����
datax5=data(:,6);  %��Ϊ ʪ�� ����

datax22=7:1/20:8;           %��Ϊ ú�� ����
datax33=12.5:4/20:16.5;     %��Ϊ ʪ�� ����
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax5,datax3,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 ������������ڲ�
figure('Color',[1 1 1]);
surf(datax22,datax33,datay3);
xlabel('ú��');   ylabel('ʪ��');   zlabel('ͨ����');  grid on;  axis tight

%% draw surf6
clc,clear,close all
%���������������
load data1.mat; %ԭʼ�������������ķ�ʽ�����workplace�ļ���
data = data1;
n=size(data);
datax1=data(:,1);  %��Ϊ ʱ��� ����
datay=data(:,2);   %��Ϊ ͨ���� Ŀ�����
datax2=data(:,3);  %��Ϊ ��˹ ����
datax3=data(:,4);  %��Ϊ ú�� ����
datax4=data(:,5);  %��Ϊ �¶� ����
datax5=data(:,6);  %��Ϊ ʪ�� ����

datax22=12.5:5/20:17.5;     %��Ϊ �¶� ����
datax33=12.5:4/20:16.5;     %��Ϊ ʪ�� ����
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax5,datax4,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 ������������ڲ�
figure('Color',[1 1 1]);
surf(datax22,datax33,datay3);
xlabel('�¶�');   ylabel('ʪ��');   zlabel('ͨ����');  grid on;  axis tight
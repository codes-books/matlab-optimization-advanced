%% ������1
%% draw surf1
clc,clear,close all
%���������������
clc,clear,close all
load('data1_GA_BP_test_result.mat')  % �Ŵ��㷨+BP
data = test_result;
n=size(data);
datax1=(1:n(1,1))';  %��Ϊ ʱ��� ����
datay=data(:,5);   %��Ϊ ͨ���� Ŀ�����
datax2=data(:,1);  %��Ϊ ��˹ ����
datax3=data(:,2);  %��Ϊ ú�� ����
datax4=data(:,3);  %��Ϊ �¶� ����
datax5=data(:,4);  %��Ϊ ʪ�� ����

datax22=min(datax2):0.01:max(datax2); %��Ϊ ��˹ ����
datax33=min(datax3):(max(datax3)-min(datax3))/(size(datax22,2)-1):max(datax3);     %��Ϊ ú�� ����
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax3,datax2,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 ������������ڲ�
figure('Color',[1 1 1]);
surf(datax22,datax33,datay3);
xlabel('��˹');  ylabel('ú��');  zlabel('ͨ����');  grid on; axis tight

%% draw surf2
clc,clear,close all
load('data1_GA_BP_test_result.mat')  % �Ŵ��㷨+BP
data = test_result;
n=size(data);
datax1=(1:n(1,1))';  %��Ϊ ʱ��� ����
datay=data(:,5);   %��Ϊ ͨ���� Ŀ�����
datax2=data(:,1);  %��Ϊ ��˹ ����
datax3=data(:,2);  %��Ϊ ú�� ����
datax4=data(:,3);  %��Ϊ �¶� ����
datax5=data(:,4);  %��Ϊ ʪ�� ����

datax22=min(datax2):0.01:max(datax2);      %��Ϊ ��˹ ����
datax33=min(datax4):(max(datax4)-min(datax4))/(size(datax22,2)-1):max(datax4);     %��Ϊ �¶� ����
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax4,datax2,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 ������������ڲ�
figure('Color',[1 1 1]);
surf(datax22,datax33,datay3);
xlabel('��˹');   ylabel('�¶�');   zlabel('ͨ����');  grid on;  axis tight

%% draw surf3
clc,clear,close all
load('data1_GA_BP_test_result.mat')  % �Ŵ��㷨+BP
data = test_result;
n=size(data);
datax1=(1:n(1,1))';  %��Ϊ ʱ��� ����
datay=data(:,5);   %��Ϊ ͨ���� Ŀ�����
datax2=data(:,1);  %��Ϊ ��˹ ����
datax3=data(:,2);  %��Ϊ ú�� ����
datax4=data(:,3);  %��Ϊ �¶� ����
datax5=data(:,4);  %��Ϊ ʪ�� ����

datax22=min(datax2):0.01:max(datax2);       %��Ϊ ��˹ ����
datax33=min(datax5):(max(datax5)-min(datax5))/(size(datax22,2)-1):max(datax5);      %��Ϊ ʪ�� ����
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax5,datax2,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 ������������ڲ�
figure('Color',[1 1 1]);
surf(datax22,datax33,datay3);
xlabel('��˹');   ylabel('ʪ��');   zlabel('ͨ����');  grid on;  axis tight

%% draw surf4
clc,clear,close all
load('data1_GA_BP_test_result.mat')  % �Ŵ��㷨+BP
data = test_result;
n=size(data);
datax1=(1:n(1,1))';  %��Ϊ ʱ��� ����
datay=data(:,5);   %��Ϊ ͨ���� Ŀ�����
datax2=data(:,1);  %��Ϊ ��˹ ����
datax3=data(:,2);  %��Ϊ ú�� ����
datax4=data(:,3);  %��Ϊ �¶� ����
datax5=data(:,4);  %��Ϊ ʪ�� ����

datax22=min(datax3):1/20:max(datax3);           %��Ϊ ú�� ����
datax33=min(datax4):(max(datax4)-min(datax4))/(size(datax22,2)-1):max(datax4);     %��Ϊ �¶� ����
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax4,datax3,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 ������������ڲ�
figure('Color',[1 1 1]);
surf(datax22,datax33,datay3);
xlabel('ú��');   ylabel('�¶�');   zlabel('ͨ����');  grid on;  axis tight

%% draw surf5
clc,clear,close all
load('data1_GA_BP_test_result.mat')  % �Ŵ��㷨+BP
data = test_result;
n=size(data);
datax1=(1:n(1,1))';  %��Ϊ ʱ��� ����
datay=data(:,5);   %��Ϊ ͨ���� Ŀ�����
datax2=data(:,1);  %��Ϊ ��˹ ����
datax3=data(:,2);  %��Ϊ ú�� ����
datax4=data(:,3);  %��Ϊ �¶� ����
datax5=data(:,4);  %��Ϊ ʪ�� ����

datax22=min(datax3):1/20:max(datax3);           %��Ϊ ú�� ����
datax33=min(datax5):(max(datax5)-min(datax5))/(size(datax22,2)-1):max(datax5);      %��Ϊ ʪ�� ����
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax5,datax3,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 ������������ڲ�
figure('Color',[1 1 1]);
surf(datax22,datax33,datay3);
xlabel('ú��');   ylabel('ʪ��');   zlabel('ͨ����');  grid on;  axis tight

%% draw surf6
clc,clear,close all
load('data1_GA_BP_test_result.mat')  % �Ŵ��㷨+BP
data = test_result;
n=size(data);
datax1=(1:n(1,1))';  %��Ϊ ʱ��� ����
datay=data(:,5);   %��Ϊ ͨ���� Ŀ�����
datax2=data(:,1);  %��Ϊ ��˹ ����
datax3=data(:,2);  %��Ϊ ú�� ����
datax4=data(:,3);  %��Ϊ �¶� ����
datax5=data(:,4);  %��Ϊ ʪ�� ����

datax22=min(datax4):5/20:max(datax4);     %��Ϊ �¶� ����
datax33=min(datax5):(max(datax5)-min(datax5))/(size(datax22,2)-1):max(datax5);     %��Ϊ ʪ�� ����
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax5,datax4,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 ������������ڲ�
figure('Color',[1 1 1]);
surf(datax22,datax33,datay3);
xlabel('�¶�');   ylabel('ʪ��');   zlabel('ͨ����');  grid on;  axis tight
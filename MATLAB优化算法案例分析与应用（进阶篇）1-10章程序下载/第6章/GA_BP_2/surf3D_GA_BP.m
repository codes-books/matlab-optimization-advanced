%% 工作面1
%% draw surf1
clc,clear,close all
%下载输入输出数据
clc,clear,close all
load('data1_GA_BP_test_result.mat')  % 遗传算法+BP
data = test_result;
n=size(data);
datax1=(1:n(1,1))';  %作为 时间点 输入
datay=data(:,5);   %作为 通风量 目标变量
datax2=data(:,1);  %作为 瓦斯 输入
datax3=data(:,2);  %作为 煤尘 输入
datax4=data(:,3);  %作为 温度 输入
datax5=data(:,4);  %作为 湿度 输入

datax22=min(datax2):0.01:max(datax2); %作为 瓦斯 输入
datax33=min(datax3):(max(datax3)-min(datax3))/(size(datax22,2)-1):max(datax3);     %作为 煤尘 输入
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax3,datax2,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 格点样条函数内插
figure('Color',[1 1 1]);
surf(datax22,datax33,datay3);
xlabel('瓦斯');  ylabel('煤尘');  zlabel('通风量');  grid on; axis tight

%% draw surf2
clc,clear,close all
load('data1_GA_BP_test_result.mat')  % 遗传算法+BP
data = test_result;
n=size(data);
datax1=(1:n(1,1))';  %作为 时间点 输入
datay=data(:,5);   %作为 通风量 目标变量
datax2=data(:,1);  %作为 瓦斯 输入
datax3=data(:,2);  %作为 煤尘 输入
datax4=data(:,3);  %作为 温度 输入
datax5=data(:,4);  %作为 湿度 输入

datax22=min(datax2):0.01:max(datax2);      %作为 瓦斯 输入
datax33=min(datax4):(max(datax4)-min(datax4))/(size(datax22,2)-1):max(datax4);     %作为 温度 输入
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax4,datax2,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 格点样条函数内插
figure('Color',[1 1 1]);
surf(datax22,datax33,datay3);
xlabel('瓦斯');   ylabel('温度');   zlabel('通风量');  grid on;  axis tight

%% draw surf3
clc,clear,close all
load('data1_GA_BP_test_result.mat')  % 遗传算法+BP
data = test_result;
n=size(data);
datax1=(1:n(1,1))';  %作为 时间点 输入
datay=data(:,5);   %作为 通风量 目标变量
datax2=data(:,1);  %作为 瓦斯 输入
datax3=data(:,2);  %作为 煤尘 输入
datax4=data(:,3);  %作为 温度 输入
datax5=data(:,4);  %作为 湿度 输入

datax22=min(datax2):0.01:max(datax2);       %作为 瓦斯 输入
datax33=min(datax5):(max(datax5)-min(datax5))/(size(datax22,2)-1):max(datax5);      %作为 湿度 输入
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax5,datax2,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 格点样条函数内插
figure('Color',[1 1 1]);
surf(datax22,datax33,datay3);
xlabel('瓦斯');   ylabel('湿度');   zlabel('通风量');  grid on;  axis tight

%% draw surf4
clc,clear,close all
load('data1_GA_BP_test_result.mat')  % 遗传算法+BP
data = test_result;
n=size(data);
datax1=(1:n(1,1))';  %作为 时间点 输入
datay=data(:,5);   %作为 通风量 目标变量
datax2=data(:,1);  %作为 瓦斯 输入
datax3=data(:,2);  %作为 煤尘 输入
datax4=data(:,3);  %作为 温度 输入
datax5=data(:,4);  %作为 湿度 输入

datax22=min(datax3):1/20:max(datax3);           %作为 煤尘 输入
datax33=min(datax4):(max(datax4)-min(datax4))/(size(datax22,2)-1):max(datax4);     %作为 温度 输入
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax4,datax3,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 格点样条函数内插
figure('Color',[1 1 1]);
surf(datax22,datax33,datay3);
xlabel('煤尘');   ylabel('温度');   zlabel('通风量');  grid on;  axis tight

%% draw surf5
clc,clear,close all
load('data1_GA_BP_test_result.mat')  % 遗传算法+BP
data = test_result;
n=size(data);
datax1=(1:n(1,1))';  %作为 时间点 输入
datay=data(:,5);   %作为 通风量 目标变量
datax2=data(:,1);  %作为 瓦斯 输入
datax3=data(:,2);  %作为 煤尘 输入
datax4=data(:,3);  %作为 温度 输入
datax5=data(:,4);  %作为 湿度 输入

datax22=min(datax3):1/20:max(datax3);           %作为 煤尘 输入
datax33=min(datax5):(max(datax5)-min(datax5))/(size(datax22,2)-1):max(datax5);      %作为 湿度 输入
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax5,datax3,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 格点样条函数内插
figure('Color',[1 1 1]);
surf(datax22,datax33,datay3);
xlabel('煤尘');   ylabel('湿度');   zlabel('通风量');  grid on;  axis tight

%% draw surf6
clc,clear,close all
load('data1_GA_BP_test_result.mat')  % 遗传算法+BP
data = test_result;
n=size(data);
datax1=(1:n(1,1))';  %作为 时间点 输入
datay=data(:,5);   %作为 通风量 目标变量
datax2=data(:,1);  %作为 瓦斯 输入
datax3=data(:,2);  %作为 煤尘 输入
datax4=data(:,3);  %作为 温度 输入
datax5=data(:,4);  %作为 湿度 输入

datax22=min(datax4):5/20:max(datax4);     %作为 温度 输入
datax33=min(datax5):(max(datax5)-min(datax5))/(size(datax22,2)-1):max(datax5);     %作为 湿度 输入
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax5,datax4,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 格点样条函数内插
figure('Color',[1 1 1]);
surf(datax22,datax33,datay3);
xlabel('温度');   ylabel('湿度');   zlabel('通风量');  grid on;  axis tight
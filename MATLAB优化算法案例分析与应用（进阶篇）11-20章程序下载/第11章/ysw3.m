%% 空气中煤尘浓度与风速映射关系建模
clc,clear,close all
ysw1;        % 加载数据
x=[v1,v3, v4];      % 风速
y=[Pc1, Pc3 ,Pc4];  % 煤尘
figure('color',[1 1 1])
scatter(x,y,'.')
xlabel('风速(m/s)');  ylabel(' 煤尘浓度(g/m3)');  grid off; axis tight

p = polyfit(x,y,1)  % 拟合
Pc=p(1)*x+p(2);
hold on
plot(x,Pc,'r*--')

%% 空气中瓦斯浓度与风速映射关系建模
clc,clear,close all
ysw1;               % 加载数据
x=[v1,v4];          % 风速
y=[Pg1,Pg4];        % 瓦斯
figure('color',[1 1 1])
scatter(x,y,'.')
xlabel('风速(m/s)');  ylabel(' 煤尘浓度(g/m3)');  grid off; axis tight

p = polyfit(x,y,1)  % 拟合
Pc=p(1)*x+p(2);
hold on
plot(x,Pc,'r*--')

%% 矿井中温湿度与风速映射关系建模
clc,clear,close all
ysw1;               % 加载数据
data = data1;
n=size(data);
datay=data(:,2);   %作为 风速 目标变量
datax4=data(:,5);  %作为 温度 输入
datax5=data(:,6);  %作为 湿度 输入
figure('Color',[1 1 1]);
subplot(121),scatter(datay,datax4,'.')
xlabel('风速(m/s)');   ylabel('温度');  grid off;  axis tight

subplot(122),scatter(datay,datax5,'.')
xlabel('风速(m/s)');   ylabel('湿度');  grid off;  axis tight






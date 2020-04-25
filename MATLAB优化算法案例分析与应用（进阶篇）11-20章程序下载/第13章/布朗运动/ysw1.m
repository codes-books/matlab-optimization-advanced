% 布朗运动模拟
clc,clear,close all
warning off
t0 = 0;  % start time
tf = 5;  % end time
h = 0.1; % 采样步长
t=t0:h:tf;    % 定义时间区间为[t0,tf],采样步长为h。
n=length(t);  % 求向量t的长度。
x=randn(1,n); % 产生1行，n列 N(0,1)随机距阵。
w=zeros(1,n); % 转移量
for k=1:n-1
    w(1,k+1)=w(1,k)+x(1,k)*sqrt(h); % 定义Brown运动转移方程。
end
plot(t,w); %绘制二维Brown运动图。
title('二维Brown运动');
xlabel('t')
ylabel('W')
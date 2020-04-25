clc,clear,close all
warning off      % 消除警告
N = 1000;        % 信号观测长度
a1 = 0.99;       % 一阶AR参数
sigma = 0.0731; % 加性白噪声方差
v = sqrt(sigma)*randn(N,1); % 产生v（n）加性白噪声
u0 = [0];      % 初始数据
num = 1;       % 分子系数
den = [1,a1];  % 分母系数
Zi = filtic(num,den,u0);    % 滤波器的初始条件
un = filter(num,den,v,Zi);   % 产生样本序列u(n), N x 1 x trials
figure,stem(un),title('随机信号');grid on;

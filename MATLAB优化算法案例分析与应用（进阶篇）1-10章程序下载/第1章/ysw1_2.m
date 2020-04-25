clc,clear,close all                    % 清屏、清工作区、关闭窗口
warning off                         % 消除警告
feature jit off                        % 加速代码执行
P1=0.5;   % 初始化
P2=0.5;    % 初始化
m1=[0.1 1.1]';    % 初始化
m2=[1.3 0.2]';    % 初始化
S=eye(2);    % 初始化
x=[1.5 1.5]';   % 初始化
p1=P1*comp_gauss_dens_val(m1,S,x)  % 高斯概率密度分布函数计算
p2=P2*comp_gauss_dens_val(m2,S,x)  % 高斯概率密度分布函数计算

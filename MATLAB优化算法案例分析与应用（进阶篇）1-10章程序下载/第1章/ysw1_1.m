clc,clear,close all                    % 清屏、清工作区、关闭窗口
warning off                         % 消除警告
feature jit off                        % 加速代码执行
m=[0.0 0.1]'; S=[1,0;1,1];                  % 初始化
x1=[0.12 0.012]'; x2=[0.2 -0.3]';
pg1=comp_gauss_dens_val(m,S,x1)  % 高斯概率密度分布函数计算
pg2=comp_gauss_dens_val(m,S,x2)  % 高斯概率密度分布函数计算


% 万有引力搜索算法
clc,clear,close all
warning off
feature jit off
 N=50;           % 粒子数量（智能个体）
 max_it=1000;    % 最大迭代次数
 ElitistCheck=1; % ElitistCheck: 算法执行次数选择
 Rpower=1;       % Rpower: 'R'的次方
 min_flag=1;     % 1: 求函数最小值，0：求函数最大值
 F_index=1;      % 带求解函数选择
 [Fbest,Lbest,BestChart,MeanChart]=GSA(F_index,N,max_it,ElitistCheck,min_flag,Rpower);
 %  输出:
% Fbest: 最优适应度值.
% Lbest: 最优解向量
% BestChart: 适应度变化值.
% MeanChart: 平均适应度变化值
 Fbest,  % 最优适应度值
 Lbest,  % 最优解
%% 绘制适应度曲线
figure('color',[1,1,1])
plot(BestChart,'linewidth',2),
xlabel('\fontsize{12}\bf Iteration');ylabel('\fontsize{12}\bf 最优适应度值');
legend('\fontsize{10}\bf GSA',1);
grid on
figure('color',[1,1,1])
plot(MeanChart,'linewidth',2),
xlabel('\fontsize{12}\bf Iteration');ylabel('\fontsize{12}\bf 平均适应度值');
legend('\fontsize{10}\bf GSA',1);
grid on


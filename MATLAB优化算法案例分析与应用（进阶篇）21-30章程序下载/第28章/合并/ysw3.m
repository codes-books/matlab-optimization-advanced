%% 改进的GA
%% 清空环境变量
clc,clear,close all % 清除变量空间
warning off      % 消除警告
feature jit off  % 加速代码执行
ysw1
hold on
ysw2
%% 改进的遗传算法结果分析 
plot(1:length(trace),trace(:,1),'b--');
title(['适应度曲线  ' '终止代数＝' num2str(maxgen)]);
xlabel('进化代数');   ylabel('适应度');
legend('fz最佳适应度');
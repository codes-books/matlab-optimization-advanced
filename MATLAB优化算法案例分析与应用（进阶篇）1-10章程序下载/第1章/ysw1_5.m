clc,clear,close all
warning off                         	% 消除警告
feature jit off                       	% 加速代码执行
% 随机产生数据集
randn('seed',0);
m = [1 -1]; S = [1.1 0.740630; 0.740630 0.87];    % 初始化
X = mvnrnd(m,S,50)';    				     % 随机种子产生器
% 最大似然估计，进行均值和协方差估计
[m_hat, S_hat]=Gaussian_ML_estimate(X)

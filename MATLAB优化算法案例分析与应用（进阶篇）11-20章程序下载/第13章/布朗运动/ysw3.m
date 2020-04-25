% 伊藤微分方程的布朗运动的模拟
clc,clear,close all
warning off
n=50;         % 求向量t的长度。
t = (0:1:n)'/n; 
h = 1;        % 采样步长
X = 50;  
X = X(ones(n,1));  % 定义初始化Brown运动
F = @(t,X) 0.1 * X;  % 漂移项 drift functions 
G = @(t,X) 0.3 * X;  % 扩散项 diffusion functions 
obj = sde(F, G)      % dX = F(t,X)dt + G(t,X)dW
[S,T] = obj.simulate(n, 'DeltaTime', h);
plot(T, S,'r-'), 
xlabel('时刻点')
ylabel('S')
title('伊藤方程下的Brown的运动仿真');
% F = drift(0, 0.1)      % Drift rate function F(t,X)
% G = diffusion(1, 0.3)  % Diffusion rate function G(t,X)






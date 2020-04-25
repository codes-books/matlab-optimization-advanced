% 几何布朗运动的模拟
clc,clear,close all
warning off
n=50;         % 求向量t的长度。
t = (0:1:n)'/n; 
h = 1;        % 采样步长
r = 3;        % μ
alpha = 0.8;  % σ
W = [0; cumsum(randn(n,1))]/sqrt(n);
y = (r - (alpha^2)/2)*t + alpha*W*sqrt(h);
X = exp(y); % 定义Brown运动转移方程。
plot(t,X); %绘制二维几何Brown运动图。
title('二维几何Brown运动');
xlabel('t')
ylabel('S')

%%
% 几何布朗运动的模拟
clc,clear,close all
warning off
r = 3;        % μ
alpha = 0.8;  % σ
n=50;         % 求向量t的长度。
t = (0:1:n)'/n; 
T = 1;        % t
[X] = geometric_brownian(n,r,alpha,T)
plot(t,X); %绘制二维几何Brown运动图。
title('二维几何Brown运动');
xlabel('t')
ylabel('S')



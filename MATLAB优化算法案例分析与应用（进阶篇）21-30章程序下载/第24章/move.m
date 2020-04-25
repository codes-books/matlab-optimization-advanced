function [X,V]=move(X,a,V)
% 粒子速度和位置更新
%movement.
[N,dim]=size(X);
V=rand(N,dim).*V+a; % 速度更新
X=X+V;              % 位置更新
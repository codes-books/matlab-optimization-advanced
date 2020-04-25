% 随机的初始化个体
function [X]=initialization(dim,N,up,down)
% dim:未知数个数，粒子个数
% N:种群数
% up：取值上限
% down：取值下限
% X：初始化的个体值
if size(up,2)==1
    X=rand(N,dim).*(up-down)+down;
end
if size(up,2)>1
    for i=1:dim
    high=up(i);low=down(i);
    X(:,i)=rand(N,1).*(high-low)+low;
    end
end
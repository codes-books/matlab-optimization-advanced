function [y]=mixt_value(m,S,P,X)
% 函数调用个数：
%   [y]=mixt_value(m,S,P,X)
% 对于给定的数据点，计算混合概率密度函数分布下的对应的概率值
%输入:
%   m:  lxc matrix，每一个正态分布下对应的均值
%   S:  lxlxc matrix.，对应的正态分布下的协方差矩阵
%   P:  c-维向量， 混合概率值
%   X:  lxN 数据矩阵
%输出:
%   y:  N dimensional 数组， 混合概率密度函数分布下的对应的概率值
 [l,N]=size(X);
[l,c]=size(m);
 
y=[];
for i=1:N
    temp=[];
    for j=1:c
        t=mvnpdf(X(:,i)',m(:,j)',S(:,:,j));
        temp=[temp t];
    end
    y_temp=sum(P.*temp);
    y=[y y_temp];
end

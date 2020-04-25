function [y]=mixture_Bayes(m,S,P,P_cl,X)
% 函数调用格式：
%   [y]=mixture_Bayes(m,S,P,P_cl,X)
% 贝叶斯分类器，概率密度函数为混合正态分布模型
%输入:
%   m:  cl-维胞组, 每一个胞组为对应的均值
%   S:  cl-维胞组, 每一个胞组为对应的协方差矩阵
%   P:  cl-维胞组, 正态分布的混合概率值
%   P_cl: cl-维数组，每一个胞组为对应的先验概率值
%   X:    lxN 矩阵 数据X
%输出:
%   y:    N-dimensional 数组，分类类别
 
cl=length(m);
[l,N]=size(X);
 
y=[];
for i=1:N
    temp=[];
    for j=1:cl
        t=mixt_value(m{j},S{j},P{j},X(:,i));
        temp=[temp t];
    end
    temp=P_cl.*temp;
    [q1,q2]=max(temp);
    y=[y q2];
end

function [X,y]=mixt_model(m,S,P,N,sed)
% 产生一组数据，来自于混合高斯分布模型
%输入:
%   m:    均值向量
%   S:    协方差向量
%   P:    先验概率
%   N:    数据点数
%   sed:  rand()中的随机种子初始化
%输出:
%   X:  lxN 矩阵，列向量存储
%   y:  N为向量，对应于X下的正态分布指数
 
rand('seed',sed);   % 随机种子
[l,c]=size(m);      % 矩阵维数
P_acc=P(1);       % 初始化
for i=2:c
    t=P_acc(i-1)+P(i);
    P_acc=[P_acc t];
end
 
% 初始化，产生数据
X=[];
y=[];
for i=1:N
    t=rand;
    ind=sum(t>P_acc)+1;  % 正态分布指数
    X=[X; mvnrnd(m(:,ind)',S(:,:,ind),1)];
    y=[y ind];
end
X=X';

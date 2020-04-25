function [X,y]=generate_gauss_classes(m,S,P,N)
% 产生服从高斯PDF分布的数据集 
%输入:
%   m:  均值向量
%   S:  正态分布的协方差矩阵
%   P:  先验概率密度
%   N:  总数据个数
%输出:
%   X:  待分类的数据
%   y:  分类的标签，对应于X
[l,c]=size(m);
X=[];  % 初始化
y=[];
for j=1:c
% 产生每一个分布下的 the [p(j)*N] 向量
   t=mvnrnd(m(:,j),S(:,:,j),fix(P(j)*N))';
   % 由于采用的是fix函数，总数据数可能小于N
   X=[X t];
   y=[y ones(1,fix(P(j)*N))*j];
end


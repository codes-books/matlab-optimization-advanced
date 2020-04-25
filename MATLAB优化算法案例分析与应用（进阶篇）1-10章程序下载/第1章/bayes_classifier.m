function [z]=bayes_classifier(m,S,P,X)
% 实现贝叶斯分类器设计
%输入:
%   m:      均值向量
%   S:      协方差向量
%   P:      先验概率
%   X:      待分类数据
%输出:
%   z:      分类类别
[l,c]=size(m);  				% 矩阵行列维数
[l,N]=size(X);                 % 矩阵行列维数
 
for i=1:N
    for j=1:c
        t(j)=P(j)*comp_gauss_dens_val(m(:,j),S(:,:,j),X(:,i));
    end
    [num,z(i)]=max(t);
end

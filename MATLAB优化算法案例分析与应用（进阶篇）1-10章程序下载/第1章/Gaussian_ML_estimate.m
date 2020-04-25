function [m_hat,S_hat]=Gaussian_ML_estimate(X)
% 实现最大似然估计
% 输入:
%   X:      列向量
% 输出:
%   m_hat:  均值估计.
%   S_hat:  协方差估计.
[l,N]=size(X);  					% 矩阵维数
m_hat=(1/N)*sum(X')';  			% 平均值
S_hat=zeros(l);        			% 初始化
for k=1:N
    S_hat=S_hat+(X(:,k)-m_hat)*(X(:,k)-m_hat)';  		% 最大似然估计
end
S_hat=(1/N)*S_hat;      						% 取平均

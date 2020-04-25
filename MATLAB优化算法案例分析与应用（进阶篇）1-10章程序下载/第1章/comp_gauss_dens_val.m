function [z]=comp_gauss_dens_val(m,S,x)
% 输出：
%   z：在特定点x位置处的高斯概率密度估计值
% 输入:
%   m:  列向量，高斯PDF中的均值向量
%   S:  协方差矩阵
%   x:  列向量
[l,c]=size(m);
z=(1/( (2*pi)^(l/2)*det(S)^0.5) )*exp(-0.5*(x-m)'*inv(S)*(x-m));  % 高斯函数

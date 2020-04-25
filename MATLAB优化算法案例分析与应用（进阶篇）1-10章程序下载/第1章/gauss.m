function [z]=gauss(x,m,s)
% 计算在x点处的高斯概率值
% 输入:
%   x:  l-dimensional 行向量
%   m:  Jxl matrix, 高斯分布均值
%   s:  J-dimensional row vector 协方差矩阵
%输出:
%   z:  J-dimensional vector，在x处的高斯概率值.
 
[J,l]=size(m);
[p,l]=size(x);
z=[];
for j=1:J
    t=(x-m(j,:))*(x-m(j,:))';
    c=1/(2*pi*s(j))^(l/2);
    z=[z c*exp(-t/(2*s(j)))];
end

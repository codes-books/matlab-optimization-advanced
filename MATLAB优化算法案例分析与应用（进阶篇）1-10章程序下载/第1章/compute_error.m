function [clas_error]=compute_error(y,y_est)
% 函数调用格式
%   [clas_error]=compute_error(y,t_est)
% 计算分类误差
%输入:
%   y:      N-dimensional vector 分类标签
%   y_est:  N-dimensional vector 按照分类规则分类类别
%输出:
%   clas_error: 分类误差.
 
[q,N]=size(y);   			% N = 向量个数
c=max(y);      			% 确定分类数
clas_error=0;   			% 初始化
for i=1:N
    if(y(i)~=y_est(i))
        clas_error=clas_error+1;
    end
end
%误差
clas_error=clas_error/N;

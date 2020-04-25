function fitness = Fitness_ACO(x,method)
% 蚁群算法ACO的 函数优化分析
% 输入：
% x - 个体
% method - aco蚁群算法
% 输出：
% fitness - 返回适应度值

if (nargin<2)   % 默认为aco
    method='aco';
end
if strcmpi(method,'aco') % ACO 算法
    fitness = -20*exp(-0.2*sqrt((x(1)^2+x(2)^2)/2))-exp((cos(2*pi*x(1))+cos(2*pi*x(2)))/2)+20+2.71289;
end

function [xx,yy]=sort_mat(x,y)
% 函数使得以x为基准，进行x,y相对应的数从小到大排列
% x为要排序的矩阵  1 x N
% y为要对应的排序的矩阵   1 x N
[a,b]=sort(x);
% a为排序的结果
% b为x中数据排序的序号
nx =size(x);
for i=1:nx(1,2)
    xx(i)=x(1,b(i));
    yy(i)=y(1,b(i));
end
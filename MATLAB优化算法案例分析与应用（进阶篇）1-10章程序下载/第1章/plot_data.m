function plot_data(X,y,m,h)
% 画图，实现不同的数据类，用不同的颜色表示
% 输入:
%   X:  lxN matrix, 画图采用X的列向量进行一列一列绘制
%   y:  N-dimensional vector，数据类别
%   m:  lxc matrix, 均值向量.
%   h:  图像句柄
 
[l,N]=size(X); % N=no. of data vectors, l=dimensionality
[l,c]=size(m); % c=no. of classes
 
if(l~=2) || (c>7)
    fprintf('数据维数有问题，请检查\n')
    return
else
    pale=['r.'; 'g.'; 'b.'; 'y.'; 'm.'; 'c.';'co'];
    figure(h)
    % 画图
    hold on
    for i=1:N
        plot(X(1,i),X(2,i),pale(y(i),:))
        hold on
    end
    
    % 绘制数据类重心
    for j=1:c
        plot(m(1,j),m(2,j),'k+')
        hold on
    end
end



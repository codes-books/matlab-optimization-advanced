function [px]=knn_density_estimate(X,knn,xleftlimit,xrightlimit,xstep)
% 函数调用格式
%   [px]=knn_density_estimate(X,knn,xleftlimit,xrightlimit,xstep)
%  k-nn最近邻密度估计
%输入:
%   X:           数据点
%   knn:         最近邻个数.
%   xleftlimit:     x的最小估计值
%   xrightlimit:    x的最大估计值
%   xstep:       步长
%输出:
%   px:          p(x)的估计值

[l,N]=size(X);
if l>1
    px=[];
    fprintf('Feature set has more than one dimensions ');
    return;
end
 
k=1;
x=xleftlimit;
while x<xrightlimit+xstep/2
    eucl=[];
    for i=1:N
        eucl(i)=sqrt(sum((x-X(:,i)).^2));
    end
    eucl=sort(eucl,'ascend');  % 升序
    ro=eucl(knn);
    V=2*ro;
    px(k)=knn/(N*V);
    k=k+1;
    x=x+xstep;
end

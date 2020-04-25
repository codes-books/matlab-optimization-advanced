function [px]=Parzen_gauss_kernel(X,h,xleftlimit,xrightlimit)
% 函数调用格式
%   [px]=Parzen_gauss_kernel(X,h,xleftlimit,xrightlimit)
% Parzen 使用高斯基逼近一维PDF
%输入:
%   X:           数据点
%   h:           步长
%   xleftlimit:     x的最小估计值
%   xrightlimit:    x的最大估计值
%输出:
%   px:          p(x)的估计值
 
[l,N]=size(X);
xstep=h;
k=1;
x=xleftlimit;
while x<xrightlimit+xstep/2
    px(k)=0;
    for i=1:N
        xi=X(:,i);
        px(k)=px(k)+exp(-(x-xi)'*(x-xi)/(2*h^2));
    end
    px(k)=px(k)*(1/N)*(1/(((2*pi)^(l/2))*(h^l)));
    k=k+1;
    x=x+xstep;
end

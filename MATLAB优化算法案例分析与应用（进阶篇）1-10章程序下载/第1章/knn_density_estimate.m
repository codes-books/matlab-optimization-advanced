function [px]=knn_density_estimate(X,knn,xleftlimit,xrightlimit,xstep)
% �������ø�ʽ
%   [px]=knn_density_estimate(X,knn,xleftlimit,xrightlimit,xstep)
%  k-nn������ܶȹ���
%����:
%   X:           ���ݵ�
%   knn:         ����ڸ���.
%   xleftlimit:     x����С����ֵ
%   xrightlimit:    x��������ֵ
%   xstep:       ����
%���:
%   px:          p(x)�Ĺ���ֵ

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
    eucl=sort(eucl,'ascend');  % ����
    ro=eucl(knn);
    V=2*ro;
    px(k)=knn/(N*V);
    k=k+1;
    x=x+xstep;
end

function [z]=k_nn_classifier(Z,v,k,X)
% 函数使用格式如下：
%   [z]=k_nn_classifier(Z,v,k,X)
%  分类器函数
% 输入:
%   Z:  lxN1  matrix, 第i列对应第i个参考向量
%   v:  N1-dimensional vector 参考向量所隶属的类别
%   k:  最近邻个数
%   X:  lxN matrix每一列为待分类的数据
%输出:
%   z:  N-dimensional vector X分类后的类别
[l,N1]=size(Z);
[l,N]=size(X);
c=max(v);  %分类数
% 计算欧氏距离
for i=1:N
    dist=sum((X(:,i)*ones(1,N1)-Z).^2);
    %升序排列
    [sorted,nearest]=sort(dist);
    refe=zeros(1,c); %计算每一类的参考向量
    for q=1:k
        class=v(nearest(q));
        refe(class)=refe(class)+1;
    end
    [val,z(i)]=max(refe);
end

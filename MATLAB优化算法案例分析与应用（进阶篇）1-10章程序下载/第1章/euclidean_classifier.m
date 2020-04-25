function [z]=euclidean_classifier(m,X)
%实现欧式距离分类器设计
% 输入:
%   m:  列向量，均值向量，每一列表示待分类数据的均值向量
%   X:  每一列表示待分类的数据
%输出:
%   z:  输出属于哪一类的标签
%
[l,c]=size(m);     			% 维数
[l,N]=size(X);     			% 维数
 
for i=1:N
    for j=1:c
        de(j)=sqrt((X(:,i)-m(:,j))'*(X(:,i)-m(:,j)));  	% 欧氏距离
    end 
    [num,z(i)]=min(de);    					% 最小距离
end

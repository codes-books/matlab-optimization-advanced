function z=mahalanobis_classifier(m,S,X)
% 实现马氏距离分类器设计
% 输入:
%   m:  列向量，均值向量，每一列表示待分类数据的均值向量
%   S:  方阵，协方差矩阵
%   X:  每一列是待分类的数据
%输出:
%   z:  输出属于哪一类的标签
[l,c]=size(m);   				% 维数
[l,N]=size(X);   				% 维数
 
for i=1:N
    for j=1:c
        dm(j)=sqrt((X(:,i)-m(:,j))'*inv(S)*(X(:,i)-m(:,j)));  		% 马氏距离计算
    end
    [num,z(i)]=min(dm);  			% 最小距离
end

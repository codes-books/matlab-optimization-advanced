function [z]=euclidean_classifier(m,X)
%ʵ��ŷʽ������������
% ����:
%   m:  ����������ֵ������ÿһ�б�ʾ���������ݵľ�ֵ����
%   X:  ÿһ�б�ʾ�����������
%���:
%   z:  ���������һ��ı�ǩ
%
[l,c]=size(m);     			% ά��
[l,N]=size(X);     			% ά��
 
for i=1:N
    for j=1:c
        de(j)=sqrt((X(:,i)-m(:,j))'*(X(:,i)-m(:,j)));  	% ŷ�Ͼ���
    end 
    [num,z(i)]=min(de);    					% ��С����
end

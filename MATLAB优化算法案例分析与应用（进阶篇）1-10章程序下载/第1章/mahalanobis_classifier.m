function z=mahalanobis_classifier(m,S,X)
% ʵ�����Ͼ�����������
% ����:
%   m:  ����������ֵ������ÿһ�б�ʾ���������ݵľ�ֵ����
%   S:  ����Э�������
%   X:  ÿһ���Ǵ����������
%���:
%   z:  ���������һ��ı�ǩ
[l,c]=size(m);   				% ά��
[l,N]=size(X);   				% ά��
 
for i=1:N
    for j=1:c
        dm(j)=sqrt((X(:,i)-m(:,j))'*inv(S)*(X(:,i)-m(:,j)));  		% ���Ͼ������
    end
    [num,z(i)]=min(dm);  			% ��С����
end

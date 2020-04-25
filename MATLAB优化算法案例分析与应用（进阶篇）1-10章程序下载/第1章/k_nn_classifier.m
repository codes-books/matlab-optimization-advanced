function [z]=k_nn_classifier(Z,v,k,X)
% ����ʹ�ø�ʽ���£�
%   [z]=k_nn_classifier(Z,v,k,X)
%  ����������
% ����:
%   Z:  lxN1  matrix, ��i�ж�Ӧ��i���ο�����
%   v:  N1-dimensional vector �ο����������������
%   k:  ����ڸ���
%   X:  lxN matrixÿһ��Ϊ�����������
%���:
%   z:  N-dimensional vector X���������
[l,N1]=size(Z);
[l,N]=size(X);
c=max(v);  %������
% ����ŷ�Ͼ���
for i=1:N
    dist=sum((X(:,i)*ones(1,N1)-Z).^2);
    %��������
    [sorted,nearest]=sort(dist);
    refe=zeros(1,c); %����ÿһ��Ĳο�����
    for q=1:k
        class=v(nearest(q));
        refe(class)=refe(class)+1;
    end
    [val,z(i)]=max(refe);
end

function [y]=mixt_value(m,S,P,X)
% �������ø�����
%   [y]=mixt_value(m,S,P,X)
% ���ڸ��������ݵ㣬�����ϸ����ܶȺ����ֲ��µĶ�Ӧ�ĸ���ֵ
%����:
%   m:  lxc matrix��ÿһ����̬�ֲ��¶�Ӧ�ľ�ֵ
%   S:  lxlxc matrix.����Ӧ����̬�ֲ��µ�Э�������
%   P:  c-ά������ ��ϸ���ֵ
%   X:  lxN ���ݾ���
%���:
%   y:  N dimensional ���飬 ��ϸ����ܶȺ����ֲ��µĶ�Ӧ�ĸ���ֵ
 [l,N]=size(X);
[l,c]=size(m);
 
y=[];
for i=1:N
    temp=[];
    for j=1:c
        t=mvnpdf(X(:,i)',m(:,j)',S(:,:,j));
        temp=[temp t];
    end
    y_temp=sum(P.*temp);
    y=[y y_temp];
end

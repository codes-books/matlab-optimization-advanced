function [y]=mixture_Bayes(m,S,P,P_cl,X)
% �������ø�ʽ��
%   [y]=mixture_Bayes(m,S,P,P_cl,X)
% ��Ҷ˹�������������ܶȺ���Ϊ�����̬�ֲ�ģ��
%����:
%   m:  cl-ά����, ÿһ������Ϊ��Ӧ�ľ�ֵ
%   S:  cl-ά����, ÿһ������Ϊ��Ӧ��Э�������
%   P:  cl-ά����, ��̬�ֲ��Ļ�ϸ���ֵ
%   P_cl: cl-ά���飬ÿһ������Ϊ��Ӧ���������ֵ
%   X:    lxN ���� ����X
%���:
%   y:    N-dimensional ���飬�������
 
cl=length(m);
[l,N]=size(X);
 
y=[];
for i=1:N
    temp=[];
    for j=1:cl
        t=mixt_value(m{j},S{j},P{j},X(:,i));
        temp=[temp t];
    end
    temp=P_cl.*temp;
    [q1,q2]=max(temp);
    y=[y q2];
end

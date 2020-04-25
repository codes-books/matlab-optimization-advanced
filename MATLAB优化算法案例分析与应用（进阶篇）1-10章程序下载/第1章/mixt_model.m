function [X,y]=mixt_model(m,S,P,N,sed)
% ����һ�����ݣ������ڻ�ϸ�˹�ֲ�ģ��
%����:
%   m:    ��ֵ����
%   S:    Э��������
%   P:    �������
%   N:    ���ݵ���
%   sed:  rand()�е�������ӳ�ʼ��
%���:
%   X:  lxN �����������洢
%   y:  NΪ��������Ӧ��X�µ���̬�ֲ�ָ��
 
rand('seed',sed);   % �������
[l,c]=size(m);      % ����ά��
P_acc=P(1);       % ��ʼ��
for i=2:c
    t=P_acc(i-1)+P(i);
    P_acc=[P_acc t];
end
 
% ��ʼ������������
X=[];
y=[];
for i=1:N
    t=rand;
    ind=sum(t>P_acc)+1;  % ��̬�ֲ�ָ��
    X=[X; mvnrnd(m(:,ind)',S(:,:,ind),1)];
    y=[y ind];
end
X=X';

% ����ĳ�ʼ������
function [X]=initialization(dim,N,up,down)
% dim:δ֪�����������Ӹ���
% N:��Ⱥ��
% up��ȡֵ����
% down��ȡֵ����
% X����ʼ���ĸ���ֵ
if size(up,2)==1
    X=rand(N,dim).*(up-down)+down;
end
if size(up,2)>1
    for i=1:dim
    high=up(i);low=down(i);
    X(:,i)=rand(N,1).*(high-low)+low;
    end
end
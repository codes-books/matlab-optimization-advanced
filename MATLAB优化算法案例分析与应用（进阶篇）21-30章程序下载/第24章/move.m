function [X,V]=move(X,a,V)
% �����ٶȺ�λ�ø���
%movement.
[N,dim]=size(X);
V=rand(N,dim).*V+a; % �ٶȸ���
X=X+V;              % λ�ø���
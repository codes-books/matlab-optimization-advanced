% ����΢�ַ��̵Ĳ����˶���ģ��
clc,clear,close all
warning off
n=50;         % ������t�ĳ��ȡ�
t = (0:1:n)'/n; 
h = 1;        % ��������
X = 50;  
X = X(ones(n,1));  % �����ʼ��Brown�˶�
F = @(t,X) 0.1 * X;  % Ư���� drift functions 
G = @(t,X) 0.3 * X;  % ��ɢ�� diffusion functions 
obj = sde(F, G)      % dX = F(t,X)dt + G(t,X)dW
[S,T] = obj.simulate(n, 'DeltaTime', h);
plot(T, S,'r-'), 
xlabel('ʱ�̵�')
ylabel('S')
title('���ٷ����µ�Brown���˶�����');
% F = drift(0, 0.1)      % Drift rate function F(t,X)
% G = diffusion(1, 0.3)  % Diffusion rate function G(t,X)






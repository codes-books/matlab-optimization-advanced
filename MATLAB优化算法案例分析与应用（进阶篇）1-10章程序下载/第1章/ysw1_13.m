clc,clear,close all                    % �������幤�������رմ���
warning off                         % ��������
feature jit off                        % ���ٴ���ִ��
m=[0 1; 5 6]';
S=[0.5 0.1;0.1 0.5];
S(:,:,1)=S;S(:,:,2)=S;
P=[1/2 1/2 ]'; N_1=1000;
% ���������ʼ������X1 and X2
randn('seed',0);
[X1,y1]=generate_gauss_classes(m,S,P,N_1);
N_2=5000;
randn('seed',100);
[X2,y2]=generate_gauss_classes(m,S,P,N_2);
 
%ʹ�� k_nn_classifier (k=3)����������
k=3;
z=k_nn_classifier(X1,y1,k,X2);
 
% ����������
pr_err=sum(z~=y2)/length(y2)

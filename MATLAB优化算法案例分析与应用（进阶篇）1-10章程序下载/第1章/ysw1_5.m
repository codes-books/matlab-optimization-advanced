clc,clear,close all
warning off                         	% ��������
feature jit off                       	% ���ٴ���ִ��
% ����������ݼ�
randn('seed',0);
m = [1 -1]; S = [1.1 0.740630; 0.740630 0.87];    % ��ʼ��
X = mvnrnd(m,S,50)';    				     % ������Ӳ�����
% �����Ȼ���ƣ����о�ֵ��Э�������
[m_hat, S_hat]=Gaussian_ML_estimate(X)

clc,clear,close all                    % �������幤�������رմ���
warning off                         % ��������
feature jit off                        % ���ٴ���ִ��
P1=0.5;   % ��ʼ��
P2=0.5;    % ��ʼ��
m1=[0.1 1.1]';    % ��ʼ��
m2=[1.3 0.2]';    % ��ʼ��
S=eye(2);    % ��ʼ��
x=[1.5 1.5]';   % ��ʼ��
p1=P1*comp_gauss_dens_val(m1,S,x)  % ��˹�����ܶȷֲ���������
p2=P2*comp_gauss_dens_val(m2,S,x)  % ��˹�����ܶȷֲ���������

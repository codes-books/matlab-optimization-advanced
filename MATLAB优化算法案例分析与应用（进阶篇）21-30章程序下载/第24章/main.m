% �������������㷨
clc,clear,close all
warning off
feature jit off
 N=50;           % �������������ܸ��壩
 max_it=1000;    % ����������
 ElitistCheck=1; % ElitistCheck: �㷨ִ�д���ѡ��
 Rpower=1;       % Rpower: 'R'�Ĵη�
 min_flag=1;     % 1: ������Сֵ��0���������ֵ
 F_index=1;      % ����⺯��ѡ��
 [Fbest,Lbest,BestChart,MeanChart]=GSA(F_index,N,max_it,ElitistCheck,min_flag,Rpower);
 %  ���:
% Fbest: ������Ӧ��ֵ.
% Lbest: ���Ž�����
% BestChart: ��Ӧ�ȱ仯ֵ.
% MeanChart: ƽ����Ӧ�ȱ仯ֵ
 Fbest,  % ������Ӧ��ֵ
 Lbest,  % ���Ž�
%% ������Ӧ������
figure('color',[1,1,1])
plot(BestChart,'linewidth',2),
xlabel('\fontsize{12}\bf Iteration');ylabel('\fontsize{12}\bf ������Ӧ��ֵ');
legend('\fontsize{10}\bf GSA',1);
grid on
figure('color',[1,1,1])
plot(MeanChart,'linewidth',2),
xlabel('\fontsize{12}\bf Iteration');ylabel('\fontsize{12}\bf ƽ����Ӧ��ֵ');
legend('\fontsize{10}\bf GSA',1);
grid on


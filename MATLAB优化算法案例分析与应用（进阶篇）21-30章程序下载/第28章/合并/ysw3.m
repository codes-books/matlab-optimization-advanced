%% �Ľ���GA
%% ��ջ�������
clc,clear,close all % ��������ռ�
warning off      % ��������
feature jit off  % ���ٴ���ִ��
ysw1
hold on
ysw2
%% �Ľ����Ŵ��㷨������� 
plot(1:length(trace),trace(:,1),'b--');
title(['��Ӧ������  ' '��ֹ������' num2str(maxgen)]);
xlabel('��������');   ylabel('��Ӧ��');
legend('fz�����Ӧ��');
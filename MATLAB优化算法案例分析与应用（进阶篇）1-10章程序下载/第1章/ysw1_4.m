clc,clear,close all
warning off
% ŷ�Ͼ��������
x=[0.34 0.25 0.34]';   				% ��ʼ��
m1=[0 0 0]';     				% ��ʼ��
m2=[1.2 1.2 1.2]'; 				% ��ʼ��
m=[m1 m2];
z=euclidean_classifier(m,x)

%%
clc,clear,close all                    % �������幤�������رմ���
warning off                         % ��������
feature jit off                        % ���ٴ���ִ��
% ���Ͼ��������
x=[0.34 0.25 0.34]';   				% ��ʼ��
m1=[0 0 0]';     				% ��ʼ��
m2=[1.2 1.2 1.2]'; 				% ��ʼ��
m=[m1 m2];
S=[1.1 0.063 0.063;     % ��ʼ��
   0.063 0.74 0.063; 
   0.063 0.063 0.74];
z=mahalanobis_classifier(m,S,x)    % ���Ͼ������





clc,clear,close all                    % �������幤�������رմ���
warning off                         % ��������
feature jit off                        % ���ٴ���ִ��
m=[0.0 0.1]'; S=[1,0;1,1];                  % ��ʼ��
x1=[0.12 0.012]'; x2=[0.2 -0.3]';
pg1=comp_gauss_dens_val(m,S,x1)  % ��˹�����ܶȷֲ���������
pg2=comp_gauss_dens_val(m,S,x2)  % ��˹�����ܶȷֲ���������


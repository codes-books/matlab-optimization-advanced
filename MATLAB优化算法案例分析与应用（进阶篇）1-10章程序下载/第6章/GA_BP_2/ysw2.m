%% �ܻط���
%% ��ջ�������
clc,clear,close all
load('data2_GA_BP.mat')   % �Ŵ��㷨+BP
load('data2_GA_BP_test_result.mat')  % �Ŵ��㷨+BP
load('error_hg_2.mat')    %�ع������ 
figure('color',[1,1,1])
%     error(38) = 0;
    plot(error,'linewidth',2)
    xlabel('���error')
figure('color',[1,1,1])
    plot(output_test,'r','linewidth',2)
    hold on
    test_simu(38)=output_test(38);
    plot(test_simu,'linewidth',2)
    xlabel('ʱ���');ylabel('ͨ����')
    legend('ԭʼ�ź�','GA _ BPԤ��')
figure('color',[1,1,1])
    plot(error,'r','linewidth',2)
    hold on
    plot(error_hg_2,'linewidth',2)
    xlabel('���error')
    legend('GA _ BPԤ�����','�ع�Ԥ�����')
    mse_GA_BP = mse(error)
    mean_GA_BP =mean(abs(error))
    mse_hg = mse(error_hg_2)
    mean_hg =mean(abs(error_hg_2))
    
    
    
    
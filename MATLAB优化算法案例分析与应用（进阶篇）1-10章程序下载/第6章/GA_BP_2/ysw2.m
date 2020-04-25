%% 总回风巷
%% 清空环境变量
clc,clear,close all
load('data2_GA_BP.mat')   % 遗传算法+BP
load('data2_GA_BP_test_result.mat')  % 遗传算法+BP
load('error_hg_2.mat')    %回归分析的 
figure('color',[1,1,1])
%     error(38) = 0;
    plot(error,'linewidth',2)
    xlabel('误差error')
figure('color',[1,1,1])
    plot(output_test,'r','linewidth',2)
    hold on
    test_simu(38)=output_test(38);
    plot(test_simu,'linewidth',2)
    xlabel('时间点');ylabel('通风量')
    legend('原始信号','GA _ BP预测')
figure('color',[1,1,1])
    plot(error,'r','linewidth',2)
    hold on
    plot(error_hg_2,'linewidth',2)
    xlabel('误差error')
    legend('GA _ BP预测误差','回归预测误差')
    mse_GA_BP = mse(error)
    mean_GA_BP =mean(abs(error))
    mse_hg = mse(error_hg_2)
    mean_hg =mean(abs(error_hg_2))
    
    
    
    
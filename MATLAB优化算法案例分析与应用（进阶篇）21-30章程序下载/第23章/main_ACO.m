%% 基于蚁群算法ACO的函数优化分析
% Designed by Yu Shengwei, From SWJTU University, 2014 08 12
clc         % 清屏
clear all;  % 删除workplace变量
close all;  % 关掉显示图形窗口
warning off
tic;        % 计时开始

%% 取值范围
popmax = 5;                 % 待寻优阈值最大取值初始化
popmin = -5;                % 待寻优阈值最小取值初始化

%% 蚁群算法ACO参数初始化
Ant = 100;    % 蚂蚁数量
Times = 100; % 蚂蚁移动次数
Rou = 0.8;   % 信息素挥发系数
P0 = 0.2;    % 转移概率常数

%% 产生初始粒子和速度
for i=1:Ant
    % 随机产生一个种群
    for j = 1: 2
        pop(i,j) = (rand(1,1) * ( popmax-popmin ) + popmin );  % 初始种群个体
    end
    % 计算适应度
    fitness(i) = Fitness_ACO( pop(i,:), 'aco');   % 染色体的适应度
end

% 找最好的染色体
[bestfitness bestindex]=min(fitness); % 最大适应度值
zbest = pop(bestindex,:);             % 全局最佳
gbest = pop;                          % 个体最佳
fitnessgbest = fitness;               % 个体最佳适应度值
fitnesszbest = bestfitness;           % 全局最佳适应度值

%% 迭代寻优
for T = 1:Times   
     disp(['迭代次数:   ',num2str(T)])        % 迭代次数

    lamda = 1/T;                               % 随着迭代次数进行，蚂蚁信息素挥发参数
    [bestfitness, bestindex]=min(fitness);     % 找最好的适应度值
    ysw(T) = bestfitness;                      % 存储最好的适应度值
    for i=1:Ant
        P(T,i)=(fitness(bestindex)-fitness(i))/fitness(bestindex);  % 计算状态转移概率
    end
    % 蚂蚁个体更新
    for i=1:Ant
        if P(T,i)<P0  % 局部搜索
            temp(i,:) = pop(i,:)+(2*rand-1)*lamda;
        else          % 全局搜索
            temp(i,:) = pop(i,:)+(popmax-popmin)*(rand-0.5);
        end
        % 越界处理
        temp(i,find(temp(i,:)>popmax))=popmax;
        temp(i,find(temp(i,:)<popmin))=popmin;
        % 判断蚂蚁是否移动
        if Fitness_ACO( temp(i,:), 'aco') < Fitness_ACO(pop(i,:), 'aco')  % 判断蚂蚁是否移动
            pop(i,:) = temp(i,:);
        end
    end
    % 更新信息量
    for i=1:Ant
        fitness(i) = (1-Rou)*fitness(i) + Fitness_ACO(pop(i,:), 'aco');  % 更新信息量
    end
    
    ysw(T) = min(fitness);                      % 存储最好的适应度值
end
[max_value,max_index] = min(fitness); % 最大适应度值
zbest = pop(max_index,:);

%% 清除变量
clear Ant i T Rou p P0 lamda popmax popmin j N_PAR P V gbest max_index
clear Lmax level fitnessgbest fitnesszbest bestfitness bestindex fitnessgbest
%% 结果输出
fitnessbest = max_value      % 返回最优阈值
zbest                        % 最佳个体值
time = toc                   % 返回CPU计算时间
figure('color',[1,1,1])
plot(ysw(2:end),'r*-')
xlabel('迭代次数');ylabel('最优适应度值')





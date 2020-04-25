%% 改进的GA
%% 清空环境变量
clc,clear,close all % 清除变量空间
warning off      % 消除警告
feature jit off  % 加速代码执行
%% 遗传算法参数初始化
maxgen = 50;                      % 进化代数，即迭代次数
sizepop = 50;                     % 种群规模
pcross = [0.7];                    % 交叉概率选择，0和1之间
pmutation = [0.01];                 % 变异概率选择，0和1之间
delta = 0.1;
% 城市交通信号系统参数
C = 140;
L = 10;
load('data.mat')  % 包含交通流量q以及饱和流量xij
q = q./3600;      % 转化为秒s
xij = xij./3600;  % 转化为秒s
%染色体设置
lenchrom=ones(1,3);    % t1、t2、t3
bound=[38,59;26,37;33,44;];   % 数据范围
%---------------------------种群初始化------------------------------------
individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  %将种群信息定义为一个结构体
avgfitness = [];                      %每一代种群的平均适应度
bestfitness = [];                     %每一代种群的最佳适应度
bestchrom = [];                       %适应度最好的染色体

%% 初始化种群
for i=1:sizepop
    % 随机产生一个种群
    individuals.chrom(i,:)=Code(lenchrom,bound); % 编码（binary和grey的编码结果为一个实数，float的编码结果为一个实数向量）
    x=individuals.chrom(i,:);
    % 计算适应度
    individuals.fitness(i)=fun(x);   % 染色体的适应度 
end

%% 找最好的染色体
[bestfitness bestindex] = min(individuals.fitness);
bestchrom = individuals.chrom(bestindex,:);    % 最好的染色体
% 记录每一代进化中最好的适应度和平均适应度
trace = [bestfitness]; 

%% 迭代求解最佳初始阀值和权值
% 进化开始
for i=1:maxgen
    disp(['迭代次数：  ',num2str(i)])
    % 选择
    individuals=Select(individuals,sizepop); 
    % 交叉
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop,bound);
    % 变异
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,i,maxgen,bound);

    % 计算适应度
    for j=1:sizepop
        x=individuals.chrom(j,:);        % 解码
        individuals.fitness(j)=fun(x);   % 染色体的适应度 
    end
    fmax = max(individuals.fitness);     % 适应度最大值
    fmin = min(individuals.fitness);     % 适应度最小值
    favg = mean(individuals.fitness);  % 适应度平均值
    individuals.fitness = (individuals.fitness + abs(fmin))./(fmax+fmin+delta); %适应度标定
    
    % 找到最小和最大适应度的染色体及它们在种群中的位置
    [newbestfitness,newbestindex]=min(individuals.fitness);
    [worestfitness,worestindex]=max(individuals.fitness);
    % 代替上一次进化中最好的染色体
    if bestfitness>newbestfitness
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom; % 剔除最差个体
    trace=[trace;bestfitness]; %记录每一代进化中最好的适应度
end
x = [bestchrom, C-L-sum(sum(bestchrom))]       % 最佳个体值
D = fun(bestchrom)     % 延误误差D
E = D./sum(sum(q));     % 平均延误E

%% 遗传算法结果分析 
figure('color',[1,1,1]),
plot(1:length(trace),trace(:,1),'b--');
title(['适应度曲线  ' '终止代数＝' num2str(maxgen)]);
xlabel('进化代数');   ylabel('适应度');
legend('fz最佳适应度');

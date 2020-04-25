%% GA
%% 清空环境变量
clc,clear,close all
warning off
global PP C L m f p Tmin Tmax delta tt Q cita
% 帮助网页
% web('http://item.taobao.com/item.htm?spm=a1z10.1.w4004-4202734246.26.7yUiz0&id=36616131138')
% web('http://item.taobao.com/item.htm?_u=o1lm43im7fd2&id=39306172095')

%% 遗传算法参数初始化
maxgen = 10;                        % 进化代数，即迭代次数
sizepop = 30;                       % 种群规模
pcross = 0.8;                       % 交叉概率选择，0和1之间
pmutation = 0.2;                    % 变异概率选择，0和1之间
%染色体设置
lenchrom=ones(1,500);  

% 模型参数设置
Tmin = 1;   % 表示相邻车辆间发车间隔的最小值(min)
Tmax = 10;  % 表示相邻车辆间发车间隔的最大值(min)
delta = 4;  % 表示相邻车辆发车间隔之差的限制值
m = 500;    % 表示总的发车次数(车次)
maxt = 960;    % t(i)的最大值
PP = 1;    % 表示统一票价(元/人)
C = 3.5;   % 表示车辆运营的单位损耗成本(元/车.公里)
L = 26.5;  % 表示调研线路总的长度(公里)
m = 500;   % 表示总的发车次数(车次)
f = 2;     % 表示乘务员人数
p = 10;    % 表示乘务员工资
V = 20;    % 运行速度
tt = L/V;
Q = 100;      % 表示车容量表示满载时车辆的容量(人/车)
cita = 0.8;   % 表示各车的平均期望满载率

%---------------------------种群初始化------------------------------------
individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  % 将种群信息定义为一个结构体
bestfitness = [];                     % 每一代种群的最佳适应度
bestchrom = [];                       % 适应度最好的染色体

%% 初始化种群
for i=1:sizepop
    % 随机产生一个种群
    individuals.chrom(i,:) = pop_meet_conditions(maxt); % 编码结果为一个实数向量）
    x=individuals.chrom(i,:);
    % 计算适应度
    individuals.fitness(i)=fun(x);   % 染色体的适应度 
end

figure('color',[1,1,1]),
plot(1:length(x),x,'b--','linewidth',2);
title(['初始个体值  ' '终止代数＝' num2str(maxgen)]);
xlabel('进化代数');   ylabel('初始个体值');
legend('初始个体值');

%% 找最好的染色体
[bestfitness bestindex] = max(individuals.fitness);
bestchrom = individuals.chrom(bestindex,:);    % 最好的染色体
% 记录每一代进化中最好的适应度
trace = [bestfitness]; 

%% 迭代求解最佳初始阀值和权值
% 进化开始
for i=1:maxgen
    disp(['迭代次数：  ',num2str(i),'     最大迭代次数:      ',num2str(maxgen)])
    % 选择
    individuals=Select(individuals,sizepop); 
    % 交叉
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop);
    % 变异
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,i,maxgen);
    
    % 计算适应度
    for j=1:sizepop
        x=individuals.chrom(j,:); % 解码
        [individuals.fitness(j)]=fun(x);   % 染色体的适应度 
    end

    % 找到最小和最大适应度的染色体及它们在种群中的位置
    [newbestfitness,newbestindex]=max(individuals.fitness);
    [worestfitness,worestindex]=min(individuals.fitness);
    % 代替上一次进化中最好的染色体
    if bestfitness<newbestfitness
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom;
    individuals.fitness(worestindex)=bestfitness;
    trace=[trace;bestfitness]; %记录每一代进化中最好的适应度和平均适应度

end
%% 输出结果
x = bestchrom;   % 最佳个体值, tt的500个值，1x500
%% 遗传算法结果分析 
figure('color',[1,1,1]),
plot(1:length(x),x,'b--','linewidth',2);
title(['最优个体值  ' '终止代数＝' num2str(maxgen)]);
xlabel('进化代数');   ylabel('最优个体值');
legend('最优个体值');

figure('color',[1,1,1]),
plot(1:length(trace),trace,'b.--','linewidth',2,'Markersize',20);
title(['适应度曲线  ' '终止代数＝' num2str(maxgen)]);
xlabel('进化代数');   ylabel('适应度');
legend('最佳适应度');

% 统计发车频率
sj = 30; % 30表示半个小时，30分钟
tablef = zeros(1,maxt/sj);  
for i=1:maxt/sj
    for j=1:length(x)
        if x(j)<=sj*i&&x(j)>sj*(i-1)
            tablef(i) = tablef(i) + 1;
        end
    end
end
figure('color',[1,1,1]),
plot(1:length(tablef),tablef,'b.--','linewidth',2,'Markersize',20);
xlabel('时间');   ylabel('发车频率');
X1 = 1:length(tablef); Y1 = tablef;
createfigure(X1, Y1);    % 平滑曲线拟合
axis([0,35,0,35])




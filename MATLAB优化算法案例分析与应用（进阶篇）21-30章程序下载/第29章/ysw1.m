%% DE
%% 清空环境变量
clc,clear,close all
warning off
feature jit off
F0 = 0.5;  % 是变异率    
Gm = 100;  % 最大迭代次数
Np = 100;  % 种群规模
CR = 0.9;  % 杂交参数
G = 1;     % 初始化代数
N = 10;    % 所求问题的维数，即待求解未知数个数
ge = zeros(1,Np);    % 各代的最优目标函数值
bestx = zeros(Np,N); % 各代的最优解
% 解范围
xmin = -5.12; % 下限
xmax = 5.12;  % 上限
% 产生初始种群
X0 = (xmax-xmin)*rand(Np,N)+xmin;
X = X0;
% 候选解初始化
X1new = zeros(Np,N);  % 初始化
X1_new = zeros(Np,N); % 初始化
X1 = zeros(Np,N);     % 初始化
value = zeros(1,Np);  % 初始化
while G<=Gm   % 迭代开始
    disp(['迭代次数：  ',num2str(G)])
    
    for i=1:Np
        %产生j,k,p三个不同的数
        a=1;b = Np;
        dx = randperm(b-a+1)+a-1;
        j=dx(1);k=dx(2);p=dx(3);
        if j==i
            j=dx(4);
        elseif k==i
            k=dx(4);
        elseif p==i
            p=dx(4);
        end

        % 变异算子
        namd=exp(1-Gm/(Gm+1-G));
        F=F0*2.^namd;

        bon = X(p,:)+F*(X(j,:)-X(k,:)); % 个体更新
        if (bon>xmin)&(bon<xmax)        % 防止变异超出边界
            X1new(i,:)=bon;
        else
            X1new(i,:)=(xmax-xmin)*rand(1,N)+xmin;
        end
    end
    % 杂交操作
    for i=1:Np
        if rand>CR   % 利用二项分布来交叉
            X1_new(i,:)= X(i,:);
        else
            X1_new(i,:) = X1new(i,:);
        end
    end
    % 竞争操作
    for i=1:Np
        if fitness(X1_new(i,:))<fitness(X(i,:))
            X1(i,:)=X1_new(i,:);
        else 
            X1(i,:)=X(i,:);
        end
    end
   % 找出最小值
    for i=1:Np
        value(i)=fitness(X1(i,:));
    end
    [fmin,nmin]=min(value);
    ge(G)=fmin;
    bestx(G,:) = X1(nmin,:); 
    G=G+1;
    X = X1;
end
bestx(end,:)  % 函数最优解
ge(end)

%% 差分进化算法结果分析 
figure('color',[1,1,1]),
plot(1:length(ge),ge,'b--');
title(['适应度曲线  ' '终止代数＝' num2str(Gm)]);
xlabel('进化代数');   ylabel('适应度');
legend('最佳适应度');


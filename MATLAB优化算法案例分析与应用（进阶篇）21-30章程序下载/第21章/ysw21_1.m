clc,clear,close all
warning off
N = 40; % 种群个数
c1 = 2; % 粒子群参数
c2 = 2; % 粒子群参数
wmax = 0.9; % 最大权重
wmin = 0.6; % 最小权重
M = 100;    % 循环迭代步数
D = 2;      % 种群中个体个数,2个未知数
format long;
%------初始化种群的个体------------
for i=1:N
    for j=1:D
        x(i,j)=rands(1);  %随机初始化位置
        v(i,j)=rands(1);  %随机初始化速度
    end
end

%% ------先计算各个粒子的适应度----------------------
for i=1:N
    p(i)=fitness(x(i,:));
    y(i,:)=x(i,:);
end

pg=x(N,:);             % Pg为全局最优
for i=1:(N-1)
    if fitness(x(i,:))<fitness(pg)
        pg=x(i,:);
    end
end

%% ------进入主要循环------------
for t=1:M

    for j=1:N
        fv(j) = fitness(x(j,:));  % 适应度值
    end
    fvag = sum(fv)/N;   % 平均适应度值
    fmin = min(fv);     % 最小适应度值
    for i=1:N
        if fv(i) <= fvag
            w = wmin + (fv(i)-fmin)*(wmax-wmin)/(fvag-fmin);  % 自适应权值
        else
            w = wmax;   % 权值
        end
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:)); % 速度更新
        x(i,:)=x(i,:)+v(i,:);    % 个体更新
        if x(i,1)>1||x(i,1)<-1
            x(i,1)=rands(1);
        end
        if x(i,2)>1||x(i,2)<-1
            x(i,2)=rands(1);
        end
        if fitness(x(i,:))<p(i)  % 适应度值更新
            p(i)=fitness(x(i,:));
            y(i,:)=x(i,:);
        end

        if p(i)<fitness(pg)
            pg=y(i,:);
        end
    end
    Pbest(t)=fitness(pg);
end
r=[1:1:100];
plot(r,Pbest,'r--','linewidth',2);
xlabel('迭代次数'),ylabel('适应度值')
title('自适应权重PSO算法')
hold on
xm = pg'
fv = fitness(pg)

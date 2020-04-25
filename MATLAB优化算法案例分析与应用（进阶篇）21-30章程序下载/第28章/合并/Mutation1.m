function ret=Mutation1(pmutation,lenchrom,chrom,sizepop,num,maxgen,bound)
% 本函数完成变异操作
% pcorss                input  : 变异概率
% lenchrom              input  : 染色体长度
% chrom     input  : 染色体群
% sizepop               input  : 种群规模
% opts                  input  : 变异方法的选择
% pop                   input  : 当前种群的进化代数和最大的进化代数信息
% bound                 input  : 每个个体的上届和下届
% maxgen                input  ：最大迭代次数
% num                   input  : 当前迭代次数
% ret                   output : 变异后的染色体
k1 = 0.6;   k2 = 0.7;
k3 = 0.001; k4 = 0.01;
% 计算适应度
for j=1:sizepop
    x=chrom(j,:);    % 解码
    f(j)=fun1(x);     % 染色体的适应度 
end
fmax = max(f);      % 适应度最大值
fmin = min(f);      % 适应度最小值
favg = mean(f);     % 适应度平均值

for i=1:sizepop   %每一轮for循环中，可能会进行一次变异操作，染色体是随机选择的，变异位置也是随机选择的，
    %但该轮for循环中是否进行变异操作则由变异概率决定（continue控制）
    % 随机选择一个染色体进行变异
    pick=rand;
    while pick==0
        pick=rand;
    end
    index=ceil(pick*sizepop);
    
     f1 = fun1( chrom(index(1),:) );  % 个体适应度值
     f3 = max(f1);                   % 两者中大者
     if f3>=favg
         pmutation = k3*(fmax - f3)./(fmax-favg);
     else
         pmutation = k4;
     end
    
    % 变异概率决定该轮循环是否进行变异
    pick=rand;
    if pick>pmutation
        continue;
    end
    flag=0;
    num = 0;
    chrom1 = chrom(i,:);
    while flag==0&&num<=20 
        % 变异位置
        pick=rand;
        while pick==0      
            pick=rand;
        end
        pos=ceil(pick*sum(lenchrom));  %随机选择了染色体变异的位置，即选择了第pos个变量进行变异
    
        pick=rand; %变异开始     
        fg=(rand*(1-num/maxgen))^2;
        if pick>0.5
            chrom(i,pos)=chrom(i,pos)+(bound(pos,2)-chrom(i,pos))*fg;
        else
            chrom(i,pos)=chrom(i,pos)-(chrom(i,pos)-bound(pos,1))*fg;
        end   %变异结束
        flag=test(lenchrom,bound,chrom(i,:));     %检验染色体的可行性
         num = num+1;  % 检验次数设置
    end
    if num>20         % 如果大于20次，则不变异
        chrom(i,:) = chrom1;
    end
end
ret=chrom;
%% 总回风巷
%% 清空环境变量
clc,clear,close all
%% 训练数据预测数据提取及归一化
%下载输入输出数据
load data2.mat; % 原始数据以列向量的方式存放在workplace文件中
data =data2;    % 赋值
n=size(data);
input=data(:,3:6);  % 作为输入
output=data(:,2);   % 作为目标向量
%节点个数
inputnum=4;
hiddennum=7;
outputnum=1;

%训练数据和预测数据
input_train=input(1:n(1,1),:)';
input_test=input(1:n(1,1),:)';
output_train=output(1:n(1,1))';
output_test=output(1:n(1,1))';

%选连样本输入输出数据归一化
[inputn,inputps]=mapminmax(input_train);
[outputn,outputps]=mapminmax(output_train);

%构建网络
nntwarn off
net=newff(inputn,outputn,hiddennum);

%% 遗传算法参数初始化
maxgen=10;                          %进化代数，即迭代次数
sizepop=50;                         %种群规模
pcross=[0.3];                       %交叉概率选择，0和1之间
pmutation=[0.1];                    %变异概率选择，0和1之间

%节点总数
numsum=inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum;

lenchrom=ones(1,numsum);        
bound=[0.1*ones(numsum,1) 20*ones(numsum,1)];    %数据范围

%------------------------------------------------------种群初始化--------------------------------------------------------
individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  %将种群信息定义为一个结构体
avgfitness=[];                      %每一代种群的平均适应度
bestfitness=[];                     %每一代种群的最佳适应度
bestchrom=[];                       %适应度最好的染色体
%初始化种群
for i=1:sizepop
    %随机产生一个种群
    individuals.chrom(i,:)=Code(lenchrom,bound);    %编码（binary和grey的编码结果为一个实数，float的编码结果为一个实数向量）
    x=individuals.chrom(i,:);
    %计算适应度
    individuals.fitness(i)=fun(x,inputnum,hiddennum,outputnum,net,inputn,outputn);   %染色体的适应度
end

%找最好的染色体
[bestfitness bestindex]=min(individuals.fitness);
bestchrom=individuals.chrom(bestindex,:);  %最好的染色体
avgfitness=sum(individuals.fitness)/sizepop; %染色体的平均适应度
% 记录每一代进化中最好的适应度和平均适应度
trace=[avgfitness bestfitness]; 
 
%% 迭代求解最佳初始阀值和权值
% 进化开始
for i=1:maxgen
    i
    % 选择
    individuals=Select(individuals,sizepop); 
    avgfitness=sum(individuals.fitness)/sizepop;
    %交叉
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop,bound);
    % 变异
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,i,maxgen,bound);
    
    % 计算适应度 
    for j=1:sizepop
        x=individuals.chrom(j,:); %解码
        individuals.fitness(j)=fun(x,inputnum,hiddennum,outputnum,net,inputn,outputn);   
    end
    
  %找到最小和最大适应度的染色体及它们在种群中的位置
    [newbestfitness,newbestindex]=min(individuals.fitness);
    [worestfitness,worestindex]=max(individuals.fitness);
    % 代替上一次进化中最好的染色体
    if bestfitness>newbestfitness
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom;
    individuals.fitness(worestindex)=bestfitness;
    
    avgfitness=sum(individuals.fitness)/sizepop;
    
    trace=[trace;avgfitness bestfitness]; %记录每一代进化中最好的适应度和平均适应度

end
%% 遗传算法结果分析 
figure('color',[1,1,1]),
[r c]=size(trace);
plot([1:r]',trace(:,2),'b--');
title(['适应度曲线  ' '终止代数＝' num2str(maxgen)]);
xlabel('进化代数');ylabel('适应度');
legend('平均适应度','最佳适应度');
disp('适应度                   变量');
x=bestchrom;

%% 把最优初始阀值权值赋予网络预测
% %用遗传算法优化的BP网络进行值预测
w1=x(1:inputnum*hiddennum);
B1=x(inputnum*hiddennum+1:inputnum*hiddennum+hiddennum);
w2=x(inputnum*hiddennum+hiddennum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum);
B2=x(inputnum*hiddennum+hiddennum+hiddennum*outputnum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum);

net.iw{1,1}=reshape(w1,hiddennum,inputnum);
net.lw{2,1}=reshape(w2,outputnum,hiddennum);
net.b{1}=reshape(B1,hiddennum,1);
net.b{2}=B2;

%% BP网络训练
%网络进化参数
net.trainParam.epochs=100;
net.trainParam.lr=0.1;
%net.trainParam.goal=0.00001;
%网络训练
[net,per2]=train(net,inputn,outputn);

%% BP网络预测
%数据归一化
inputn_test=mapminmax('apply',input_test,inputps);
an=sim(net,inputn_test);
test_simu=mapminmax('reverse',an,outputps);
error=test_simu-output_test;
save data2_GA_BP test_simu output_test error
%% 寻优分析
Up=0.5:0.05:0.85;    %作为瓦斯输入
Utp=6.5:0.1:9.1;   %作为煤尘输入
Ut=13:0.5:19;      %作为温度输入
Us = 12:0.5:19;    %作为适度输入

n1=size(Up);
n2=size(Utp);
n3=size(Ut);
n4 = size(Us);

sum_count = n1(1,2)*n2(1,2)*n3(1,2)*n4(1,2);
count = 0;

m=1;
for i=1:n1(1,2)
    for j=1:n2(1,2)
        for k=1:n3(1,2)
            for kk = 1:n4(1,2)
                count = count+1   %计数
                input_rand=[Up(1,i),Utp(1,j),Ut(1,k),Us(1,kk)]';
                inputn_result=mapminmax('apply',input_rand,inputps);
                result=sim(net,inputn_result);
                test_result(m,1:4)=input_rand;
                test_result(m,5)=mapminmax('reverse',result,outputps); 
                m=m+1;
            end
        end
    end
end
%% GA_BP_min
% 瓦斯 + 煤尘 + 温度 + 湿度 + 最优风速
[a,b]=min(test_result(:,5) + test_result(:,1) +test_result(:,2) );
actual_result=test_result(b,:);% 得到预测最小值
save data2_GA_BP_test_result.mat test_result actual_result

%%
load('data2_GA_BP.mat')
load('data2_GA_BP_test_result.mat')


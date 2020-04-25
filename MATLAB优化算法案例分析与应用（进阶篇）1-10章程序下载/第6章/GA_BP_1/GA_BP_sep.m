%% GA_BP图像分割
%% 清空环境变量
clc,clear,close all
warning off
%% 训练数据预测数据提取及归一化
%下载输入输出数据
load('data.mat');          % 原始数据以列向量的方式存放在workplace文件中
%% 构造训练样本
im_sep = MRI_pic(30);      % 选取第30张图像，train 输入样本, 选为30
% 获取输出数据output
lev2 = 50/255;                    % 阈值
L = zeros(size(im_sep));          % 0 = 背景
L(im_sep<lev2 & im_sep>0) = 2;    % 2 = 灰质
L(im_sep>=lev2) = 3;              % 3 = 白质
L = mat2gray(L);      
% figure,imshow(L);title('灰白质分割图')
% 训练样本
nd = size(im_sep);       % 数据大小
input_train = reshape(im_sep,nd(1,1)*nd(1,2),1)';  % 作为输入
output_train = reshape(L,nd(1,1)*nd(1,2),1)';      % 作为目标向量

%% 测试样本
num = 20;                          % num取值 13--31之间
im_sep_test = MRI_pic(num);        % 提取num张图像，test 输入样本, 测试样本
nd_test = size(im_sep_test);       % 数据大小
input_test = reshape(im_sep_test,nd_test(1,1)*nd_test(1,2),1)';  % 作为输入测试

%% BP网络设置
%节点个数
inputnum  = 1;
hiddennum = 7;
outputnum = 1;

%构建网络
nntwarn off
net=newff(input_train,output_train,hiddennum);

%% 遗传算法参数初始化
maxgen = 5;                          %进化代数，即迭代次数
sizepop = 5;                         %种群规模
pcross = [0.3];                       %交叉概率选择，0和1之间
pmutation = [0.1];                    %变异概率选择，0和1之间

%节点总数
numsum=inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum;

lenchrom=ones(1,numsum);        
bound=[0*ones(numsum,1) 3*ones(numsum,1)];    %数据范围

%------------------------------------------------------种群初始化--------------------------------------------------------
individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  %将种群信息定义为一个结构体
avgfitness = [];                      %每一代种群的平均适应度
bestfitness = [];                     %每一代种群的最佳适应度
bestchrom = [];                       %适应度最好的染色体
%初始化种群
for i=1:sizepop
    %随机产生一个种群
    individuals.chrom(i,:)=Code(lenchrom,bound); %编码（binary和grey的编码结果为一个实数，float的编码结果为一个实数向量）
    x=individuals.chrom(i,:);
    %计算适应度
    individuals.fitness(i)=fun(x,inputnum,hiddennum,outputnum,net,input_train,output_train);   %染色体的适应度
end

%找最好的染色体
[bestfitness bestindex]=min(individuals.fitness);
bestchrom=individuals.chrom(bestindex,:);    % 最好的染色体
avgfitness=sum(individuals.fitness)/sizepop; % 染色体的平均适应度
%记录每一代进化中最好的适应度和平均适应度
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
        individuals.fitness(j)=fun(x,inputnum,hiddennum,outputnum,net,input_train,output_train);   
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
xlabel('进化代数');   ylabel('适应度');
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
net.trainParam.epochs=10;
net.trainParam.lr=0.1;
%net.trainParam.goal=0.00001;
%网络训练
[net,per2]=train(net,input_train,output_train);

%% BP网络预测
[net,per2] = train(net,input_train,output_train);
output_test_simu = sim(net,input_test);  % BP预测
im = reshape(output_test_simu,nd_test(1,1),nd_test(1,2));
%画图显示
figure,imshow(im);title('基于BP神经网络的灰白质分割图')
figure,imshow(im_sep_test);title('MRI大脑图像')


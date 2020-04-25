%% �Ľ���GA
%% ��ջ�������
clc,clear,close all % ��������ռ�
warning off      % ��������
feature jit off  % ���ٴ���ִ��
%% �Ŵ��㷨������ʼ��
maxgen = 50;                      % ��������������������
sizepop = 50;                     % ��Ⱥ��ģ
pcross = [0.7];                    % �������ѡ��0��1֮��
pmutation = [0.01];                 % �������ѡ��0��1֮��
delta = 0.1;
% ���н�ͨ�ź�ϵͳ����
C = 140;
L = 10;
load('data.mat')  % ������ͨ����q�Լ���������xij
q = q./3600;      % ת��Ϊ��s
xij = xij./3600;  % ת��Ϊ��s
%Ⱦɫ������
lenchrom=ones(1,3);    % t1��t2��t3
bound=[38,59;26,37;33,44;];   % ���ݷ�Χ
%---------------------------��Ⱥ��ʼ��------------------------------------
individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  %����Ⱥ��Ϣ����Ϊһ���ṹ��
avgfitness = [];                      %ÿһ����Ⱥ��ƽ����Ӧ��
bestfitness = [];                     %ÿһ����Ⱥ�������Ӧ��
bestchrom = [];                       %��Ӧ����õ�Ⱦɫ��

%% ��ʼ����Ⱥ
for i=1:sizepop
    % �������һ����Ⱥ
    individuals.chrom(i,:)=Code(lenchrom,bound); % ���루binary��grey�ı�����Ϊһ��ʵ����float�ı�����Ϊһ��ʵ��������
    x=individuals.chrom(i,:);
    % ������Ӧ��
    individuals.fitness(i)=fun(x);   % Ⱦɫ�����Ӧ�� 
end

%% ����õ�Ⱦɫ��
[bestfitness bestindex] = min(individuals.fitness);
bestchrom = individuals.chrom(bestindex,:);    % ��õ�Ⱦɫ��
% ��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��
trace = [bestfitness]; 

%% ���������ѳ�ʼ��ֵ��Ȩֵ
% ������ʼ
for i=1:maxgen
    disp(['����������  ',num2str(i)])
    % ѡ��
    individuals=Select(individuals,sizepop); 
    % ����
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop,bound);
    % ����
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,i,maxgen,bound);

    % ������Ӧ��
    for j=1:sizepop
        x=individuals.chrom(j,:);        % ����
        individuals.fitness(j)=fun(x);   % Ⱦɫ�����Ӧ�� 
    end
    fmax = max(individuals.fitness);     % ��Ӧ�����ֵ
    fmin = min(individuals.fitness);     % ��Ӧ����Сֵ
    favg = mean(individuals.fitness);  % ��Ӧ��ƽ��ֵ
    individuals.fitness = (individuals.fitness + abs(fmin))./(fmax+fmin+delta); %��Ӧ�ȱ궨
    
    % �ҵ���С�������Ӧ�ȵ�Ⱦɫ�弰��������Ⱥ�е�λ��
    [newbestfitness,newbestindex]=min(individuals.fitness);
    [worestfitness,worestindex]=max(individuals.fitness);
    % ������һ�ν�������õ�Ⱦɫ��
    if bestfitness>newbestfitness
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom; % �޳�������
    trace=[trace;bestfitness]; %��¼ÿһ����������õ���Ӧ��
end
x = [bestchrom, C-L-sum(sum(bestchrom))]       % ��Ѹ���ֵ
D = fun(bestchrom)     % �������D
E = D./sum(sum(q));     % ƽ������E

%% �Ŵ��㷨������� 
figure('color',[1,1,1]),
plot(1:length(trace),trace(:,1),'b--');
title(['��Ӧ������  ' '��ֹ������' num2str(maxgen)]);
xlabel('��������');   ylabel('��Ӧ��');
legend('fz�����Ӧ��');

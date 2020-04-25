%% ������Ⱥ�㷨ACO�ĺ����Ż�����
% Designed by Yu Shengwei, From SWJTU University, 2014 08 12
clc         % ����
clear all;  % ɾ��workplace����
close all;  % �ص���ʾͼ�δ���
warning off
tic;        % ��ʱ��ʼ

%% ȡֵ��Χ
popmax = 5;                 % ��Ѱ����ֵ���ȡֵ��ʼ��
popmin = -5;                % ��Ѱ����ֵ��Сȡֵ��ʼ��

%% ��Ⱥ�㷨ACO������ʼ��
Ant = 100;    % ��������
Times = 100; % �����ƶ�����
Rou = 0.8;   % ��Ϣ�ػӷ�ϵ��
P0 = 0.2;    % ת�Ƹ��ʳ���

%% ������ʼ���Ӻ��ٶ�
for i=1:Ant
    % �������һ����Ⱥ
    for j = 1: 2
        pop(i,j) = (rand(1,1) * ( popmax-popmin ) + popmin );  % ��ʼ��Ⱥ����
    end
    % ������Ӧ��
    fitness(i) = Fitness_ACO( pop(i,:), 'aco');   % Ⱦɫ�����Ӧ��
end

% ����õ�Ⱦɫ��
[bestfitness bestindex]=min(fitness); % �����Ӧ��ֵ
zbest = pop(bestindex,:);             % ȫ�����
gbest = pop;                          % �������
fitnessgbest = fitness;               % ���������Ӧ��ֵ
fitnesszbest = bestfitness;           % ȫ�������Ӧ��ֵ

%% ����Ѱ��
for T = 1:Times   
     disp(['��������:   ',num2str(T)])        % ��������

    lamda = 1/T;                               % ���ŵ����������У�������Ϣ�ػӷ�����
    [bestfitness, bestindex]=min(fitness);     % ����õ���Ӧ��ֵ
    ysw(T) = bestfitness;                      % �洢��õ���Ӧ��ֵ
    for i=1:Ant
        P(T,i)=(fitness(bestindex)-fitness(i))/fitness(bestindex);  % ����״̬ת�Ƹ���
    end
    % ���ϸ������
    for i=1:Ant
        if P(T,i)<P0  % �ֲ�����
            temp(i,:) = pop(i,:)+(2*rand-1)*lamda;
        else          % ȫ������
            temp(i,:) = pop(i,:)+(popmax-popmin)*(rand-0.5);
        end
        % Խ�紦��
        temp(i,find(temp(i,:)>popmax))=popmax;
        temp(i,find(temp(i,:)<popmin))=popmin;
        % �ж������Ƿ��ƶ�
        if Fitness_ACO( temp(i,:), 'aco') < Fitness_ACO(pop(i,:), 'aco')  % �ж������Ƿ��ƶ�
            pop(i,:) = temp(i,:);
        end
    end
    % ������Ϣ��
    for i=1:Ant
        fitness(i) = (1-Rou)*fitness(i) + Fitness_ACO(pop(i,:), 'aco');  % ������Ϣ��
    end
    
    ysw(T) = min(fitness);                      % �洢��õ���Ӧ��ֵ
end
[max_value,max_index] = min(fitness); % �����Ӧ��ֵ
zbest = pop(max_index,:);

%% �������
clear Ant i T Rou p P0 lamda popmax popmin j N_PAR P V gbest max_index
clear Lmax level fitnessgbest fitnesszbest bestfitness bestindex fitnessgbest
%% ������
fitnessbest = max_value      % ����������ֵ
zbest                        % ��Ѹ���ֵ
time = toc                   % ����CPU����ʱ��
figure('color',[1,1,1])
plot(ysw(2:end),'r*-')
xlabel('��������');ylabel('������Ӧ��ֵ')





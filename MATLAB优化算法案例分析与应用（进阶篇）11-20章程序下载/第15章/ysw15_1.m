%% GA
%% ��ջ�������
clc,clear,close all
warning off
global PP C L m f p Tmin Tmax delta tt Q cita
% ������ҳ
% web('http://item.taobao.com/item.htm?spm=a1z10.1.w4004-4202734246.26.7yUiz0&id=36616131138')
% web('http://item.taobao.com/item.htm?_u=o1lm43im7fd2&id=39306172095')

%% �Ŵ��㷨������ʼ��
maxgen = 10;                        % ��������������������
sizepop = 30;                       % ��Ⱥ��ģ
pcross = 0.8;                       % �������ѡ��0��1֮��
pmutation = 0.2;                    % �������ѡ��0��1֮��
%Ⱦɫ������
lenchrom=ones(1,500);  

% ģ�Ͳ�������
Tmin = 1;   % ��ʾ���ڳ����䷢���������Сֵ(min)
Tmax = 10;  % ��ʾ���ڳ����䷢����������ֵ(min)
delta = 4;  % ��ʾ���ڳ����������֮�������ֵ
m = 500;    % ��ʾ�ܵķ�������(����)
maxt = 960;    % t(i)�����ֵ
PP = 1;    % ��ʾͳһƱ��(Ԫ/��)
C = 3.5;   % ��ʾ������Ӫ�ĵ�λ��ĳɱ�(Ԫ/��.����)
L = 26.5;  % ��ʾ������·�ܵĳ���(����)
m = 500;   % ��ʾ�ܵķ�������(����)
f = 2;     % ��ʾ����Ա����
p = 10;    % ��ʾ����Ա����
V = 20;    % �����ٶ�
tt = L/V;
Q = 100;      % ��ʾ��������ʾ����ʱ����������(��/��)
cita = 0.8;   % ��ʾ������ƽ������������

%---------------------------��Ⱥ��ʼ��------------------------------------
individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  % ����Ⱥ��Ϣ����Ϊһ���ṹ��
bestfitness = [];                     % ÿһ����Ⱥ�������Ӧ��
bestchrom = [];                       % ��Ӧ����õ�Ⱦɫ��

%% ��ʼ����Ⱥ
for i=1:sizepop
    % �������һ����Ⱥ
    individuals.chrom(i,:) = pop_meet_conditions(maxt); % ������Ϊһ��ʵ��������
    x=individuals.chrom(i,:);
    % ������Ӧ��
    individuals.fitness(i)=fun(x);   % Ⱦɫ�����Ӧ�� 
end

figure('color',[1,1,1]),
plot(1:length(x),x,'b--','linewidth',2);
title(['��ʼ����ֵ  ' '��ֹ������' num2str(maxgen)]);
xlabel('��������');   ylabel('��ʼ����ֵ');
legend('��ʼ����ֵ');

%% ����õ�Ⱦɫ��
[bestfitness bestindex] = max(individuals.fitness);
bestchrom = individuals.chrom(bestindex,:);    % ��õ�Ⱦɫ��
% ��¼ÿһ����������õ���Ӧ��
trace = [bestfitness]; 

%% ���������ѳ�ʼ��ֵ��Ȩֵ
% ������ʼ
for i=1:maxgen
    disp(['����������  ',num2str(i),'     ����������:      ',num2str(maxgen)])
    % ѡ��
    individuals=Select(individuals,sizepop); 
    % ����
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop);
    % ����
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,i,maxgen);
    
    % ������Ӧ��
    for j=1:sizepop
        x=individuals.chrom(j,:); % ����
        [individuals.fitness(j)]=fun(x);   % Ⱦɫ�����Ӧ�� 
    end

    % �ҵ���С�������Ӧ�ȵ�Ⱦɫ�弰��������Ⱥ�е�λ��
    [newbestfitness,newbestindex]=max(individuals.fitness);
    [worestfitness,worestindex]=min(individuals.fitness);
    % ������һ�ν�������õ�Ⱦɫ��
    if bestfitness<newbestfitness
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom;
    individuals.fitness(worestindex)=bestfitness;
    trace=[trace;bestfitness]; %��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��

end
%% ������
x = bestchrom;   % ��Ѹ���ֵ, tt��500��ֵ��1x500
%% �Ŵ��㷨������� 
figure('color',[1,1,1]),
plot(1:length(x),x,'b--','linewidth',2);
title(['���Ÿ���ֵ  ' '��ֹ������' num2str(maxgen)]);
xlabel('��������');   ylabel('���Ÿ���ֵ');
legend('���Ÿ���ֵ');

figure('color',[1,1,1]),
plot(1:length(trace),trace,'b.--','linewidth',2,'Markersize',20);
title(['��Ӧ������  ' '��ֹ������' num2str(maxgen)]);
xlabel('��������');   ylabel('��Ӧ��');
legend('�����Ӧ��');

% ͳ�Ʒ���Ƶ��
sj = 30; % 30��ʾ���Сʱ��30����
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
xlabel('ʱ��');   ylabel('����Ƶ��');
X1 = 1:length(tablef); Y1 = tablef;
createfigure(X1, Y1);    % ƽ���������
axis([0,35,0,35])




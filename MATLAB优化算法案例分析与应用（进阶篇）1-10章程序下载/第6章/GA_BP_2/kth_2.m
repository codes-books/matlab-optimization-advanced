%% �ܻط���
%% ��ջ�������
clc,clear,close all
%% ѵ������Ԥ��������ȡ����һ��
%���������������
load data2.mat; % ԭʼ�������������ķ�ʽ�����workplace�ļ���
data =data2;    % ��ֵ
n=size(data);
input=data(:,3:6);  % ��Ϊ����
output=data(:,2);   % ��ΪĿ������
%�ڵ����
inputnum=4;
hiddennum=7;
outputnum=1;

%ѵ�����ݺ�Ԥ������
input_train=input(1:n(1,1),:)';
input_test=input(1:n(1,1),:)';
output_train=output(1:n(1,1))';
output_test=output(1:n(1,1))';

%ѡ����������������ݹ�һ��
[inputn,inputps]=mapminmax(input_train);
[outputn,outputps]=mapminmax(output_train);

%��������
nntwarn off
net=newff(inputn,outputn,hiddennum);

%% �Ŵ��㷨������ʼ��
maxgen=10;                          %��������������������
sizepop=50;                         %��Ⱥ��ģ
pcross=[0.3];                       %�������ѡ��0��1֮��
pmutation=[0.1];                    %�������ѡ��0��1֮��

%�ڵ�����
numsum=inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum;

lenchrom=ones(1,numsum);        
bound=[0.1*ones(numsum,1) 20*ones(numsum,1)];    %���ݷ�Χ

%------------------------------------------------------��Ⱥ��ʼ��--------------------------------------------------------
individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  %����Ⱥ��Ϣ����Ϊһ���ṹ��
avgfitness=[];                      %ÿһ����Ⱥ��ƽ����Ӧ��
bestfitness=[];                     %ÿһ����Ⱥ�������Ӧ��
bestchrom=[];                       %��Ӧ����õ�Ⱦɫ��
%��ʼ����Ⱥ
for i=1:sizepop
    %�������һ����Ⱥ
    individuals.chrom(i,:)=Code(lenchrom,bound);    %���루binary��grey�ı�����Ϊһ��ʵ����float�ı�����Ϊһ��ʵ��������
    x=individuals.chrom(i,:);
    %������Ӧ��
    individuals.fitness(i)=fun(x,inputnum,hiddennum,outputnum,net,inputn,outputn);   %Ⱦɫ�����Ӧ��
end

%����õ�Ⱦɫ��
[bestfitness bestindex]=min(individuals.fitness);
bestchrom=individuals.chrom(bestindex,:);  %��õ�Ⱦɫ��
avgfitness=sum(individuals.fitness)/sizepop; %Ⱦɫ���ƽ����Ӧ��
% ��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��
trace=[avgfitness bestfitness]; 
 
%% ���������ѳ�ʼ��ֵ��Ȩֵ
% ������ʼ
for i=1:maxgen
    i
    % ѡ��
    individuals=Select(individuals,sizepop); 
    avgfitness=sum(individuals.fitness)/sizepop;
    %����
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop,bound);
    % ����
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,i,maxgen,bound);
    
    % ������Ӧ�� 
    for j=1:sizepop
        x=individuals.chrom(j,:); %����
        individuals.fitness(j)=fun(x,inputnum,hiddennum,outputnum,net,inputn,outputn);   
    end
    
  %�ҵ���С�������Ӧ�ȵ�Ⱦɫ�弰��������Ⱥ�е�λ��
    [newbestfitness,newbestindex]=min(individuals.fitness);
    [worestfitness,worestindex]=max(individuals.fitness);
    % ������һ�ν�������õ�Ⱦɫ��
    if bestfitness>newbestfitness
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom;
    individuals.fitness(worestindex)=bestfitness;
    
    avgfitness=sum(individuals.fitness)/sizepop;
    
    trace=[trace;avgfitness bestfitness]; %��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��

end
%% �Ŵ��㷨������� 
figure('color',[1,1,1]),
[r c]=size(trace);
plot([1:r]',trace(:,2),'b--');
title(['��Ӧ������  ' '��ֹ������' num2str(maxgen)]);
xlabel('��������');ylabel('��Ӧ��');
legend('ƽ����Ӧ��','�����Ӧ��');
disp('��Ӧ��                   ����');
x=bestchrom;

%% �����ų�ʼ��ֵȨֵ��������Ԥ��
% %���Ŵ��㷨�Ż���BP�������ֵԤ��
w1=x(1:inputnum*hiddennum);
B1=x(inputnum*hiddennum+1:inputnum*hiddennum+hiddennum);
w2=x(inputnum*hiddennum+hiddennum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum);
B2=x(inputnum*hiddennum+hiddennum+hiddennum*outputnum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum);

net.iw{1,1}=reshape(w1,hiddennum,inputnum);
net.lw{2,1}=reshape(w2,outputnum,hiddennum);
net.b{1}=reshape(B1,hiddennum,1);
net.b{2}=B2;

%% BP����ѵ��
%�����������
net.trainParam.epochs=100;
net.trainParam.lr=0.1;
%net.trainParam.goal=0.00001;
%����ѵ��
[net,per2]=train(net,inputn,outputn);

%% BP����Ԥ��
%���ݹ�һ��
inputn_test=mapminmax('apply',input_test,inputps);
an=sim(net,inputn_test);
test_simu=mapminmax('reverse',an,outputps);
error=test_simu-output_test;
save data2_GA_BP test_simu output_test error
%% Ѱ�ŷ���
Up=0.5:0.05:0.85;    %��Ϊ��˹����
Utp=6.5:0.1:9.1;   %��Ϊú������
Ut=13:0.5:19;      %��Ϊ�¶�����
Us = 12:0.5:19;    %��Ϊ�ʶ�����

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
                count = count+1   %����
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
% ��˹ + ú�� + �¶� + ʪ�� + ���ŷ���
[a,b]=min(test_result(:,5) + test_result(:,1) +test_result(:,2) );
actual_result=test_result(b,:);% �õ�Ԥ����Сֵ
save data2_GA_BP_test_result.mat test_result actual_result

%%
load('data2_GA_BP.mat')
load('data2_GA_BP_test_result.mat')


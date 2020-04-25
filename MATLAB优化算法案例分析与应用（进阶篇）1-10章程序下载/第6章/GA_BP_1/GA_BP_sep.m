%% GA_BPͼ��ָ�
%% ��ջ�������
clc,clear,close all
warning off
%% ѵ������Ԥ��������ȡ����һ��
%���������������
load('data.mat');          % ԭʼ�������������ķ�ʽ�����workplace�ļ���
%% ����ѵ������
im_sep = MRI_pic(30);      % ѡȡ��30��ͼ��train ��������, ѡΪ30
% ��ȡ�������output
lev2 = 50/255;                    % ��ֵ
L = zeros(size(im_sep));          % 0 = ����
L(im_sep<lev2 & im_sep>0) = 2;    % 2 = ����
L(im_sep>=lev2) = 3;              % 3 = ����
L = mat2gray(L);      
% figure,imshow(L);title('�Ұ��ʷָ�ͼ')
% ѵ������
nd = size(im_sep);       % ���ݴ�С
input_train = reshape(im_sep,nd(1,1)*nd(1,2),1)';  % ��Ϊ����
output_train = reshape(L,nd(1,1)*nd(1,2),1)';      % ��ΪĿ������

%% ��������
num = 20;                          % numȡֵ 13--31֮��
im_sep_test = MRI_pic(num);        % ��ȡnum��ͼ��test ��������, ��������
nd_test = size(im_sep_test);       % ���ݴ�С
input_test = reshape(im_sep_test,nd_test(1,1)*nd_test(1,2),1)';  % ��Ϊ�������

%% BP��������
%�ڵ����
inputnum  = 1;
hiddennum = 7;
outputnum = 1;

%��������
nntwarn off
net=newff(input_train,output_train,hiddennum);

%% �Ŵ��㷨������ʼ��
maxgen = 5;                          %��������������������
sizepop = 5;                         %��Ⱥ��ģ
pcross = [0.3];                       %�������ѡ��0��1֮��
pmutation = [0.1];                    %�������ѡ��0��1֮��

%�ڵ�����
numsum=inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum;

lenchrom=ones(1,numsum);        
bound=[0*ones(numsum,1) 3*ones(numsum,1)];    %���ݷ�Χ

%------------------------------------------------------��Ⱥ��ʼ��--------------------------------------------------------
individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  %����Ⱥ��Ϣ����Ϊһ���ṹ��
avgfitness = [];                      %ÿһ����Ⱥ��ƽ����Ӧ��
bestfitness = [];                     %ÿһ����Ⱥ�������Ӧ��
bestchrom = [];                       %��Ӧ����õ�Ⱦɫ��
%��ʼ����Ⱥ
for i=1:sizepop
    %�������һ����Ⱥ
    individuals.chrom(i,:)=Code(lenchrom,bound); %���루binary��grey�ı�����Ϊһ��ʵ����float�ı�����Ϊһ��ʵ��������
    x=individuals.chrom(i,:);
    %������Ӧ��
    individuals.fitness(i)=fun(x,inputnum,hiddennum,outputnum,net,input_train,output_train);   %Ⱦɫ�����Ӧ��
end

%����õ�Ⱦɫ��
[bestfitness bestindex]=min(individuals.fitness);
bestchrom=individuals.chrom(bestindex,:);    % ��õ�Ⱦɫ��
avgfitness=sum(individuals.fitness)/sizepop; % Ⱦɫ���ƽ����Ӧ��
%��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��
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
        individuals.fitness(j)=fun(x,inputnum,hiddennum,outputnum,net,input_train,output_train);   
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
xlabel('��������');   ylabel('��Ӧ��');
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
net.trainParam.epochs=10;
net.trainParam.lr=0.1;
%net.trainParam.goal=0.00001;
%����ѵ��
[net,per2]=train(net,input_train,output_train);

%% BP����Ԥ��
[net,per2] = train(net,input_train,output_train);
output_test_simu = sim(net,input_test);  % BPԤ��
im = reshape(output_test_simu,nd_test(1,1),nd_test(1,2));
%��ͼ��ʾ
figure,imshow(im);title('����BP������ĻҰ��ʷָ�ͼ')
figure,imshow(im_sep_test);title('MRI����ͼ��')


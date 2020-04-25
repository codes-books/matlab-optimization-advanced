clc,clear,close all                    	% �������幤�������رմ���
warning off                         	% ��������
feature jit off                       	% ���ٴ���ִ��
m=[zeros(5,1)+0.1 0.2*ones(5,1)];
S(:,:,1)=[0.1 0.1 0.7 0.4 0.06;
          0.3 0.08 0.7 0.1 0.8;
          0.2 0.8 0.0 0.3 0.7;
          0.8 0.2 0.4 0.1 0.01;
          0.01 0.05 0.01 0.03 0.7];
S(:,:,2)=[0.1 0.3 0.6 0.7 0.9;
          0.6 0.1 0.0041 0.1 0.1;
          0.7 0.4 0.06 0.3 0.087;
          0.1 0.8 0.2 0.8 0.03;
          0.7 0.8 0.2 0.4 0.1];

P=[1/2 1/2 ]'; N_1=1000;
% ���� X1 and X2
randn('state',0);
[X1,y1]=generate_gauss_classes(m,S,P,N_1);
N_2=10000;
randn('state',100);
[X2,y2]=generate_gauss_classes(m,S,P,N_2);
 
% ʹ�ú��� Gaussian_ML_estimate���������Ȼ���ƾ�ֵ��Э����
for i=1:5
    [m1_hat(i), S1_hat(i)]=Gaussian_ML_estimate(X1(i,find(y1==1)));
end
m1_hat=m1_hat'; S1_hat=S1_hat';
for i=1:5
    [m2_hat(i), S2_hat(i)]=Gaussian_ML_estimate(X1(i,find(y1==2)));
end
m2_hat=m2_hat'; S2_hat=S2_hat';

% �������ر�Ҷ˹����������X2
for i=1:5
    perFeature1(i,:)=normpdf(X2(i,:),m1_hat(i),sqrt(S1_hat(i)));
    perFeature2(i,:)=normpdf(X2(i,:),m2_hat(i),sqrt(S2_hat(i)));
end
naive_probs1=prod(perFeature1);
naive_probs2=prod(perFeature2);
classified=ones(1,length(X2));
classified(find(naive_probs1<naive_probs2))=2;
% ����������
true_labels=y2;
naive_error=sum(true_labels~=classified)/length(classified)
 
% ���������Ȼֵ
[m1_ML, S1_ML]=Gaussian_ML_estimate(X1(:,find(y1==1)));
[m2_ML, S2_ML]=Gaussian_ML_estimate(X1(:,find(y1==2)));
% ������ȻֵML�����ñ�Ҷ˹��������������X2
m_ML(:,1)=m1_ML;
m_ML(:,2)=m2_ML;
S_ML(:,:,1)=S1_ML;
S_ML(:,:,2)=S2_ML;
P=[1/2 1/2];
z=bayes_classifier(m_ML,S_ML,P,X2);
% ����������
true_labels=y2;
Bayes_ML_error=sum(true_labels~=z)/length(z)

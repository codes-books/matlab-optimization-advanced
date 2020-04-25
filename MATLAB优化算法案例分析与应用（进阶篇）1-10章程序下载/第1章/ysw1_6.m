clc,clear,close all                    	% �������幤�������رմ���
warning off                         	% ��������
feature jit off                       	% ���ٴ���ִ��
% ���ú���generate_gauss_classes()������������Ϊc�����Ӹ�˹�����ܶȺ����ֲ�������X
m=[0 0 0; 1.4 2.23 2.45; 3.1 3.2 5.9]';  				% ��ʼ��
S1=1.828*eye(3);                        % ��ʼ��
S(:,:,1)=S1;S(:,:,2)=S1;S(:,:,3)=S1;       % ��ʼ��
P=[1/3 1/3 1/3]';                        % ��ʼ��
N=500;        					% ����
randn('seed',0);  					% �������
[X,y]=generate_gauss_classes(m,S,P,N);  %��������
 
% ������һ��������ƶȵ�����
randn('seed',100);
[X1,y1]=generate_gauss_classes(m,S,P,N);
 
% �����Ȼ���Ƽ���
class1_data=X(:,find(y==1));                           % ����1
[m1_hat, S1_hat]=Gaussian_ML_estimate(class1_data);   % ����
class2_data=X(:,find(y==2));
[m2_hat, S2_hat]=Gaussian_ML_estimate(class2_data);   % ����
class3_data=X(:,find(y==3));
[m3_hat, S3_hat]=Gaussian_ML_estimate(class3_data);   % ����
S_hat=(1/3)*(S1_hat+S2_hat+S3_hat);
m_hat=[m1_hat m2_hat m3_hat];
 
% Ӧ�÷������������ļ�����ݽ��з���
z_euclidean=euclidean_classifier(m_hat,X1);              % ŷ�Ͼ��������
z_mahalanobis=mahalanobis_classifier(m_hat,S_hat,X1);   % ���Ͼ��������
z_bayesian=bayes_classifier(m,S,P,X1);                  % ��Ҷ˹������

% ����������
err_euclidean = (1-length(find(y1==z_euclidean))/length(y1))       % ŷʽ���
err_mahalanobis = (1-length(find(y1==z_mahalanobis))/length(y1))  % �������
err_bayesian = (1-length(find(y1==z_bayesian))/length(y1))         % ��Ҷ˹���

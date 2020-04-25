clc,clear,close all                    	% �������幤�������رմ���
warning off                         	% ��������
feature jit off                       	% ���ٴ���ִ��
%�����ܶȺ���ʵ��Ϊ��ϸ�˹ģ��
m=[1; 4]';
S(:,:,1)=[0.3];
S(:,:,2)=[0.3];
P=[2/3 1/3];
N=1000;
randn('seed',0);
[X]=generate_gauss_classes(m,S,P,N);

% Plot the pdf
x=-5:0.1:5;
pdfx=(2/3)*(1/sqrt(2*pi))*exp(-((x-1).^2)/2)+(1/3)*(1/sqrt(2*pi))*exp(-((x-4).^2)/2);
plot(x,pdfx); hold;

%����knn_density_estimate ���Ƹ����ܶȺ��� pdf (k=21)
pdfx_approx=knn_density_estimate(X,21,-5,5,0.1);
plot(-5:0.1:5,pdfx_approx,'r');

legend('ԭʼ�ֲ�����','K������ܶȹ���')

clc,clear,close all                    	% �������幤�������رմ���
warning off                         	% ��������
feature jit off                       	% ���ٴ���ִ��
% �����ܶȺ���ʵ����һ����ϸ�˹�ֲ�����
% ���� generate_gauss_classes������������Ҫ������
m=[1; 4]';   % ��ʼ��
S(:,:,1)=[0.3];
S(:,:,2)=[0.3];
P=[2/3 1/3];
N=1000;
randn('seed',0);
[X]=generate_gauss_classes(m,S,P,N);

% ��ͼpdf
x=-5:0.1:5;
pdfx=(2/3)*(1/sqrt(2*pi*0.2))*exp(-.5*((x-1).^2)/0.2)+(1/3)*(1/sqrt(2*pi*0.2))*exp(-.5*((x-4).^2)/0.2);
plot(x,pdfx); hold on;

%Parzon�����㣬h = 0.1 and x in [-5, 5]
h=0.1;
pdfx_approx=Parzen_gauss_kernel(X,h,-5,5);
plot(-5:h:5,pdfx_approx,'r');
legend('ԭʼ�ֲ�����','Parzen���ƽ�Ч��')

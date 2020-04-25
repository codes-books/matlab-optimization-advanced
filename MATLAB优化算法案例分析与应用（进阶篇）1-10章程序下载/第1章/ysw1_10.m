clc,clear,close all                    	% 清屏、清工作区、关闭窗口
warning off                         	% 消除警告
feature jit off                       	% 加速代码执行
% 概率密度函数实际是一个混合高斯分布函数
% 采用 generate_gauss_classes函数产生所需要的数据
m=[1; 4]';   % 初始化
S(:,:,1)=[0.3];
S(:,:,2)=[0.3];
P=[2/3 1/3];
N=1000;
randn('seed',0);
[X]=generate_gauss_classes(m,S,P,N);

% 绘图pdf
x=-5:0.1:5;
pdfx=(2/3)*(1/sqrt(2*pi*0.2))*exp(-.5*((x-1).^2)/0.2)+(1/3)*(1/sqrt(2*pi*0.2))*exp(-.5*((x-4).^2)/0.2);
plot(x,pdfx); hold on;

%Parzon窗计算，h = 0.1 and x in [-5, 5]
h=0.1;
pdfx_approx=Parzen_gauss_kernel(X,h,-5,5);
plot(-5:h:5,pdfx_approx,'r');
legend('原始分布函数','Parzen窗逼近效果')

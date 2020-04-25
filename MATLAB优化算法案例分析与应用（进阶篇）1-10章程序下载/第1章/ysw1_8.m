clc,clear,close all                    	% 清屏、清工作区、关闭窗口
warning off                         	% 消除警告
feature jit off                       	% 加速代码执行
% 产生X，并画图
randn('seed',0);                 		% 随机种子初始化
m1=[1, 2]'; m2=[2, 3]';m3=[3, 6]';  		% 已知量
m=[m1 m2 m3];
 
S(:,:,1)=0.1*eye(2);   % 初始化
S(:,:,2)=0.2*eye(2);   % 初始化
S(:,:,3)=0.3*eye(2);   % 初始化
P=[0.4 0.4 0.2];      % 初始化
N=1000;             % 初始化
sed=0;             % 初始化
[X,y]=mixt_model(m,S,P,N,sed);  		% 混合分布
plot_data(X,y,m,1)
box on

m1_ini=[0; 2];m2_ini=[5; 2];m3_ini=[5; 5];
m_ini=[m1_ini m2_ini m3_ini];
s_ini=[0.15 0.32 0.4];
Pa_ini=[1/3 1/3 1/3];
e_min=10^(-6);
[m_hat,s_hat,Pa,iter,Q_tot,e_tot]=em_alg_function(X,m_ini,s_ini,Pa_ini,e_min);


%% 2
clc,clear,close all                    	% 清屏、清工作区、关闭窗口
warning off                         	% 消除警告
feature jit off                       	% 加速代码执行
% 产生数据集X并画图
randn('seed',0);
m1=[1, 2]'; m2=[2, 3]';m3=[3, 6]';
m=[m1 m2 m3];
 
S(:,:,1)=0.1*eye(2);
S(:,:,2)=0.2*eye(2);
S(:,:,3)=0.3*eye(2);
P=[0.4 0.4 0.2];
N=1000;
sed=0;
[X,y]=mixt_model(m,S,P,N,sed);  		% 混合分布
m1_ini=[1.4; 1.5];
m2_ini=[1.3; 1.8];
m3_ini=[1.1; 1.7];
m_ini=[m1_ini m2_ini m3_ini];
 
s_ini=[0.15 0.4 0.3];
Pa_ini=[0.02 0.04 0.4];
e_min=10^(-7);
[m_hat,s_hat,Pa,iter,Q_tot,e_tot]=em_alg_function(X,m_ini,s_ini,Pa_ini,e_min);
m_hat,s_hat,Pa

%% 3
clc,clear,close all                    	% 清屏、清工作区、关闭窗口
warning off                         	% 消除警告
feature jit off                       	% 加速代码执行
% 产生数据集X并画图
randn('seed',0);
m1=[1, 2]'; m2=[2, 3]';m3=[3, 6]';
m=[m1 m2 m3];
 
S(:,:,1)=0.1*eye(2);
S(:,:,2)=0.2*eye(2);
S(:,:,3)=0.3*eye(2);
P=[0.4 0.4 0.2];
N=1000;
sed=0;
[X,y]=mixt_model(m,S,P,N,sed);
m1_ini=[1.16; 1.2];
m2_ini=[1.3; 1.2];
m_ini=[m1_ini m2_ini];
 
s_ini=[0.2 0.34 ];
Pa_ini=[2/3 0.5 ];
e_min=10^(-7);
[m_hat,s_hat,Pa,iter,Q_tot,e_tot]=em_alg_function(X,m_ini,s_ini,Pa_ini,e_min);
m_hat,s_hat,Pa


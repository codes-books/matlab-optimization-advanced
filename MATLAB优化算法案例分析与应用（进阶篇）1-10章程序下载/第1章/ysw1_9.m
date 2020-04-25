clc,clear,close all                    	% 清屏、清工作区、关闭窗口
warning off                         	% 消除警告
feature jit off                       	% 加速代码执行
% 第一类点
m11=[1.3 1.3]'; m12=[3.1 3.1]';m13=[4 5]';
m1=[m11 m12 m13];
S1(:,:,1)=0.5*eye(2);
S1(:,:,2)=0.2*eye(2);
S1(:,:,3)=0.3*eye(2);
P1=[0.4 0.4 0.2];
N1=500;
sed=0;
[X1,y1]=mixt_model(m1,S1,P1,N1,sed);
% 第二类点
m21=[1.3 3.1]'; m22=[3.1 1.3]';m23=[6 5]';
m2=[m21 m22 m23];
S2(:,:,1)=0.5*eye(2);
S2(:,:,2)=0.2*eye(2);
S2(:,:,3)=0.3*eye(2);
P2=[0.2 0.3 0.5];
N2=500;
sed=0;
[X2,y2]=mixt_model(m2,S2,P2,N2,sed);
%%
plot_data(X1,y1,m1,1)
hold on
plot_data(X2,y2,m2,1)
box on

%%
%%估计每一类的高斯混合模型
m11_ini=[0; 1]; m12_ini=[2; 4]; m13_ini=[2; 5];  % 题目初始化值
m1_ini=[m11_ini m12_ini m13_ini];
S1_ini=[0.25 0.34 0.24];
w1_ini=[1/3 1/3 1/3];
m21_ini=[.5; .2]; m22_ini=[1; 6]; m23_ini=[1; 2];
m2_ini=[m21_ini m22_ini m23_ini];
S2_ini=[0.5 0.7 0.3];
w2_ini=[1/3 1/3 1/3];
 
m_ini{1}=m1_ini;
m_ini{2}=m2_ini;
S_ini{1}=S1_ini;
S_ini{2}=S2_ini;
w_ini{1}=w1_ini;
w_ini{2}=w2_ini;
[m_hat,S_hat,w_hat,P_hat]=EM_pdf_est([X1 X2],[ones(1,500) 2*ones(1,500)],m_ini,S_ini,w_ini);
m_hat,S_hat,w_hat

%%
% 500个数据点入Z1
mZ11=[1.3 1.3]'; mZ12=[3.1 3.1]';mZ13=[4 5]';
mZ1=[mZ11 mZ12 mZ13];
SZ1(:,:,1)=0.5*eye(2);
SZ1(:,:,2)=0.2*eye(2);
SZ1(:,:,3)=0.3*eye(2);
wZ1=[0.4 0.4 0.2];
NZ1=500;
sed=100;
[Z1,yz1]=mixt_model(mZ1,SZ1,wZ1,NZ1,sed);
 
% 另500个数据点入Z2
mZ21=[1.3 3.1]'; mZ22=[3.1 1.3]';mZ23=[6 5]';
mZ2=[mZ21 mZ22 mZ23];
SZ2(:,:,1)=0.5*eye(2);
SZ2(:,:,2)=0.2*eye(2);
SZ2(:,:,3)=0.3*eye(2);
wZ2=[0.2 0.3 0.5];
NZ2=500;
sed=100;
[Z2,yz2]=mixt_model(mZ2,SZ2,wZ2,NZ2,sed);
 
% 产生数据及Z
Z=[Z1 Z2];
%使用混合贝叶斯分类器计算分类误差
for j=1:2
    le=length(S_hat{j});
    te=[];
    for i=1:le
        te(:,:,i)=S_hat{j}(i)*eye(2);
    end
    S{j}=te;
end
[y_est]=mixture_Bayes(m_hat,S,w_hat,P_hat,Z);
[classification_error]=compute_error([ones(1,500) 2*ones(1,500)],y_est)


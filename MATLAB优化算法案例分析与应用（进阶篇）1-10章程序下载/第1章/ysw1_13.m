clc,clear,close all                    % 清屏、清工作区、关闭窗口
warning off                         % 消除警告
feature jit off                        % 加速代码执行
m=[0 1; 5 6]';
S=[0.5 0.1;0.1 0.5];
S(:,:,1)=S;S(:,:,2)=S;
P=[1/2 1/2 ]'; N_1=1000;
% 随机产生初始化数据X1 and X2
randn('seed',0);
[X1,y1]=generate_gauss_classes(m,S,P,N_1);
N_2=5000;
randn('seed',100);
[X2,y2]=generate_gauss_classes(m,S,P,N_2);
 
%使用 k_nn_classifier (k=3)分类器分类
k=3;
z=k_nn_classifier(X1,y1,k,X2);
 
% 计算分类误差
pr_err=sum(z~=y2)/length(y2)

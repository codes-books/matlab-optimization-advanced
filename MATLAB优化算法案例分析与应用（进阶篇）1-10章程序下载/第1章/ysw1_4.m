clc,clear,close all
warning off
% 欧氏距离分类器
x=[0.34 0.25 0.34]';   				% 初始化
m1=[0 0 0]';     				% 初始化
m2=[1.2 1.2 1.2]'; 				% 初始化
m=[m1 m2];
z=euclidean_classifier(m,x)

%%
clc,clear,close all                    % 清屏、清工作区、关闭窗口
warning off                         % 消除警告
feature jit off                        % 加速代码执行
% 马氏距离分类器
x=[0.34 0.25 0.34]';   				% 初始化
m1=[0 0 0]';     				% 初始化
m2=[1.2 1.2 1.2]'; 				% 初始化
m=[m1 m2];
S=[1.1 0.063 0.063;     % 初始化
   0.063 0.74 0.063; 
   0.063 0.063 0.74];
z=mahalanobis_classifier(m,S,x)    % 马氏距离分类





clc,clear,close all                    	% 清屏、清工作区、关闭窗口
warning off                         	% 消除警告
feature jit off                       	% 加速代码执行
% 利用函数generate_gauss_classes()，产生分类数为c、服从高斯概率密度函数分布的数据X
m=[0 0 0; 1.4 2.23 2.45; 3.1 3.2 5.9]';  				% 初始化
S1=1.828*eye(3);                        % 初始化
S(:,:,1)=S1;S(:,:,2)=S1;S(:,:,3)=S1;       % 初始化
P=[1/3 1/3 1/3]';                        % 初始化
N=500;        					% 个数
randn('seed',0);  					% 随机种子
[X,y]=generate_gauss_classes(m,S,P,N);  %产生数据
 
% 产生另一组具有相似度的数据
randn('seed',100);
[X1,y1]=generate_gauss_classes(m,S,P,N);
 
% 最大似然估计计算
class1_data=X(:,find(y==1));                           % 数据1
[m1_hat, S1_hat]=Gaussian_ML_estimate(class1_data);   % 估计
class2_data=X(:,find(y==2));
[m2_hat, S2_hat]=Gaussian_ML_estimate(class2_data);   % 估计
class3_data=X(:,find(y==3));
[m3_hat, S3_hat]=Gaussian_ML_estimate(class3_data);   % 估计
S_hat=(1/3)*(S1_hat+S2_hat+S3_hat);
m_hat=[m1_hat m2_hat m3_hat];
 
% 应用分类器将产生的检测数据进行分类
z_euclidean=euclidean_classifier(m_hat,X1);              % 欧氏距离分类器
z_mahalanobis=mahalanobis_classifier(m_hat,S_hat,X1);   % 马氏距离分类器
z_bayesian=bayes_classifier(m,S,P,X1);                  % 贝叶斯分类器

% 计算分类误差
err_euclidean = (1-length(find(y1==z_euclidean))/length(y1))       % 欧式误差
err_mahalanobis = (1-length(find(y1==z_mahalanobis))/length(y1))  % 马氏误差
err_bayesian = (1-length(find(y1==z_bayesian))/length(y1))         % 贝叶斯误差

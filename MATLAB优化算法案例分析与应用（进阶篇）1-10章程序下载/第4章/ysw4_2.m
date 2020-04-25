clc,clear,close all
warning off
%%%%读入7x7的五幅图片
I0=imread('.\检验样本图片\num0_1.bmp');         % 数字0
yb0=im2bw(I0);                				   % 转化成二值图像
I1=imread('.\检验样本图片\num1_1.bmp');         % 数字1
yb1=im2bw(I1);                				   % 转化成二值图像
I2=imread('.\检验样本图片\num2_1.bmp');         % 数字2
yb2=im2bw(I2);                				   % 转化成二值图像
I3=imread('.\检验样本图片\num3_1.bmp');         % 数字3
yb3=im2bw(I3);                                 % 转化成二值图像
I4=imread('.\检验样本图片\num4_1.bmp');         % 数字4
yb4=im2bw(I4);                			       % 转化成二值图像
I5=imread('.\检验样本图片\num5_1.bmp');         % 数字5
yb5=im2bw(I5);               	               % 转化成二值图像
p0=zeros(49,6);
%转化格式用以生成训练样本
T=zeros(49,6);
ta=eye(6);
yb=[yb0,yb1,yb2,yb3,yb4,yb5];     			% 生成训练样本
for k=1:6
    for m=1:7
        for n=1:7
            T(n+7*(m-1),k)=yb(m,n+7*(k-1));   % 图像数据保存为1列
        end
    end
end
[R1,Q1]=size(T);
[R2,Q2]=size(ta);
%给理想样本加噪，提高鲁棒性
J=imnoise(T,'gaussian',0.01,0.001);

%生成神经网络
S1=10;
S2=R2;
net=newff(minmax(T),[S1,S2],{'logsig' 'logsig'},'traingdx');% 建立一个网络输入
net.LW{2,1}=net.LW{2,1}*0.01;  % 权值
net.b{2}=net.b{2}*0.01;        % 阈值
%用理想样本训练神经网络
net.performFcn='sse';
net.trainParam.goal=0.01;   	% 训练误差
net.trainParam.epochs=1000; 	% 训练步数
net.trainParam.mc=0.02;     	% 效率
[net,tr]=train(net,T,ta);

%%
%利用含噪声的“３”作为测试对象
ya3=double(yb3);
t3=imnoise(ya3,'gaussian',0,0.01);
subplot(121),imshow(t3);title('加噪声的测试对象： 3');
%对输入模式进行识别
a3=zeros(49,1);
for m=1:7
    for n=1:7
        a3(n+7*(m-1),1)=yb3(m,n);
    end
end
result=sim(net,a3);
[resultmax,r]=max(result) 	 % 取最大者为一的位置作为识别结果
re=eye(7);              	 % 绘制识别结果位图
for m=1:7
    for n=1:7
        re(m,n)=T(n+7*(m-1),r);
    end
end
subplot(122);
imshow(re);
title('识别结果');

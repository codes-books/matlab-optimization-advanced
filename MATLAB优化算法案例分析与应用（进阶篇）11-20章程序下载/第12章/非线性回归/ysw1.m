% 非线性拟合
clc,clear;close all
warning off
format long
% global X0 X1 X2 X3 X4 X5 X6
X0 = xlsread('数据','1#','B3:B30');  % EXCEL数据
X1 = xlsread('数据','1#','E3:E30');  % EXCEL数据
X2 = xlsread('数据','1#','G3:G30');  % EXCEL数据
X3 = xlsread('数据','1#','I3:I30');  % EXCEL数据
X4 = xlsread('数据','1#','K3:K30');  % EXCEL数据
X5 = xlsread('数据','1#','M3:M30');  % EXCEL数据
X6 = xlsread('数据','1#','O3:O30');  % EXCEL数据
% initial value
a1 = 1; % 植被因子C 系数
a2 = 1; % 入流流量Q 系数
b = 1;  % 入流流量Q 指数
a3 = 1; % 土壤初始含水量因素 系数
a4 = 1; % SS入流浓度 系数
a5 = 1; % 带宽因素m  系数
a6 = 1; % 坡度因素%  系数
a7 = 1; % 常数项     系数
xs = [a1;a2;b;a3;a4;a5;a6;a7];       % 初始值
xdata = [X1,X2,X3,X4,X5,X6];
[x,resnorm] = lsqcurvefit(@myfun1,xs,xdata,X0)
% 计算后的系数
a1 = x(1); % 植被因子C 系数
a2 = x(2); % 入流流量Q 系数
b = x(3);  % 入流流量Q 指数
a3 = x(4); % 土壤初始含水量因素 系数
a4 = x(5); % SS入流浓度 系数
a5 = x(6); % 带宽因素m  系数
a6 = x(7); % 坡度因素%  系数
a7 = x(8); % 常数项     系数
for i = 1:length(X0)
    X0_fit(i) = a1*X1(i)+a2*(X2(i))^(b)+a3*X3(i)+a4*X4(i)+a5*log(X5(i))+a6*X6(i)+a7;
    err(i) = X0_fit(i)-X0(i);  % 拟合误差
end
figure('color',[1,1,1])
subplot(121),plot(X0_fit,'r','linewidth',2);hold on
plot(X0,'b','linewidth',2);hold off;axis tight
legend('拟合值','实际值');title('SS的浓度削减率%')
subplot(122),plot(err,'g','linewidth',2);hold off;
axis tight;legend('误差');title('SS的浓度削减率% -- 误差')





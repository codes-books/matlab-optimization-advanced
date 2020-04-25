function [f] = fun(x)
% 城市交通信号系统参数
C = 140;  % 信号周期
L = 10;   % 总损失时间
load('data.mat')  % 包含交通流量q以及饱和流量xij
q = q./3600;      % 转化为秒s
xij = xij./3600;  % 转化为秒s
%该函数用来计算适应度值
t1 = x(1);
t2 = x(2);
t3 = x(3);
t4 = C-L - t1-t2-t3;
lamda(1) = t1/C; % 为第1相位的绿信比
lamda(2) = t2/C; % 为第2相位的绿信比
lamda(3) = t3/C; % 为第3相位的绿信比
lamda(4) = t4/C; % 为第4相位的绿信比
f = 0;       % 适应度值初始化
for i=1:4
    for j=1:2
        f = f + ( C*(1-lamda(i)).^2/2/(1-lamda(i)*xij(i,j)) + xij(i,j).^2/2/q(i,j)/(1-xij(i,j)) )*q(i,j);
    end
end
f = abs(f);









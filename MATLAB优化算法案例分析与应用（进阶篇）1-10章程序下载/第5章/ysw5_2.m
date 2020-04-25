clc,clear,close all
warning off      % 消除警告
N = 1000;        % 信号观测长度
a1 = 0.99;       % 一阶AR参数
sigma = 0.0731; % 加性白噪声方差
for kk =1:100
    v = sqrt(sigma)*randn(N,1); % 产生v（n）加性白噪声
    u0 = [0];      % 初始数据
    num = 1;       % 分子系数
    den = [1,a1];  % 分母系数
    Zi = filtic(num,den,u0);    % 滤波器的初始条件
    un = filter(num,den,v,Zi);   % 产生样本序列u(n), N x 1 x trials
%     figure,stem(un),title('随机信号');grid on;
    % 产生期望响应信号和观测数据矩阵
    n0 = 1;          % 虚实现n0步线性预测
    M = 2;           % 滤波器阶数
    b = un(n0+1:N);  % 预测的期望响应
    L = length(b);  
    un1 = [zeros(M-1,1)',un'];  % 扩展数据
    A = zeros(M,L);
    for k=1:L
        A(:,k) = un1(M-1+k : -1 : k);   % 构建观测数据矩阵
    end
    % 应用RLS算法进行迭代寻优计算最优权向量
    delta = 0.004; % 调整参数
    lamda = 0.98;  % 遗忘因子
    w = zeros(M,L+1); 
    epsilon = zeros(L,1); 
    P1 = eye(M)/delta;
    % RLS迭代算法过程
    for k=1:L  
        PIn = P1 * A(:,k);
        denok = lamda + A(:,k)'*PIn;
        kn = PIn/denok;
        epsilon(k) = b(k)-w(:,k)'*A(:,k);
        w(:,k+1) = w(:,k) + kn*conj(epsilon(k));
        P1 = P1/lamda - kn*A(:,k)'*P1/lamda;
    end
    w1(kk,:) = w(1,:);
    w2(kk,:) = w(2,:);
    MSE = abs(epsilon).^2;
    MSE_P(kk) = mean(MSE);
end
W1 = mean(w1); % 取平均值
W2 = mean(w2); % 取平均值 
figure,plot(1:kk,MSE_P,'r','linewidth',2),title('平均MSE');grid on;
figure,plot(1:length(W1),W1,'r','linewidth',2),title('平均MSE');hold on;
plot(1:length(W2),W2,'b','linewidth',2),title('权值');hold on;
grid on;legend('\alpha1=0','\alpha2=-1')

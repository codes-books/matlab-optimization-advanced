function [m,s,Pa,iter,Q_tot,e_tot]=em_alg_function(x,m,s,Pa,e_min)
% 韩式使用格式:
%  [m,s,Pa,iter,Q_tot,e_tot]=em_alg_function(x,m,s,Pa,e_min)
%  EM算法估计混合高斯分布参数
% 输入:
%   x:      lxN 矩阵, 每一列是一个特征向量
%   m:      lxJ 矩阵, 均值估值
%   s:      1xJ 向量, 第j列为第j个高斯分布的协方差值
%   Pa:     J-维向量, 第j列为第j个高斯分布的先验概率值
%   e_min:  迭代终止阈值
%输出:
%   m:      正态分布的均值估值
%   s:       正态分布的协方差估值
%   Pa:     J-dimensional vector, 先验概率估值
%   iter:     迭代收敛数
%   Q_tot:  每次迭代的似然值
%   e_tot:  每次迭代的误差值
x=x';   							% 转置
m=m';  							% 转置
[p,n]=size(x);   					% 矩阵维数
[J,n]=size(m);  					% 矩阵维数
 
e=e_min+1;
 
Q_tot=[];  						% 初始化
e_tot=[];   						% 初始化
 
iter=0;
while (e>e_min)
    iter=iter+1;  					% 迭代次数
    e;
    
    P_old=Pa;  					% 当前值赋给上一次值
    m_old=m;  					% 当前值赋给上一次值
    s_old=s;   					% 当前值赋给上一次值
    
    % 确定P(j|x_k; theta(t))
    for k=1:p
        temp=gauss(x(k,:),m,s);
        P_tot=temp*Pa';
        for j=1:J
            P(j,k)=temp(j)*Pa(j)/P_tot;
        end
    end
    
    % 对数似然函数值
    Q=0;
    for k=1:p
        for j=1:J
            Q=Q+P(j,k)*(-(n/2)*log(2*pi*s(j)) - sum( (x(k,:)-m(j,:)).^2)/(2*s(j)) + log(Pa(j)) );
        end
    end
    Q_tot=[Q_tot Q];
    
    % 确定均值
    for j=1:J
        a=zeros(1,n);
        for k=1:p
            a=a+P(j,k)*x(k,:);
        end
        m(j,:)=a/sum(P(j,:));
    end
    
    % 确定方差
    for j=1:J
        b=0;
        for k=1:p
            b=b+ P(j,k)*((x(k,:)-m(j,:))*(x(k,:)-m(j,:))');
        end
        s(j)=b/(n*sum(P(j,:)));
        
        if(s(j)<10^(-10))  			% 最小值约束
            s(j)=0.001;
        end
        
    end
    
    %先验概率值
    for j=1:J
        a=0;
        for k=1:p
            a=a+P(j,k);
        end
        Pa(j)=a/p;
    end
    
    e=sum(abs(Pa-P_old))+sum(sum(abs(m-m_old)))+sum(abs(s-s_old));    
    e_tot=[e_tot e];    
end

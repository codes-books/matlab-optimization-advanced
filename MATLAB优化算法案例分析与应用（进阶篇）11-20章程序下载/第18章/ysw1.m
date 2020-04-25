% 改进的快速粒子群优化算法 (APSO):
function apso
% 参数设置
global lamda1 lamda2 m ua_max eta_T r G f alpha Cd A rou K Ttq_max Fz fai ge_ne_pe du
lamda1 = 0.2; % 动力性发挥程度加权因子；
lamda2 = 0.8; % 经济性加权因子；
m = 1092;     % 整车质量（kg）；
ua_max = 50;  % 最大车速(km/h)；
eta_T = 0.9;  % 传动系的传动效率；
r = 0.3;      % 车轮半径(m)；
g = 9.8;      % 重力加速度（g*m/s^2） 
G = m*g;      % 汽车重力G=mg，(N)；
f = 0.015;    % 汽车的滚动阻力系数；
alpha = 25*pi/180;   % 道路坡度角-->弧度；
Cd = 0.32;           % 空气阻力系数；
A = 1.5;             % 迎风面积，即汽车行驶方向的投影面积(m^2)；
rou = 7.0;           % 燃油重度，N/L；
K = 1.05;            % 考虑连续加速,加权系数；
Ttq_max = 132;       % 发动机的最大转矩(N.m)；
Fz = G/4;            % 驱动轮上的法向反作用力(N)；
fai = 0.7;           % 地面附着系数；
ge_ne_pe = 205;      % 发动机的燃油消耗率 (g/kW.h)；
du = 0.1;            % 步长

% 变量
Lb=[ 1   1   0.5  0.5  0.3  2]; %下边界
Ub=[5.0 4.0  3.0  2.0  1.0  6]; %上边界
% 默认参数
para=[25 150 0.95]; %[粒子数，迭代次数，gama参数]

% APSO 优化求解函数
[gbest,fmin]=pso_mincon(@cost,@constraint,Lb,Ub,para);

% 输出结果
Bestsolution=gbest % 全局最优个体
fmin

%% 目标函数
function fy=cost(x)
% ig1 = x(1);   %变速器第1挡的传动比
% ig2 = x(2);   %变速器第2挡的传动比
% ig3 = x(3);   %变速器第3挡的传动比
% ig4 = x(4);   %变速器第4挡的传动比
% ig5 = x(5);   %变速器第5挡的传动比
% ig0 = x(6);   %主减速器传动比
global lamda1 lamda2 m ua_max eta_T r G f alpha Cd A rou K Ttq_max Fz fai ge_ne_pe du

% 发动机功率(Pe)
T = 0; % 时间
Q = 0; % 耗油量
for ua = 0.1:0.1:ua_max

    if ua<=10
        delta = 1.06+0.04*x(1).^2;  % 汽车旋转质量换算系数
        ne = ua*x(6)*x(1)/0.377/r;  % 转速（r/min）
        Pe = ( G*f*ua/3600 + Cd*A*ua.^3/76140 + delta*m*ua*du/3600)/eta_T;
        Me = 9549*Pe./ne;  % 发动机转矩(N.m)
        Ft = Me*x(1)*x(6)*eta_T/r;  % 汽车的驱动力
    elseif ua>10 && ua<=20
        delta = 1.06+0.04*x(2).^2;  % 汽车旋转质量换算系数
        ne = ua*x(6)*x(2)/0.377/r;  % 转速（r/min）
        Pe = ( G*f*ua/3600 + Cd*A*ua.^3/76140 + delta*m*ua*du/3600)/eta_T;
        Me = 9549*Pe./ne;  % 发动机转矩(N.m)
        Ft = Me*x(2)*x(6)*eta_T/r;  % 汽车的驱动力
     elseif ua>20 && ua<=30
        delta = 1.06+0.04*x(3).^2;  % 汽车旋转质量换算系数
        ne = ua*x(6)*x(3)/0.377/r;  % 转速（r/min）
        Pe = ( G*f*ua/3600 + Cd*A*ua.^3/76140 + delta*m*ua*du/3600)/eta_T;
        Me = 9549*Pe./ne;  % 发动机转矩(N.m)
        Ft = Me*x(3)*x(6)*eta_T/r;  % 汽车的驱动力
     elseif ua>30 && ua<=40
        delta = 1.06+0.04*x(4).^2;  % 汽车旋转质量换算系数 
        ne = ua*x(6)*x(4)/0.377/r;  % 转速（r/min）
        Pe = ( G*f*ua/3600 + Cd*A*ua.^3/76140 + delta*m*ua*du/3600)/eta_T;
        Me = 9549*Pe./ne;  % 发动机转矩(N.m)
        Ft = Me*x(4)*x(6)*eta_T/r;  % 汽车的驱动力
     elseif ua>40 && ua<=ua_max
        delta = 1.06+0.04*x(4).^2;  % 汽车旋转质量换算系数
        ne = ua*x(6)*x(5)/0.377/r;  % 转速（r/min）
        Pe = ( G*f*ua/3600 + Cd*A*ua.^3/76140 + delta*m*ua*du/3600)/eta_T;
        Me = 9549*Pe./ne;  % 发动机转矩(N.m)
        Ft = Me*x(5)*x(6)*eta_T/r;  % 汽车的驱动力
    end
    Ff = G*f*cos(alpha);        % 汽车的滚动阻力
    Fw = Cd*A*ua.^2/21.15;      % 汽车的空气阻力
    % f1(x)动力性分目标函数
    T = T + delta*m*du/(Ft-Ff-Fw); % 从0到最大速度ua_max所用时间 
    % f2(x)经济性分目标函数
    delta_S = (ua + ua+du)/2;  % 单位距离
    Q = Q + K*Pe*ge_ne_pe*delta_S./102./ua./rou; % 耗油量
    
end
fy = lamda1*T + lamda2*Q;

% 非线性约束
function [g,geq]=constraint(x)
global lamda1 lamda2 m ua_max eta_T r G f alpha Cd A rou K Ttq_max Fz fai ge_ne_pe du
% 不等式限制条件
q = (x(1)./x(5)).^(1/4);
g(1)= Ttq_max*x(1)*x(6)*eta_T/r - Fz*fai;
g(2)= 0.85*q-x(1)./x(2);
g(3)= x(1)./x(2)-1.15*q;
g(4)= 0.80*q-x(2)./x(3);
g(5)= x(2)./x(3)-1.1*q;
g(6)= 0.75*q-x(3)./x(4);
g(7)= x(3)./x(4)-1.05*q;
g(8)= 0.7*q-x(4)./x(5);
g(9)= x(4)./x(5)-1.0*q;
g(10)= x(2)./x(3)-0.95*x(1)./x(2);
g(11)= x(3)./x(4)-0.95*x(2)./x(3);
g(12)= x(4)./x(5)-0.95*x(3)./x(4);
g(13)= x(2)-x(1);
g(14)= x(3)-x(2);
g(15)= x(4)-x(3);
g(16)= x(5)-x(4);
g(17)= x(1)-x(6);
% 如果没有等式约束，则置geq=[]；
geq=[];

%%  APSO Solver
function [gbest,fbest]=pso_mincon(fhandle,fnonlin,Lb,Ub,para)
if nargin<=4,
    para=[20 150 0.95];
end
n=para(1);     % 粒子种群大小
time=para(2);  % 时间步长，迭代次数
gamma=para(3); % gama参数
scale=abs(Ub-Lb); % 取值区间
% 验证约束条件是否合乎条件
if abs(length(Lb)-length(Ub))>0,
    disp('Constraints must have equal size');
    return
end

alpha=0.2; % alpha=[0,1]粒子随机衰减因子
beta=0.5;  % 收敛速度(0->1)=(slow->fast);

% 初始化粒子群
best=init_pso(n,Lb,Ub);

fbest=1.0e+100;
% 迭代开始
for t=1:time,     
   
%寻找全局最优个体
  for i=1:n,   
    fval=Fun(fhandle,fnonlin,best(i,:));
    % 更新最有个体
    if fval<=fbest, 
        gbest=best(i,:);
        fbest=fval;
    end
  end

% 随机性衰减因子
 alpha=newPara(alpha,gamma);

% 更新粒子位置 
  best=pso_move(best,gbest,alpha,beta,Lb,Ub);  
 
% 结果显示
	str=strcat('Best estimates: gbest=',num2str(gbest));
	str=strcat(str,'  iteration='); str=strcat(str,num2str(t));
	disp(str);

    fitness1(t)=fbest;
    plot(fitness1,'r','Linewidth',2)
    grid on
    hold on
    title('适应度')
end

% 初始化粒子函数
function [guess]=init_pso(n,Lb,Ub)
ndim=length(Lb);
for i=1:n,
    guess(i,1:ndim)=Lb+rand(1,ndim).*(Ub-Lb); 
end

%更新所有的粒子 toward (xo,yo)
function ns=pso_move(best,gbest,alpha,beta,Lb,Ub)
% 增加粒子在上下边界区间内的随机性
n=size(best,1); ndim=size(best,2);
scale=(Ub-Lb);
for i=1:n,
    ns(i,:)=best(i,:)+beta*(gbest-best(i,:))+alpha.*randn(1,ndim).*scale;
end
ns=findrange(ns,Lb,Ub);

% 边界函数
function ns=findrange(ns,Lb,Ub)
n=length(ns);
for i=1:n,
  % 下边界约束
  ns_tmp=ns(i,:);
  I=ns_tmp<Lb;
  ns_tmp(I)=Lb(I);
  
  % 上边界约束 
  J=ns_tmp>Ub;
  ns_tmp(J)=Ub(J);
  
  %更新粒子
  ns(i,:)=ns_tmp; 
end

% 随机性衰减因子
function alpha=newPara(alpha,gamma);
alpha=alpha*gamma;

% 带约束的d维目标函数的求解
function z=Fun(fhandle,fnonlin,u)
% 目标
z=fhandle(u);

z=z+getconstraints(fnonlin,u); % 非线性约束

function Z=getconstraints(fnonlin,u)
% 罚常数 >> 1
PEN=10^15;
lam=PEN; lameq=PEN;

Z=0;
% 非线性约束
[g,geq]=fnonlin(u);

%通过不等式约束建立罚函数
for k=1:length(g),
    Z=Z+ lam*g(k)^2*getH(g(k));
end
% 等式条件约束
for k=1:length(geq),
   Z=Z+lameq*geq(k)^2*geteqH(geq(k));
end

% Test if inequalities 
function H=getH(g)
if g<=0, 
    H=0; 
else
    H=1; 
end

% Test if equalities hold
function H=geteqH(g)
if g==0,
    H=0;
else
    H=1; 
end

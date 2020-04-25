% �Ľ��Ŀ�������Ⱥ�Ż��㷨 (APSO):
function apso
% ��������
global lamda1 lamda2 m ua_max eta_T r G f alpha Cd A rou K Ttq_max Fz fai ge_ne_pe du
lamda1 = 0.2; % �����Է��ӳ̶ȼ�Ȩ���ӣ�
lamda2 = 0.8; % �����Լ�Ȩ���ӣ�
m = 1092;     % ����������kg����
ua_max = 50;  % �����(km/h)��
eta_T = 0.9;  % ����ϵ�Ĵ���Ч�ʣ�
r = 0.3;      % ���ְ뾶(m)��
g = 9.8;      % �������ٶȣ�g*m/s^2�� 
G = m*g;      % ��������G=mg��(N)��
f = 0.015;    % �����Ĺ�������ϵ����
alpha = 25*pi/180;   % ��·�¶Ƚ�-->���ȣ�
Cd = 0.32;           % ��������ϵ����
A = 1.5;             % ӭ���������������ʻ�����ͶӰ���(m^2)��
rou = 7.0;           % ȼ���ضȣ�N/L��
K = 1.05;            % ������������,��Ȩϵ����
Ttq_max = 132;       % �����������ת��(N.m)��
Fz = G/4;            % �������ϵķ���������(N)��
fai = 0.7;           % ���渽��ϵ����
ge_ne_pe = 205;      % ��������ȼ�������� (g/kW.h)��
du = 0.1;            % ����

% ����
Lb=[ 1   1   0.5  0.5  0.3  2]; %�±߽�
Ub=[5.0 4.0  3.0  2.0  1.0  6]; %�ϱ߽�
% Ĭ�ϲ���
para=[25 150 0.95]; %[������������������gama����]

% APSO �Ż���⺯��
[gbest,fmin]=pso_mincon(@cost,@constraint,Lb,Ub,para);

% ������
Bestsolution=gbest % ȫ�����Ÿ���
fmin

%% Ŀ�꺯��
function fy=cost(x)
% ig1 = x(1);   %��������1���Ĵ�����
% ig2 = x(2);   %��������2���Ĵ�����
% ig3 = x(3);   %��������3���Ĵ�����
% ig4 = x(4);   %��������4���Ĵ�����
% ig5 = x(5);   %��������5���Ĵ�����
% ig0 = x(6);   %��������������
global lamda1 lamda2 m ua_max eta_T r G f alpha Cd A rou K Ttq_max Fz fai ge_ne_pe du

% ����������(Pe)
T = 0; % ʱ��
Q = 0; % ������
for ua = 0.1:0.1:ua_max

    if ua<=10
        delta = 1.06+0.04*x(1).^2;  % ������ת��������ϵ��
        ne = ua*x(6)*x(1)/0.377/r;  % ת�٣�r/min��
        Pe = ( G*f*ua/3600 + Cd*A*ua.^3/76140 + delta*m*ua*du/3600)/eta_T;
        Me = 9549*Pe./ne;  % ������ת��(N.m)
        Ft = Me*x(1)*x(6)*eta_T/r;  % ������������
    elseif ua>10 && ua<=20
        delta = 1.06+0.04*x(2).^2;  % ������ת��������ϵ��
        ne = ua*x(6)*x(2)/0.377/r;  % ת�٣�r/min��
        Pe = ( G*f*ua/3600 + Cd*A*ua.^3/76140 + delta*m*ua*du/3600)/eta_T;
        Me = 9549*Pe./ne;  % ������ת��(N.m)
        Ft = Me*x(2)*x(6)*eta_T/r;  % ������������
     elseif ua>20 && ua<=30
        delta = 1.06+0.04*x(3).^2;  % ������ת��������ϵ��
        ne = ua*x(6)*x(3)/0.377/r;  % ת�٣�r/min��
        Pe = ( G*f*ua/3600 + Cd*A*ua.^3/76140 + delta*m*ua*du/3600)/eta_T;
        Me = 9549*Pe./ne;  % ������ת��(N.m)
        Ft = Me*x(3)*x(6)*eta_T/r;  % ������������
     elseif ua>30 && ua<=40
        delta = 1.06+0.04*x(4).^2;  % ������ת��������ϵ�� 
        ne = ua*x(6)*x(4)/0.377/r;  % ת�٣�r/min��
        Pe = ( G*f*ua/3600 + Cd*A*ua.^3/76140 + delta*m*ua*du/3600)/eta_T;
        Me = 9549*Pe./ne;  % ������ת��(N.m)
        Ft = Me*x(4)*x(6)*eta_T/r;  % ������������
     elseif ua>40 && ua<=ua_max
        delta = 1.06+0.04*x(4).^2;  % ������ת��������ϵ��
        ne = ua*x(6)*x(5)/0.377/r;  % ת�٣�r/min��
        Pe = ( G*f*ua/3600 + Cd*A*ua.^3/76140 + delta*m*ua*du/3600)/eta_T;
        Me = 9549*Pe./ne;  % ������ת��(N.m)
        Ft = Me*x(5)*x(6)*eta_T/r;  % ������������
    end
    Ff = G*f*cos(alpha);        % �����Ĺ�������
    Fw = Cd*A*ua.^2/21.15;      % �����Ŀ�������
    % f1(x)�����Է�Ŀ�꺯��
    T = T + delta*m*du/(Ft-Ff-Fw); % ��0������ٶ�ua_max����ʱ�� 
    % f2(x)�����Է�Ŀ�꺯��
    delta_S = (ua + ua+du)/2;  % ��λ����
    Q = Q + K*Pe*ge_ne_pe*delta_S./102./ua./rou; % ������
    
end
fy = lamda1*T + lamda2*Q;

% ������Լ��
function [g,geq]=constraint(x)
global lamda1 lamda2 m ua_max eta_T r G f alpha Cd A rou K Ttq_max Fz fai ge_ne_pe du
% ����ʽ��������
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
% ���û�е�ʽԼ��������geq=[]��
geq=[];

%%  APSO Solver
function [gbest,fbest]=pso_mincon(fhandle,fnonlin,Lb,Ub,para)
if nargin<=4,
    para=[20 150 0.95];
end
n=para(1);     % ������Ⱥ��С
time=para(2);  % ʱ�䲽������������
gamma=para(3); % gama����
scale=abs(Ub-Lb); % ȡֵ����
% ��֤Լ�������Ƿ�Ϻ�����
if abs(length(Lb)-length(Ub))>0,
    disp('Constraints must have equal size');
    return
end

alpha=0.2; % alpha=[0,1]�������˥������
beta=0.5;  % �����ٶ�(0->1)=(slow->fast);

% ��ʼ������Ⱥ
best=init_pso(n,Lb,Ub);

fbest=1.0e+100;
% ������ʼ
for t=1:time,     
   
%Ѱ��ȫ�����Ÿ���
  for i=1:n,   
    fval=Fun(fhandle,fnonlin,best(i,:));
    % �������и���
    if fval<=fbest, 
        gbest=best(i,:);
        fbest=fval;
    end
  end

% �����˥������
 alpha=newPara(alpha,gamma);

% ��������λ�� 
  best=pso_move(best,gbest,alpha,beta,Lb,Ub);  
 
% �����ʾ
	str=strcat('Best estimates: gbest=',num2str(gbest));
	str=strcat(str,'  iteration='); str=strcat(str,num2str(t));
	disp(str);

    fitness1(t)=fbest;
    plot(fitness1,'r','Linewidth',2)
    grid on
    hold on
    title('��Ӧ��')
end

% ��ʼ�����Ӻ���
function [guess]=init_pso(n,Lb,Ub)
ndim=length(Lb);
for i=1:n,
    guess(i,1:ndim)=Lb+rand(1,ndim).*(Ub-Lb); 
end

%�������е����� toward (xo,yo)
function ns=pso_move(best,gbest,alpha,beta,Lb,Ub)
% �������������±߽������ڵ������
n=size(best,1); ndim=size(best,2);
scale=(Ub-Lb);
for i=1:n,
    ns(i,:)=best(i,:)+beta*(gbest-best(i,:))+alpha.*randn(1,ndim).*scale;
end
ns=findrange(ns,Lb,Ub);

% �߽纯��
function ns=findrange(ns,Lb,Ub)
n=length(ns);
for i=1:n,
  % �±߽�Լ��
  ns_tmp=ns(i,:);
  I=ns_tmp<Lb;
  ns_tmp(I)=Lb(I);
  
  % �ϱ߽�Լ�� 
  J=ns_tmp>Ub;
  ns_tmp(J)=Ub(J);
  
  %��������
  ns(i,:)=ns_tmp; 
end

% �����˥������
function alpha=newPara(alpha,gamma);
alpha=alpha*gamma;

% ��Լ����dάĿ�꺯�������
function z=Fun(fhandle,fnonlin,u)
% Ŀ��
z=fhandle(u);

z=z+getconstraints(fnonlin,u); % ������Լ��

function Z=getconstraints(fnonlin,u)
% ������ >> 1
PEN=10^15;
lam=PEN; lameq=PEN;

Z=0;
% ������Լ��
[g,geq]=fnonlin(u);

%ͨ������ʽԼ������������
for k=1:length(g),
    Z=Z+ lam*g(k)^2*getH(g(k));
end
% ��ʽ����Լ��
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

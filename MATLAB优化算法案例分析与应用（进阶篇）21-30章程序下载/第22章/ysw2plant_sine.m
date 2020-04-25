function [sys,x0,str,ts] = spacemodel(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 4;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 4;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0 =[-pi/3,0,0.5,0];
str = [];
ts = [];

function sys=mdlDerivatives(t,x,u)
g=9.8;mc=0.5;m=0.5;l=0.3;
th=x(1);
dth=x(2);

M=[mc+m m*l*cos(th);
m*l*cos(th) m*l^2];
fa=m*l*sin(th)*dth^2;
fu=m*g*l*sin(th);
F=[fa;fu];

U=[u(1);0];

a=inv(M)*(F+U);
ddx=a(1);
ddth=a(2);

sys(1)=x(2);
sys(2)=ddth;     %Pendulum angle
sys(3)=x(4);
sys(4)=ddx;      %Cart

function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);
sys(3)=x(3);
sys(4)=x(4);

function [sys,x0,str,ts] = spacemodel(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];
function sys=mdlOutputs(t,x,u)
thd=u(1);    
dthd=cos(t);
ddthd=-sin(t);

th=u(2);
dth=u(3);

c=15;
e=thd-th;
de=dthd-dth;
s=c*e+de;

fx=25*dth;
b=133;

epc=5;k=10;
ut=1/b*(epc*sign(s)+k*s+c*de+ddthd+fx);

sys(1)=ut;
sys(2)=e;
sys(3)=de;
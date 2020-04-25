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
sizes.NumOutputs     = 1;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0 0];

function sys=mdlOutputs(t,x,u)
x1=u(1);x2=u(2);   %Pendulum angle
x3=u(3);x4=u(4);   %Cart

g=9.8;mc=0.5;m=0.5;l=0.3;
alfaa=1;

%-1,-2,-3
alfau=1+g/(11*l);
nmna=6*l/g*(alfau-1);
nmnu=nmna+6*(alfau-1);

s=alfaa*x4+nmna*x3+l*alfau*x2+l*nmnu*x1;
sr=nmna*x3+l*nmnu*x1;
dsr=nmna*x4+l*nmnu*x2;

Maa=mc+m;
Mau=m*l*cos(x1);
Muu=m*l^2;
fa=m*l*sin(x1)*x2^2;
fu=m*g*l*sin(x1);

xite=3;
fai=0.10;
if abs(s)<=fai
   sat=s/fai;
else
   sat=sign(s);
end

b1=Muu/(Maa*Muu-Mau^2);
b2=-Mau/(Maa*Muu-Mau^2);

f1=(Muu*fa-Mau*fu)/(Maa*Muu-Mau^2);
f2=(-Mau*fa+Maa*fu)/(Maa*Muu-Mau^2);
ut=-1/(alfaa*b1+l*alfau*b2)*(alfaa*f1+l*alfau*f2+dsr+xite*sat);
sys(1)=ut;
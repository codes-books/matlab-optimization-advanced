%CO2插值
clc,clear,close all

load CO2.mat

n0=size(CO2);
t=1:n0(1,1);
t(1,n0(1,1)+1)=31;
t(1,n0(1,1)+2)=36;
t=t';
CO2(n0(1,1)+1,1)=1.2636;
CO2(n0(1,1)+2,1)=1.05;
n1=size(CO2);
j=1;
for i=1:36
    CO2CZ(j,1)=interp1(t,CO2,i,'cubic');
    j=j+1;
end
t=[];
t=[1985:2010,2015,2020];
plot(t,CO2,'bs','linewidth',2)
hold on
grid on
plot(1985:2020,CO2CZ,'ro--','linewidth',2)
xlabel('year')
ylabel('CO2排放强度: tCO2/万元GDP')
legend('已知值','插值点值')
axis tight
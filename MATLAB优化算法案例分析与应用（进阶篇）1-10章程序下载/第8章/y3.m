% 画图
clc,
clear all
close all
load('yc.mat');
x=2005:2020;
hf=figure('units','normalized','position',[0.4 0.4 0.5 0.4]); % [x,y,宽，高]
plot(x,yc(:,1),'rh--','linewidth',2)
hold on
plot(x,yc(:,2),'gs--','linewidth',2)
plot(x,yc(:,3),'bo--','linewidth',2)
plot(x,yc(:,4),'k>--','linewidth',2)
grid on
axis tight
legend('能源消耗量','煤炭消耗量','石油消耗量','天然气消耗量')

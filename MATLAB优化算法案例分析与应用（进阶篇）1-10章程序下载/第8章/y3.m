% ��ͼ
clc,
clear all
close all
load('yc.mat');
x=2005:2020;
hf=figure('units','normalized','position',[0.4 0.4 0.5 0.4]); % [x,y,����]
plot(x,yc(:,1),'rh--','linewidth',2)
hold on
plot(x,yc(:,2),'gs--','linewidth',2)
plot(x,yc(:,3),'bo--','linewidth',2)
plot(x,yc(:,4),'k>--','linewidth',2)
grid on
axis tight
legend('��Դ������','ú̿������','ʯ��������','��Ȼ��������')

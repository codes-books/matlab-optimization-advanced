clc,clear,close all
load('data.mat')
figure('color',[1,1,1])
plot(data(1,:),'ro-','linewidth',2)
hold on
plot(data(2,:),'bp-','linewidth',2)
plot(data(3,:),'cs-','linewidth',2)
plot(data(4,:),'kh-','linewidth',2)
plot(data(5,:),'m.-','linewidth',2,'MarkerSize',18)
plot(data(6,:),'y>-','linewidth',2)
plot(data(7,:),'g*-','linewidth',2)
plot(data(8,:),'b<-','linewidth',2)
grid on
title('关联度分析')
legend('1#','2#','3#','4#','6#','7#','8#','3#和8#')



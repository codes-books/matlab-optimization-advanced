close all;

figure(1);
plot(t,y(:,1),'k',t,y(:,2),'r:','linewidth',2);
legend('实际位置','模拟跟踪位置');
xlabel('time(s)');ylabel('角度响应');

figure(2);
plot(t,u(:,1),'k','linewidth',0.01);
xlabel('time(s)');ylabel('控制输入');

c=15;
figure(3);
plot(e,de,'r',e,-c'.*e,'k','linewidth',2);
xlabel('e');ylabel('de');
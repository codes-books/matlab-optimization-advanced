close all;

figure(1);
plot(t,y(:,1),'k',t,y(:,2),'r:','linewidth',2);
legend('ʵ��λ��','ģ�����λ��');
xlabel('time(s)');ylabel('�Ƕ���Ӧ');

figure(2);
plot(t,u(:,1),'k','linewidth',0.01);
xlabel('time(s)');ylabel('��������');

c=15;
figure(3);
plot(e,de,'r',e,-c'.*e,'k','linewidth',2);
xlabel('e');ylabel('de');
close all;

figure(1);
% subplot(411);
plot(t,x(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('�Ƕ���Ӧ');
% subplot(412);
figure(2);
plot(t,x(:,2),'r','linewidth',2);
xlabel('time(s)');ylabel('�Ǽ��ٶ���Ӧ');
% subplot(413);
figure(3);
plot(t,x(:,3),'r','linewidth',2);
xlabel('time(s)');ylabel('�ڸ�λ����Ӧ');
% subplot(414);
figure(4);
plot(t,x(:,4),'r','linewidth',2);
xlabel('time(s)');ylabel('�ڸ��ٶ���Ӧ');

figure(5);
plot(t,u(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');
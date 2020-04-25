close all;

figure(1);
% subplot(411);
plot(t,x(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('角度响应');
% subplot(412);
figure(2);
plot(t,x(:,2),'r','linewidth',2);
xlabel('time(s)');ylabel('角加速度响应');
% subplot(413);
figure(3);
plot(t,x(:,3),'r','linewidth',2);
xlabel('time(s)');ylabel('摆杆位移响应');
% subplot(414);
figure(4);
plot(t,x(:,4),'r','linewidth',2);
xlabel('time(s)');ylabel('摆杆速度响应');

figure(5);
plot(t,u(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');
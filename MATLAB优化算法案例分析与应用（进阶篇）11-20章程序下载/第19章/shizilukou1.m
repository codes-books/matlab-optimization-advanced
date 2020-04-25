clc,clear,close all
axis([0 100 0 100]);
[x,y] = ginput(2);
line(x,y,'color','k','linewidth',10); 
hold on

[p,q] = ginput(2);
line(p,q,'color','k','linewidth',10); 
n = 20;  % 一条道路
a1 = linspace(x(1),x(2),n);
b1 = linspace(y(1),y(2),n);
% 另一条道路
a2 = linspace(p(1),p(2),n);
b2 = linspace(q(1),q(2),n);
for i = 1:n
    t1x = (rem(i,n)+1);
    t1y = (rem(i,n)+1);
    t2x = (rem(i,n)+1);
    t2y = (rem(i,n)+1);
    t(i)=i;
    S(i)= sqrt((a1(t1x)-a2(t2x))^2+ (b1(t1y)-b2(t2y))^2);
    
h1 = plot(a1(t1x),b1(t1y),'*r')
h2 = plot(a2(t2x),b2(t2y),'*g')
h3 = plot([a1(t1x) a2(t2x)],[b1(t1y) b2(t2y)])
pause(0.2);

end
figure,
plot(t,S,'rs-','linewidth',1)
xlabel('t');ylabel('S')
grid on

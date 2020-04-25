clc,clear,close all
axis([0 100 0 100]);
[x,y] = ginput(2);
line(x,y,'color','k','linewidth',10); 
hold on

[p,q] = ginput(2);
line(p,q,'color','k','linewidth',10); 

nv=1;
for k=5:5:60
    n = k;  % 段数
    a1 = linspace(x(1),x(2),n);
    b1 = linspace(y(1),y(2),n);
    a2 = linspace(p(1),p(2),n);
    b2 = linspace(q(1),q(2),n);
    for i = 1:n
        t1x = (rem(i,n)+1);
        t1y = (rem(i,n)+1);
        t2x = (rem(i,n)+1);
        t2y = (rem(i,n)+1);
        t(i)=i;
        S(i)= sqrt((a1(t1x)-a2(t2x))^2+ (b1(t1y)-b2(t2y))^2);
    end
    Smin(nv) = min(S);
    VH(nv) = sqrt((x(2)-x(1))^2+(y(2)-y(1))^2)/n;
    VG(nv) = sqrt((p(2)-p(1))^2+(q(2)-q(1))^2)/n;
    nv=nv+1;
end
VH1 = 1 : 20;
VG1 = 1 : 20;
[VH2,VG2] = meshgrid(VH1,VG1);
Smin1 = griddata(VH,VG,Smin,VH2,VG2,'v4');
figure,
surf(VH2,VG2,Smin1)
xlabel('红色速度V')
ylabel('绿车速度V')
zlabel('两车过十字路口最小距离')
% 单路边性能分析
clc,clear,close all
figure('color',[1 1 1])
axis([0 100 0 100]);
hold on
nodes = 5;             % 5个节点
PauseTime = 0.05; 
[x,y] = ginput(nodes);  % 高速路段数
plot(x,y,'ks-','LineWidth',8,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','b',...
                'MarkerSize',4)
text(x(1)+3,y(1),'car')
[p,q] = ginput(1);  % 基站
plot(p(1),q(1),'>r','markersize',8,'LineWidth',8)
text(p(1)+4,q(1),'基站AP')

xp = x(1);
yp = y(1);
m = 0; 
kk =1;
dd=[];
for loop = 1 % 执行圈数
    for i = 2:nodes
        xc = x(i);    yc = y(i); 
        xp = x(i-1);  yp = y(i-1);
        m = floor(sqrt((xp-xc)*(xp-xc)+(yp-yc)*(yp-yc)))   % 每个路段进行等分分析
        a1 = linspace(xp,xc,m);
        b1 = linspace(yp,yc,m);
        for j = 2:m
            h1 = plot(a1(j),b1(j),'*r'); % 车辆当前位置
            pt1 = [a1(j);b1(j)];         % 车辆当前位置坐标
            pt2 = [p(1);q(1)];           % 基站坐标
            d = norm(pt1-pt2)           % 基站与车辆之间的2范数
            dd = [dd,d];
            if(d <= 30 )
                h2 = plot([a1(j) p(1)],[b1(j) q(1)],'r','linewidth',2);
                pause(PauseTime);
                set(h2,'Visible','on');
                continue;
            end
            pause(PauseTime);            
            set(h1,'Visible','off');
            kk=kk+1;
        end
    end
end
figure('color',[1 1 1]) 
hold on
nd = size(dd);
t = 0:1/(nd(1,2)-1):1;
for i=1:nd(1,2)
    if dd(i)<=30
        plot(t(i),dd(i),'r*-','markersize',2,'linewidth',6)
    else
        plot(t(i),dd(i),'b*-','markersize',2,'linewidth',6)
    end
end

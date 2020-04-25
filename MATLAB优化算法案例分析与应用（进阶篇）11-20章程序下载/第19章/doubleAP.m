% 双路边性能分析
clc,clear,close all
figure('color',[1 1 1])
axis([0 100 0 100]);
hold on
nodes = 5;              % 5个节点
PauseTime = 0.05; 
[x,y] = ginput(nodes);  % 高速路段数
plot(x,y,'ks-','LineWidth',8,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','b',...
                'MarkerSize',4)
[p,q] = ginput(2);      % 基站1 和 2
plot(p(1),q(1),'>r','markersize',8,'LineWidth',8)
text(p(1)+4,q(1),'基站AP 1')
plot(p(2),q(2),'>r','markersize',8,'LineWidth',8)
text(p(2)+4,q(2),'基站AP 2')

xp = x(1);    
yp = y(1);    
m = 0; 
dd1 =[];dd2=[];
for loop = 1 % :20   % 执行圈数
    for i = 2:nodes
        xc = x(i); 
        yc = y(i); 
        xp = x(i-1);
        yp = y(i-1);
        m = floor(sqrt((xp-xc)*(xp-xc)+(yp-yc)*(yp-yc)));  % 每个路段进行等分分析
        a1 = linspace(xp,xc,m);
        b1 = linspace(yp,yc,m);
        for j = 2:m
            h1 = plot(a1(j),b1(j),'r','linewidth',2);
            pt  = [a1(j);b1(j)];
            pt1 = [p(1);q(1)];
            pt2 = [p(2);q(2)];
            d1 = norm(pt-pt1); 
            d2 = norm(pt-pt2); 
               dd1=[dd1,d1];
               dd2=[dd2,d2];
            if(d1<=20 && d1<d2)
               h2 = plot([a1(j) p(1)],[b1(j) q(1)],'r','linewidth',2);
               pause(PauseTime);
               set(h2,'Visible','on');
               continue
            elseif(d2<=20)
               h3 = plot([a1(j) p(2)],[b1(j) q(2)],'r','linewidth',2);
               pause(PauseTime);
               set(h3,'Visible','on');
               continue;                
            end
            
            pause(PauseTime);            
            set(h1,'Visible','off');
        end
    end
end

figure('color',[1 1 1]) 
hold on
nd = size(dd1);
for i=1:nd(1,2)
    if(dd1(1,i)<dd2(1,i))
        dd(1,i)=dd1(1,i);
    else
        dd(1,i)=dd2(1,i);
    end
end
t = 0:1/(nd(1,2)-1):1;
for i=1:nd(1,2)
    if dd(i)<=20
        plot(t(i),dd(i),'r*-','markersize',2,'linewidth',6)
    else
        plot(t(i),dd(i),'b*-','markersize',2,'linewidth',6)
    end
end

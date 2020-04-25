clc,clear,close all
axis([0 100 0 100]);
hold on
nodes = 5;         % 节点个数
PauseTime = 0.1;   % pause时间
[x,y] = ginput(nodes);
plot(x,y,'-ks','LineWidth',8,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','b',...
                'MarkerSize',8)        
[p,q] = ginput(nodes);
plot(p,q,'-ks','LineWidth',8,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','b',...
                'MarkerSize',8)   
Sa = 5; % 最小安全距离
% 初始化
xp = x(1);
yp = y(1);
pp = p(1);
qp = q(1);
m = 0; 
n = 0; 
k =1 ;
for i = 2:nodes
    xc = x(i); 
    yc = y(i); 
    xp = x(i-1);
    yp = y(i-1);
    pc = p(i);
    qc = q(i);
    pp = p(i-1);
    qp = q(i-1);
    
    m = floor(sqrt((xp-xc)*(xp-xc)+(yp-yc)*(yp-yc)));
    n = floor(sqrt((pp-pc)*(pp-pc)+(qp-qc)*(pp-qc)));
    a1 = linspace(xp,xc,m);
    b1 = linspace(yp,yc,m);
    aa1 = a1;
    bb1 = b1;
    na = length(a1);
    a2 = linspace(pp,pc,m);
    b2 = linspace(qp,qc,m);
    v1(i) = sqrt((xp-xc)*(xp-xc)+(yp-yc)*(yp-yc)) /m;  % 红车1速度
    v2(i) = sqrt((pp-pc)*(pp-pc)+(qp-qc)*(qp-qc)) /m;  % 蓝车2速度
    for j = 2:m
        S(k) = sqrt( (a1(j)-a2(j))^2 + (b1(j)-b2(j))^2 );
        if S(k)<Sa
            S(k) = sqrt( (a1(j-1)-a2(j))^2 + (b1(j-1)-b2(j))^2 );
%             a1(j)=a1(j-1);
%             b1(j)=b1(j-1);            
%             a1(j+1)=a1(j);
%             b1(j+1)=b1(j);
            aa1(j) = a1(j-1);
            aa1(j+1) = a1(j-1);
            aa1 = [aa1(1,1:j+1),a1(1,j:na)];
            bb1(j) = b1(j-1);
            bb1(j+1) = b1(j-1);
            bb1 = [bb1(1,1:j+1),b1(1,j:na)];
            
            h1 = plot(a1(j-1),b1(j-1),'*r','MarkerSize',4);
            h2 = plot(a2(j),b2(j),'*g','MarkerSize',4);
            h3 = plot([a1(j-1) a2(j)],[b1(j-1) b2(j)]);
        else
            h1 = plot(a1(j),b1(j),'*r','MarkerSize',4);
            h2 = plot(a2(j),b2(j),'*g','MarkerSize',4);
            h3 = plot([a1(j) a2(j)],[b1(j) b2(j)]);
        end
        a1 = aa1;
        b1 = bb1;
        pause(PauseTime);
        set(h1,'Visible','off');
        set(h2,'Visible','off');
        k=k+1;
    end
    
end
figure,
plot(S,'r','linewidth',3)
grid on
xlabel('t')
ylabel('S运行距离')
figure,
plot(v1,'sr--','linewidth',3)
hold on
plot(v2,'>g--','linewidth',3)
grid on
xlabel('t')
ylabel('V速度')
legend('红色1速度','蓝车2速度')




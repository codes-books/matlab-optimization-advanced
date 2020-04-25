%%
%参数声明区
L=4000;                         %L为公交线路的总长
b=2;                            %车站标号中间变量初值
N=10;                           %N个车站
Q=4;                            %公交线路运行次数
q=0;                            %q为车辆运行次数控制量
flagn=0;                        %flag为程序运行控制变量
w=10;                           %w为车速
dt=2   ;                      %dett为时间步长
dett1=3 ;                       %dett1为每人上车所用时间
dett2=10 ;                      %dett2为等车人数增长率（每多少时间增加一个等车人）
M=floor(Q*4000/dt/w)+1;       %总的运行步长数
detbus=w*dt;                  %单位时间dett内车所行驶的路程
stopgap=4000/N;              %相邻车站之间的间距（均分）
t=stopgap:stopgap:4000;   %各站点距离始发站（1站）的距离
e=detbus/2;                     %e为车到站上允许的车与车站距离的容差值
n=zeros(N,2);                   %n为各站初始等车人数,到站状态 

xx=linspace(0,4000,N+1);        %公交站点的横坐标
yy=0:1000:4000;                 %公交线路的横坐标
wt=0.01;                        %pause的等待时间
detbusij=zeros(3,M);            %各时刻相邻车辆间的距离
time=stopgap/detbus;         %相邻车站间车辆运行时间
c=floor(M/time)+1;              %设定各车经过的车站数
busn=zeros(4,c);                %设定各车经过各站时上车人数
flag=zeros(4,1);                %车辆通过1站标志
m=0;                            %m为循环次数
%%
%车辆位置初始化，车辆位置可调
bus(1,1)=0;                     %1车初始的行程
bus(2,1)=500;                   %2车初始的行程
bus(3,1)=1000;                  %3车初始的行程
bus(4,1)=1500;                  %4车初始的行程

for j=1:4
    bus(j,2)=0;                 %各车到站标志
    bus(j,3)=floor(bus(j,1)/(4000/N))+1; %初始各车所在/刚过车站的编号
    bus(j,4)=bus(j,1);          %初始各车距离车1位置的距离
    bus(j,5)=0;                 %初始各车等车时间
    bus(j,6)=0;                 %初始各车上车人数
    num(j,1)=1;                 %设置各车经过的车站数
end
%%循环仿真运行
for  k=1:M                             %M为总的时间步数
     n(:,1)=n(:,1)+1.0*dt/dett2;     %按正常规律各站点按时间比例增加等待人数
    for j=1:4
        a=bus(j,3);                    %将各车的所在路段编号付给a
        if a>N                         %该判断语句保证路段编号不超过最大路段编号
                a=a-N;
        end
        %该判断语句判读各车的到站状态
        if  bus(j,2)==0                %各车为到站状态
            bus(j,1)=bus(j,1)+detbus ; %k 时刻各车所在位置
            bus(j,4)=bus(j,4)+detbus ; %k时刻各车距离0位置的总的距离
             if bus(1,4)>=4000*Q
                    flagn=1;
             end
            if bus(j,1)>4000           %该判断语句保证各车位置始终在正常线路上
                bus(j,1)=bus(j,1)-4000;
                if bus(j,1)<e
                       flag(j,1)=1;
                else
                       bus(j,3)=1;     %该语句保证路段编号不超过最大路段编号
                end
            end
            if flag(j,1)==1
                    h=0;
            else 
                    h=t(a);
            end
            m=h-bus(j,1);              %判断各车距下一站的距离
            if abs(m)<=e               %e为车到站上允许的车与车站距离的容差值
                  bus(j,2)=1;          %确定到站后，更改各车到站标志           
            end
        else                           %各车到站状态
            b=a+1;
            if  b>N                    %该判断语句保证车站编号不超过最大车站编号
                b=b-N;
            end
            if n(b,1)>1.0*dt/dett1
                  bus(j,6)=bus(j,6)+1.0*dt/dett1; %各车上车人数
            elseif  n(b,1)>0      
                  bus(j,6)=bus(j,6)+n(b,1);         %各车上车人数
            else  
                  bus(j,6)=bus(j,6)+0;              %各车上车人数
            end
           n(b,1)=n(b,1)-1.0*dt/dett1;            %车到站后，按正常规律各站点按时间比例减少上车人数
            if  n(b,1)<=0
                n(b,1)=0;
                num(j,1)=num(j,1)+1;                %增加经过车站数量
                d=num(j,1);             
                busn(j,d)=bus(j,6) ;                %刚经过的车站上车人数
                bus(j,6)=0;                         %将车辆上车人数清零
                n(b,2)=1;                           %更改各站上车/等车状态更改各车到站标志
                if flag(j,1)==1
                            bus(j,3)=1;             %变更各车所在/刚过路段的编号
                            flag(j,1)=0;            %变更过1站标志
               else
                            bus(j,3)=a+1;           %变更各车所在/刚过路段的编号
               end
            end
            if n(b,2)==1                            %该判断语句判断是否更改各车到站标志
                 n(b,2)=0;                          %更改各站上车/等车状态更改各车到站标志
                 bus(j,2)=0;                        %更改各车到站标志
            end
      end
    end 
    plot(xx(1:end-1),ones(1,N)*L,'.','Markersize',6);   %画公交站点和公交线路
    hold on;
    plot(yy,ones(1,length(yy))*L,'-');                  %画bus路线
    plot(bus(1,1),L,'sk','MarkerFaceColor','r','Markersize',15);                    %画bus1路线
    plot(bus(2,1),L,'sk','MarkerFaceColor','g','Markersize',15);                    %画bus2路线
    plot(bus(3,1),L,'sk','MarkerFaceColor','c','Markersize',15);                    %画bus3路线
    plot(bus(4,1),L,'sk','MarkerFaceColor','y','Markersize',15);                    %画bus4路线
    axis equal
    for j=1:N;                                             %循环语句显示各站等车人数
        r=L;
        r=r-n(j,1);                                        %以线长表示等车人数多少
        GRAP=plot([xx(j),xx(j)],[L,r],'-','LineWidth', 6);%绘图
              
    end
    pause(wt);                                             %控制仿真效果
    hold off;
    m=k;
    detbusij(1,k)=bus(2,4)-bus(1,4);
    detbusij(2,k)=bus(3,4)-bus(2,4);
    detbusij(3,k)=bus(4,4)-bus(3,4);
    detbusij;
    if flagn==1
        break;
    end
end
Max=max(num);
busnum=busn(:,1:Max) ;                                     %busnum为各车经过各站的上车人数
detbusijnum=detbusij*L ;                                  %detbusijnum为相邻车间的车间距
busnum'                                                    %输出各车经过各站的上车人数
detbusijnum'                                               %输出相邻车间的车间距

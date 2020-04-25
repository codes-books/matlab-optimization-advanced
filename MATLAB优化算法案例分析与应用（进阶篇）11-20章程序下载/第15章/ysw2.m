% 产生t(i)序列
clc,clear,close all
warning off
Tmin = 1;   % 表示相邻车辆间发车间隔的最小值(min)
Tmax = 10;  % 表示相邻车辆间发车间隔的最大值(min)
delta = 4;  % 表示相邻车辆发车间隔之差的限制值
m = 500;    % 表示总的发车次数(车次)
a = randi(10);  % t(1)第一个值的取值范围设定为1-10之间随机取值
t(1) = a;       % 赋值
maxt = 960;    % t(i)的最大值
% Loop
for i=2:m
    flag = 1;       % 标志变量
    while flag == 1
        % Tmin< t(i)-t(i-1) < Tmax
        a1 = randi(9);
        if a1>Tmin+2 && i==2
            t(i)=t(i-1)+a1; % Tmin < t(i)-t(i-1) < Tmax
            flag = 0;   % i 时间点计算完毕
        elseif a1>Tmin+2 && i>2  % |t(i+1)-2*t(i)+t(i-1)|<delta 
            t(i)=t(i-1)+a1; % Tmin < t(i)-t(i-1) < Tmax
            if abs( (t(i)-t(i-1)) -(t(i-1)-t(i-2)) )<delta
                flag = 0;  % i 时间点计算完毕
            end
        end
    end
end
tt = t*maxt/max(t);
ttt = -tt(1:499)+tt(2:500);


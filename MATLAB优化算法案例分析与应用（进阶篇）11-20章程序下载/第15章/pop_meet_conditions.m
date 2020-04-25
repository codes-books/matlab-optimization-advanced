% 产生t(i)序列
function t = pop_meet_conditions(maxt)
global Tmin Tmax delta m tt PP Q cita
% 输入变量说明：
% Tmin = 1;   % 表示相邻车辆间发车间隔的最小值(min)
% Tmax = 10;  % 表示相邻车辆间发车间隔的最大值(min)
% delta = 4;  % 表示相邻车辆发车间隔之差的限制值
% m = 500;    % 表示总的发车次数(车次)
% maxt = 960;    % t(i)的最大值

% 输出变量说明：
% t为满足条件的个体

a = randi(10);  % t(1)第一个值的取值范围设定为1-10之间随机取值
t(1) = a;       % 赋值

flag = 1;       % 标志变量
% Loop
while flag==1
    
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
    
    t = t*maxt/max(t);  % tt为满足条件的个体
 
    % 平均满载率进行约束
 for i=1:length(t)
    if t(i)<60
        r(i) = 1638;
    elseif t(i)>=60&&t(i)<180
        r(i) = 3276;
    elseif t(i)>=180&&t(i)<240
        r(i) = 2457;
    elseif t(i)>=240&&t(i)<300
        r(i) = 1638;
    elseif t(i)>=300&&t(i)<480
        r(i) = 819;
    elseif t(i)>=480&&t(i)<600
        r(i) = 1638;
    elseif t(i)>=600&&t(i)<660
        r(i) = 2457;
    elseif t(i)>=660&&t(i)<780
        r(i) = 3276;
    elseif t(i)>=780&&t(i)<840
        r(i) = 2457;
    elseif t(i)>=840&&t(i)<900
        r(i) = 1638;
    elseif t(i)>=900
        r(i) = 819;
    end  
 end

 % 约束条件
if sum(r*tt*PP)/m/Q > cita   % 平均满载率进行约束
    flag = 0;
end

end



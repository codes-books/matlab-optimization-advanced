% ����t(i)����
clc,clear,close all
warning off
Tmin = 1;   % ��ʾ���ڳ����䷢���������Сֵ(min)
Tmax = 10;  % ��ʾ���ڳ����䷢����������ֵ(min)
delta = 4;  % ��ʾ���ڳ����������֮�������ֵ
m = 500;    % ��ʾ�ܵķ�������(����)
a = randi(10);  % t(1)��һ��ֵ��ȡֵ��Χ�趨Ϊ1-10֮�����ȡֵ
t(1) = a;       % ��ֵ
maxt = 960;    % t(i)�����ֵ
% Loop
for i=2:m
    flag = 1;       % ��־����
    while flag == 1
        % Tmin< t(i)-t(i-1) < Tmax
        a1 = randi(9);
        if a1>Tmin+2 && i==2
            t(i)=t(i-1)+a1; % Tmin < t(i)-t(i-1) < Tmax
            flag = 0;   % i ʱ���������
        elseif a1>Tmin+2 && i>2  % |t(i+1)-2*t(i)+t(i-1)|<delta 
            t(i)=t(i-1)+a1; % Tmin < t(i)-t(i-1) < Tmax
            if abs( (t(i)-t(i-1)) -(t(i-1)-t(i-2)) )<delta
                flag = 0;  % i ʱ���������
            end
        end
    end
end
tt = t*maxt/max(t);
ttt = -tt(1:499)+tt(2:500);


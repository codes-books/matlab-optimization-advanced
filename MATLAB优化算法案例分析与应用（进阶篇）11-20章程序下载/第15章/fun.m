function fitt = fun(t)
%该函数用来计算适应度值
global PP C L m f p tt
% PP = 1;    % 表示统一票价(元/人)
% C = 3.5;  % 表示车辆运营的单位损耗成本(元/车.公里)
% L = 26.5; % 表示调研线路总的长度(公里)
% m = 500;  % 表示总的发车次数(车次)
% f = 2;    % 表示乘务员人数
% p = 10;   % 表示乘务员工资

fitt=0;      % 初始化
for i=1:length(t)
    if t(i)<60
        r = 1638;
    elseif t(i)>=60&&t(i)<180
        r = 3276;
    elseif t(i)>=180&&t(i)<240
        r=2457;
    elseif t(i)>=240&&t(i)<300
        r = 1638;
    elseif t(i)>=300&&t(i)<480
        r = 819;
    elseif t(i)>=480&&t(i)<600
        r=1638;
    elseif t(i)>=600&&t(i)<660
        r = 2457;
    elseif t(i)>=660&&t(i)<780
        r = 3276;
    elseif t(i)>=780&&t(i)<840
        r = 2457;
    elseif t(i)>=840&&t(i)<900
        r = 1638;
    elseif t(i)>=900
        r = 819;
    end
    
    fitt = fitt + r*tt*PP - (C*L*m+tt*f*p);   % R'自适应度
    
end








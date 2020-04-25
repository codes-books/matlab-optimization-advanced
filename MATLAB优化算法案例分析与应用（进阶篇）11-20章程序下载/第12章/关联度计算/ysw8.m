clc,clear;close all
warning off
X0 = xlsread('数据','8#','B3:B18');  % EXCEL数据
X1 = xlsread('数据','8#','E3:E18');  % EXCEL数据
X2 = xlsread('数据','8#','G3:G18');  % EXCEL数据
X3 = xlsread('数据','8#','I3:I18');  % EXCEL数据
X4 = xlsread('数据','8#','K3:K18');  % EXCEL数据
X5 = xlsread('数据','8#','M3:M18');  % EXCEL数据
y = [X0,X1,X2,X3,X4,X5]';
y = mapminmax(y);    % 归一化
y1=mean(y');  % 均值
y1=y1';       % 转置  ---  一列显示
for i=1:size(y,1)
    for j=1:size(y,2)
        y2(i,j)=y(i,j)/y1(i);    %  初值像矩阵
    end
end
for i=2:size(y,1)
    for j=1:size(y,2)
        y3(i-1,j)=abs(y2(i,j)-y2((i-1) ,j)); % 差序列
    end
end
a=1;b=0;
for i=1:size(y,1)-1
    for j=1:size(y,2)
        if (y3(i,j)<=a)  
            a=y3(i,j);  % min min 差序列
        elseif (y3(i,j)>=b)
            b=y3(i,j);  % max max 差序列
        end
    end
end
for i=1:size(y,1)-1
    for j=1:size(y,2)
        y4(i,j)=(a+0.5*b)/(y3(i,j)+0.5*b);  % 关联系数
    end
end
y5=sum(y4')/(size(y,2)-1)     % 关联度

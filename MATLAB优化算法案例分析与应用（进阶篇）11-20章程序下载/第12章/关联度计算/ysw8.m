clc,clear;close all
warning off
X0 = xlsread('����','8#','B3:B18');  % EXCEL����
X1 = xlsread('����','8#','E3:E18');  % EXCEL����
X2 = xlsread('����','8#','G3:G18');  % EXCEL����
X3 = xlsread('����','8#','I3:I18');  % EXCEL����
X4 = xlsread('����','8#','K3:K18');  % EXCEL����
X5 = xlsread('����','8#','M3:M18');  % EXCEL����
y = [X0,X1,X2,X3,X4,X5]';
y = mapminmax(y);    % ��һ��
y1=mean(y');  % ��ֵ
y1=y1';       % ת��  ---  һ����ʾ
for i=1:size(y,1)
    for j=1:size(y,2)
        y2(i,j)=y(i,j)/y1(i);    %  ��ֵ�����
    end
end
for i=2:size(y,1)
    for j=1:size(y,2)
        y3(i-1,j)=abs(y2(i,j)-y2((i-1) ,j)); % ������
    end
end
a=1;b=0;
for i=1:size(y,1)-1
    for j=1:size(y,2)
        if (y3(i,j)<=a)  
            a=y3(i,j);  % min min ������
        elseif (y3(i,j)>=b)
            b=y3(i,j);  % max max ������
        end
    end
end
for i=1:size(y,1)-1
    for j=1:size(y,2)
        y4(i,j)=(a+0.5*b)/(y3(i,j)+0.5*b);  % ����ϵ��
    end
end
y5=sum(y4')/(size(y,2)-1)     % ������

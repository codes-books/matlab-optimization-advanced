%% 回归分析DW检验
clc,clear,close all
format long
ysw1;        % 加载数据
n0=size(data1);
a=mean(data1);
a1=std(data1);
mstdata=zscore(data1);

X=mstdata(:,3:6);
X=[ones(n0(1,1),1),X];
Y=mstdata(:,2); 
[b,bint,r,rint,s]=regress(Y,X);

yuc = b(1)+b(2)*mstdata(:,3)+b(3)*mstdata(:,4)+b(4)*mstdata(:,5)+b(5)*mstdata(:,6);
n1=size(yuc);
for i=1:n1(1,1)
    for j=2
        yu(i,j-1)=yuc(i,j-1)*a1(1,j)+a(1,j);   %反归一化操作
    end
end

error = data1(:,2)-yu;
e1=error(1:n0(1,1)-1,:);
e2=error(2:n0(1,1),:);
delta=0;
E2=0;
for i=1:n0(1,1)-1
    delta=delta+(e2(i,1)-e1(i,1))*(e2(i,1)-e1(i,1));
    E2=E2+e2(i,1)*e2(i,1);
end
DW=delta/E2
rou = 2-DW/2
figure('color',[1 1 1])
plot(e1,e2,'+')
xlabel('e1')
ylabel('e2')
title('模型DW检验')
%% �ع����  -- ������
clc,clear,close all
format long
ysw1;        % ��������
n0=size(data1);
a=mean(data1);
a1=std(data1);
mstdata=zscore(data1);

figure('color',[1 1 1])
X=mstdata(:,3:6);
X=[ones(n0(1,1),1),X];
Y=mstdata(:,2); 
[b,bint,r,rint,s]=regress(Y,X)
rcoplot(r,rint)

yuc = b(1)+b(2)*mstdata(:,3)+b(3)*mstdata(:,4)+b(4)*mstdata(:,5)+b(5)*mstdata(:,6);
n1=size(yuc);
for i=1:n1(1,1)
    for j=2
        yu(i,j-1)=yuc(i,j-1)*a1(1,j)+a(1,j);   %����һ������
    end
end

figure('color',[1 1 1])
plot(data1(:,1),data1(:,2),'r.-','linewidth',2)
hold on
plot(data1(:,1),yu,'bo-','linewidth',2)
xlabel('ʱ���');  ylabel(' ͨ����');  grid off; axis tight
legend('ԭʼ�ź�','�ع�Ԥ��')

error_hg= data1(:,2)-yu;
save error_hg.mat error_hg

%%
%% �ع����  -- �ܻط���
clc,clear,close all
format long
ysw1;        % ��������
n0=size(data2);
a=mean(data2);
a1=std(data2);
mstdata=zscore(data2);

figure('color',[1 1 1])
X=mstdata(:,3:6);
X=[ones(n0(1,1),1),X];
Y=mstdata(:,2); 
[b,bint,r,rint,s]=regress(Y,X)
rcoplot(r,rint)

yuc = b(1)+b(2)*mstdata(:,3)+b(3)*mstdata(:,4)+b(4)*mstdata(:,5)+b(5)*mstdata(:,6);
n1=size(yuc);
for i=1:n1(1,1)
    for j=2
        yu(i,j-1)=yuc(i,j-1)*a1(1,j)+a(1,j);   %����һ������
    end
end

figure('color',[1 1 1])
plot(data2(:,1),data2(:,2),'r.-','linewidth',2)
hold on
plot(data2(:,1),yu,'bo-','linewidth',2)
xlabel('ʱ���');  ylabel(' ͨ����');  grid off; axis tight
legend('ԭʼ�ź�','�ع�Ԥ��')

error_hg_2= data1(:,2)-yu;
save error_hg_2.mat error_hg_2

% �ع�ģ��
clc,clear
load mstdata1.mat
n0=size(mstdata);
a=mean(mstdata);  % ��ֵ
% %a=mean(a');
a1=std(mstdata);   % ����
% %b=std(b');
% for i=1:n0(1,2)
%     for j=1:n0(1,1)
%         mstdata(j,i)=(mstdata(j,i)-a(1,i))/b(1,i);
%     end
% end
% 
mstdata=zscore(mstdata);  %��׼��
xs12010 = mstdata(26,1); %2010��ú̿
xs22010 = mstdata(26,2); %2010��ʯ��
xs32010 = mstdata(26,3); %2010����Ȼ��

xs12005 = mstdata(21,1); %2005��ú̿
xs22005 = mstdata(21,2); %2005��ʯ��
xs32005 = mstdata(21,3); %2005����Ȼ��

figure(1),
X=mstdata(:,1:3);
X=[ones(n0(1,1),1),X];
Y=mstdata(:,n0(1,2)); 
[b,bint,r,rint,s]=regress(Y,X);
rcoplot(r,rint)

%%
%ɾ��һЩ�쳣��
j=1;
for i=1:n0(1,1)
    if i~=21
        Cmstdata(j,:)=mstdata(i,:);
        j=j+1;
    end
end
figure(2),
n1=size(Cmstdata);
X=Cmstdata(:,1:3);
X=[ones(n1(1,1),1),X];
Y=Cmstdata(:,n1(1,2)); 
[b,bint,r,rint,s]=regress(Y,X)
rcoplot(r,rint)

% %%
% x1=0*a1(1,1)+a(1,1)
% x2=0*a1(1,2)+a(1,2)
% x3=1.431741*a1(1,3)+a(1,3)

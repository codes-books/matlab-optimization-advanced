%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ָ��ͼ��ϸ��������ȡ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
origin=imread('im2.bmp');
subplot(2,2,1);imagesc(origin);
colormap(gray); xlabel('(a)ԭʼͼ��')
I=im2bw(origin);  % ��ֵ��
%ϸ��ָ��ͼ����ƥ��ģ�巨
[M,N]=size(I);
for i=2:M-1
    for j=2:N-1
        if I(i,j)==0
            if (I(i-1,j)==0&I(i,j+1)==0)|(I(i-1,j)==0&I(i,j-1)==0)|(I(i+1,j)==0&I(i,j-1)==0)|(I(i+1,j)==0&I(i,j+1)==0)
                I(i,j)=1;
            else
                I(i,j)=0;
            end
        end
    end
end
subplot(2,2,2);imagesc(I);
xlabel('(b)ϸ�����ָ��ͼ��')
%��������ȡ���˵�򽻲�㣩
t=0;
for i=2:M-1
    for j=2:N-1
        if I(i,j)==0
            n=I(i-1,j-1)+I(i-1,j)+I(i-1,j+1)+I(i,j-1)+I(i,j+1)+I(i+1,j-1)+I(i+1,j)+I(i+1,j+1);
            if (n==7|n==5)
                t=t+1;
                x(t)=j;
                y(t)=i;
            end
        end
    end
end
subplot(2,2,3);imagesc(I);
xlabel('(c)ϸ�����ָ��ͼ��')
hold on;plot(x,y,'bo');hold off;   
for i=1:t-1
    for j=i+1:t   %ָ������ȥα
        d=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
        if d<6            %ȥ������Ͻ���������
            x(i)=-1;y(i)=-1;x(j)=-1;y(j)=-1;
        end
    end
end
c=0;
d=0;
for i=1:t
    if (x(i)>=10&x(i)<165)&(y(i)>=10&y(i)<140)   %ȥ����Ե��������
        c=c+1;l(c)=x(i);d=d+1;h(d)=y(i);
    end
end
x=find(x);y=find(y);
subplot(2,2,4);imagesc(I);
xlabel('(d)ϸȥα���ָ��ͼ��������')
hold on;plot(l,h,'bo');hold off;


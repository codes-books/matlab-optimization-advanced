%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 指纹图像细节特征提取
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
origin=imread('im2.bmp');
subplot(2,2,1);imagesc(origin);
colormap(gray); xlabel('(a)原始图像')
I=im2bw(origin);  % 二值化
%细化指纹图像，用匹配模板法
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
xlabel('(b)细化后的指纹图像')
%特征点提取（端点或交叉点）
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
xlabel('(c)细化后的指纹图像')
hold on;plot(x,y,'bo');hold off;   
for i=1:t-1
    for j=i+1:t   %指纹特征去伪
        d=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
        if d<6            %去除距离较近的特征点
            x(i)=-1;y(i)=-1;x(j)=-1;y(j)=-1;
        end
    end
end
c=0;
d=0;
for i=1:t
    if (x(i)>=10&x(i)<165)&(y(i)>=10&y(i)<140)   %去除边缘的特征点
        c=c+1;l(c)=x(i);d=d+1;h(d)=y(i);
    end
end
x=find(x);y=find(y);
subplot(2,2,4);imagesc(I);
xlabel('(d)细去伪后的指纹图像特征点')
hold on;plot(l,h,'bo');hold off;


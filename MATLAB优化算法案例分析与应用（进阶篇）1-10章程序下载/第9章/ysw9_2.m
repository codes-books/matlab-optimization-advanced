clc,clear,close all
img=imread('1.jpg');
subplot(121),imshow(img),xlabel('原始图像')
img_1=img(:,:,1);
img_2=img(:,:,2);
img_3=img(:,:,3);
Y=0.299*img_1+0.587*img_2+0.114*img_3;  % 白平衡系数
[m,n]=size(Y);
k=Y(1,1);
for i=1:m
    for j=1:n
        if Y(i,j)>=k
            k=Y(i,j);
            k1=i;
            k2=j;
        end
    end
end
[m1,n1]=find(Y==k);
Rave=sum(sum(img_1));
Rave=Rave/(m*n);
Gave=sum(sum(img_2));
Gave=Gave/(m*n);
Bave=sum(sum(img_3));
Bave=Bave/(m*n);
Kave=(Rave+Gave+Bave)/3;
img__1=(Kave/Rave)*img_1;
img__2=(Kave/Gave)*img_2;
img__3=(Kave/Bave)*img_3;
imgysw=cat(3,img__1,img__2,img__3);
subplot(122),imshow(imgysw),xlabel('白平衡处理结果')
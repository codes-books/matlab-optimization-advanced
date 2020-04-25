clc,clear,close all
rgb=imread('xbb2.jpg');
% imshow(rgb);
r = rgb(:, :, 1);
g = rgb(:, :, 2);
b = rgb(:, :, 3);
[m,n]=size(r);
for i=1:m
    for j=1:n
      if (r(i,j)>=200&&r(i,j)<=255)&&(g(i,j)>120&&g(i,j)<=255)&&(b(i,j)>=100&&b(i,j)<=220)%改皮肤色
            r(i,j)=150;g(i,j)=250;b(i,j)=250;
      end
      if (r(i,j)>220&&r(i,j)<=255)&&(g(i,j)>220&&g(i,j)<=255)&&(b(i,j)>215&&b(i,j)<255)%改白色
            r(i,j)=255;g(i,j)=0;b(i,j)=255;
      end
      if (r(i,j)>40&&r(i,j)<=200)&&(g(i,j)>30&&g(i,j)<=205)&&(b(i,j)>0&&b(i,j)<180)%改黑色
%             r(i,j)=0;g(i,j)=255;b(i,j)=0;
            r(i,j)=120;g(i,j)=155;b(i,j)=255;
      end
    end
end
color11=cat(3,r,g,b);
subplot(121),imshow(rgb);title('原始图像')
subplot(122),imshow(color11);title('分割后图像')
% figure,imshow(color11);

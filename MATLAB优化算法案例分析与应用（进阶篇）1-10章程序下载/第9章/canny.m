%% Canny
clc,clear,close all
im=imread('1.jpg');  % 载入图像
im=im2double(im);
r=im(:,:,1);g=im(:,:,2);b=im(:,:,3);
% 滤波器平滑系数
filter= [2 4 5 4 2;
         4 9 12 9 4;
         5 12 15 12 5;
         4 9 12 9 4;
         2 4 5 4 2];
filter=filter/115;
% N-dimensional convolution
smim= convn(im,filter); 
% imshow(smim);title('Smoothened image');

% 计算梯度
gradXfilt=[-1 0 1; % 卷积模板convolution mask
           -2 0 2; 
           -1 0 1];
gradYfilt=[1  2   1; % 卷积模板 convolution mask
           0  0   0; 
          -1  -2  -1];
GradX= convn(smim,gradXfilt);
GradY= convn(smim,gradYfilt);
absgrad=abs(GradX)+abs(GradY);
% computing angle of gradients
[a,b]=size(GradX);
theta=zeros([a b]);
for i=1:a
      for j=1:b
            if(GradX(i,j)==0)
               theta(i,j)=atan(GradY(i,j)/0.000000000001);
            else
                theta(i,j)=atan(GradY(i,j)/GradX(i,j));
            end
      end
 end
  theta=theta*(180/3.14);
  for i=1:a
      for j=1:b
            if(theta(i,j)<0)
                theta(i,j)= theta(i,j)-90;
                theta(i,j)=abs(theta(i,j));
            end
      end
 end
  for i=1:a
      for j=1:b
          if ((0<theta(i,j))&&(theta(i,j)<22.5))||((157.5<theta(i,j))&&(theta(i,j)<181))
                theta(i,j)=0;
          elseif (22.5<theta(i,j))&&(theta(i,j)<67.5)
                 theta(i,j)=45;
          elseif (67.5<theta(i,j))&&(theta(i,j)<112.5)  
                  theta(i,j)=90;
          elseif (112.5<theta(i,j))&&(theta(i,j)<157.5)
                  theta(i,j)=135;
          end
      end
  end 

%non-maximum suppression
nmx = padarray(absgrad, [1 1]);
[a,b]=size(theta);
for i=2:a-2
    for j=2:b-2
           if (theta(i,j)==135)
                 if ((nmx(i-1,j+1)>nmx(i,j))||(nmx(i+1,j-1)>nmx(i,j)))
                      nmx(i,j)=0;
                  end
           elseif (theta(i,j)==45)   
                  if ((nmx(i+1,j+1)>nmx(i,j))||(nmx(i-1,j-1)>nmx(i,j)))
                       nmx(i,j)=0;
                  end
           elseif (theta(i,j)==90)   
                  if ((nmx(i,j+1)>nmx(i,j))||(nmx(i,j-1)>nmx(i,j)))
                      nmx(i,j)=0;
                  end
           elseif (theta(i,j)==0)   
                  if ((nmx(i+1,j)>nmx(i,j))||(nmx(i-1,j)>nmx(i,j)))
                      nmx(i,j)=0;
                  end
           end
    end
end

nmx1=im2uint8(nmx); % 图像数据类型转换
tl=85;  % 阈值下限lower threshold
th=100; % 阈值上限upper threshold

% grouping edges based on threshold
[a,b]=size(nmx1);
gedge=zeros([a,b]);
for i=1:a
    for j=1:b
        if(nmx1(i,j)>th)
             gedge(i,j)=nmx1(i,j);
        elseif (tl<nmx1(i,j))&&(nmx1(i,j)<th)
             gedge(i,j)=nmx1(i,j);
        end
    end
end

[a,b]= size(gedge);
finaledge=zeros([a b]);
for i=1:a
    for j=1:b
        if (gedge(i,j)>th)
            finaledge(i,j)=gedge(i,j);
             for i2=(i-1):(i+1)
                 for j2= (j-1):(j+1)
                     if (gedge(i2,j2)>tl)&&(gedge(i2,j2)<th)
                         finaledge(i2,j2)=gedge(i,j);
                     end
                 end
              end
        end
   end
end

%clearing the border
finaledge= im2uint8(finaledge(10:end-10,10:end-10));
  
subplot(131);imshow(absgrad);title('image gradients'); 
subplot(132);imshow(nmx);title('NonMaximum Suppression');
subplot(133);imshow(finaledge(:,1:452-10));title('canny edge detection');

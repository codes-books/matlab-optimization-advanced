%指纹特征点(细节点)提取
clc,clear,close all
%% Read Input Image
binary_image=im2bw(imread('2.bmp'));
% figure;imshow(binary_image);title('Input image');
%% Small region is taken to show output clear
binary_image = binary_image(30:460,25:350); %截取其中一部分
figure;imshow(binary_image);title('Input image');
%% Thinning
thin_image=~bwmorph(binary_image,'thin',Inf);
figure;imshow(thin_image);title('Thinned Image');
% load('ridge.mat')
% load('bifurcation.mat')
% hold on
% plot(ridge_y,ridge_x,'r*')
% plot(bifurcation_y,bifurcation_x,'b.','markersize',8)

%% Minutiae extraction
s=size(thin_image);
N=3;%window size
n=(N-1)/2;
r=s(1)+2*n;
c=s(2)+2*n;
double temp(r,c);   
temp=zeros(r,c);bifurcation=zeros(r,c);ridge=zeros(r,c);   % ‘0’ 表示全黑色
temp((n+1):(end-n),(n+1):(end-n))=thin_image(:,:);
outImg=zeros(r,c,3);           % For Display
outImg(:,:,1) = temp .* 255;
outImg(:,:,2) = temp .* 255;
outImg(:,:,3) = temp .* 255;
for x=(n+1+10):(s(1)+n-10)
    for y=(n+1+10):(s(2)+n-10)
        e=1;
        for k=x-n:x+n
            f=1;
            for l=y-n:y+n
                mat(e,f)=temp(k,l);
                f=f+1;
            end
            e=e+1;
        end;
         if(mat(2,2)==0)
            ridge(x,y)=sum(sum(~mat));
            bifurcation(x,y)=sum(sum(~mat));
         end
    end;
end;
hold on
%% 纹数
[ridge_x ridge_y]=find(ridge==2);
plot(ridge_y,ridge_x,'r*')

%% 分叉点
[bifurcation_x bifurcation_y]=find(bifurcation==4);
plot(bifurcation_y,bifurcation_x,'b.','markersize',8)

save ridge.mat ridge_x ridge_y
save bifurcation.mat bifurcation_x bifurcation_y
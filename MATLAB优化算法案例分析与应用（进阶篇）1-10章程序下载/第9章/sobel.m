%% Sobel
clc,clear,close all
I=imread('1.jpg');  % 读入图像
r=I(:,:,1);g=I(:,:,2);b=I(:,:,3);
nI=size(r);
im = single(I) / 255;

	yfilter = fspecial('sobel'); % sobel
	xfilter = yfilter';
	
	rx = imfilter(im(:,:,1), xfilter);
	gx = imfilter(im(:,:,2), xfilter);
	bx = imfilter(im(:,:,3), xfilter);
	
	ry = imfilter(im(:,:,1), yfilter);
	gy = imfilter(im(:,:,2), yfilter);
	by = imfilter(im(:,:,3), yfilter);
	
	Jx = rx.^2 + gx.^2 + bx.^2;
	Jy = ry.^2 + gy.^2 + by.^2;
	Jxy = rx.*ry + gx.*gy + bx.*by;

	D = sqrt(abs(Jx.^2 - 2*Jx.*Jy + Jy.^2 + 4*Jxy.^2)); % 2x2 matrix J'*J的第一个特征值
	e1 = (Jx + Jy + D) / 2;
	%  e2 = (Jx + Jy - D) / 2;   %第二个特征值

edge_magnitude = sqrt(e1);
edge_orientation = atan2(-Jxy, e1 - Jy);
% figure,
% subplot(121),imshow(edge_magnitude)
% subplot(122),imshow(edge_orientation)

sob=edge(edge_magnitude,'sobel',0.29);
% sob=bwareaopen(sob,100);
% figure,imshow(y),title('Sobel Edge Detection')

% 3*3 sobel
f=edge_magnitude;
sx=[-1 0 1;-2 0 2;-1 0 1]; % 卷积模板convolution mask
sy=[-1 -2 -1;0 0 0;1 2 1]; % 卷积模板convolution mask
for x=2:1:nI(1,1)-1
    for y=2:1:nI(1,2)-1
        mod=[f(x-1,y-1),2*f(x-1,y),f(x-1,y+1);
            f(x,y-1),2*f(x,y),f(x,y+1);
            f(x+1,y-1),2*f(x+1,y),f(x+1,y+1)];
        mod=double(mod);
        fsx=sx.*mod;
        fsy=sy.*mod;
        ftemp(x,y)=sqrt((sum(fsx(:)))^2+(sum(fsy(:)))^2);
    end
end
fs=im2bw(ftemp); % fs=im2uint8(ftemp);
fs=bwareaopen(fs,500);
% figure,imshow(fs);title('Sobel Edge Detection')

subplot(131),imshow(edge_magnitude),title('edge magnitude')
subplot(132),imshow(sob),title('edge magnitude extraction')
subplot(133),imshow(fs);title('sobel Edge Detection')






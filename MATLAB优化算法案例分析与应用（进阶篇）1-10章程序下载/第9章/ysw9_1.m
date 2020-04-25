clear
close all;
ps=imread('1.jpg');
subplot(121),imshow(ps)
background=imopen(ps,strel('disk',4));
% imshow(background);
subplot(122),surf(double(background(1:4:end,1:4:end))),zlim([0 256]);
set(gca,'Ydir','reverse');
% ps2=imsubtract(ps,background);
% figure,imshow(ps2)
% axis([0 280 60 260])
% plot(ps(1:280,110));
% figure,plot(ps(1:280,180));

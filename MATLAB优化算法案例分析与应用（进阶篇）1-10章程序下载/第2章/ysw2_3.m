clc,clear,close all
warning off
im1 = imread('1.jpg');  im1 = im2double(im1);
im2 = imread('30.jpg'); im2 = im2double(im2);
im3 = imread('60.jpg'); im3 = im2double(im3);
im4 = imread('80.jpg'); im4 = im2double(im4);
im6 = imread('145.jpg'); % im6 = im2double(im6);
T = 20;
im5 = (im1+im2+im3+im4)/4;  im5 = im2uint8(im5);
im1 = im2uint8(im1);   im2 = im2uint8(im2);
im3 = im2uint8(im3);   im4 = im2uint8(im4);
im15 = im1-im5; im15 = im15(:,:,1) > T;
figure,imshow(im15,[])
im25 = im2-im5; im25 = im25(:,:,1) > T;
figure,imshow(im25,[])
im35 = im3-im5; im35 = im35(:,:,1) > T;
figure,imshow(im35,[])
im45 = im4-im5; im45 = im45(:,:,1) > T;
figure,imshow(im45,[])
im65 = im6-im5; im65 = im65(:,:,1) > T;
figure,imshow(im65,[])

clc,clear,close all
warning off
im1 = imread('1.jpg');  im1 = im2double(im1);
im2 = imread('30.jpg'); im2 = im2double(im2);
im3 = imread('60.jpg'); im3 = im2double(im3);
im4 = imread('80.jpg'); im4 = im2double(im4);
im5 = (im1+im2+im3+im4)/4;
figure,imshow(im5,[])




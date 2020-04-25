clc,clear,close all
warning off
im1 = imread('19.jpg'); % im1 = im2double(im1);
im2 = imread('20.jpg'); % im2 = im2double(im2);
im3 = imread('79.jpg'); % im3 = im2double(im3);
im4 = imread('80.jpg'); % im4 = im2double(im4);
im5 = imread('139.jpg');% im5 = im2double(im5);
im6 = imread('140.jpg');% im6 = im2double(im6);
T = 20;
im12 = im2-im1; im12 = im12(:,:,1) > T;
figure,imshow(im12,[])
im34 = im4-im3; im34 = im34(:,:,1) > T;
figure,imshow(im34,[])
im56 = im6-im5; im56 = im56(:,:,1) > 20;
figure,imshow(im56,[])


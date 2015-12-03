close all; clear all; clc;

I = imread('cameraman.tif');
sigma = 1.4;
Iblur = uint8(imgaussfilt(I, 1.4, 5));
figure
subplot(1,2,1)
imshow(I)
subplot(1,2,2)
imshow(Iblur)

imwrite(Iblur, 'blured.png');

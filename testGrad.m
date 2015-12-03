close all; clear all; clc;

In = imread('cameraman.tif');
sigma = 1.4;
Iblur = imgaussfilt(In, 2, 5);

[Out, theta] = gradient(Iblur);

Out = mat2gray(Out);

figure
subplot(1,2,1)
imshow(In)
subplot(1,2,2)
imshow(Out,[])

imwrite(Out, 'grad.png');
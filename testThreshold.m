close all; clear all; clc;

In = imread('cameraman.tif');
sigma = 1.4;
Iblur = imgaussfilt(In, 2, 5);

[Out, theta] = gradient(Iblur);
theta = arrayfun(@(x)x*180/pi, theta);
direc = arrayfun(@(x)normalize_directions(x), theta);
supressed = non_max_supression(Out, direc);
low = 30;
high = 80;
thresholded = arrayfun(@(x)double_threshold(x,low,high), supressed);

imwrite(mat2gray(thresholded), 'thresholded.png');
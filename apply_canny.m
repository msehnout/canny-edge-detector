function [ oEdges ] = apply_canny( aInput_image, ...
                                   aSigma, ...
                                   aKernelSize, ...
                                   aLowThreshold, ...
                                   aHighThreshold)
%apply_canny Applies canny edge detector
%   Detailed explanation goes here

% Apply image bluring
img_blur = imgaussfilt(aInput_image, aSigma, aKernelSize);
% Obtain gradient image 
[magnitude, theta] = gradient(img_blur);
% Transform rads -> degrees
theta = arrayfun(@(x)x*180/pi, theta);
% Apply theta normalization <-180;180> -> [0,1,2,3]
direc = arrayfun(@(x)normalize_directions(x), theta);
% Non-maxima suppression
supressed = non_max_supression(magnitude, direc);
% Double threshold mapping
thresholded = arrayfun(@(x)double_threshold(x,aLowThreshold,aHighThreshold) ...
                        , supressed);
% Find BLOBs
blobs = grassfire(thresholded);
% Filter out weak edges
oEdges = weak_edges_filter(blobs, thresholded);

end


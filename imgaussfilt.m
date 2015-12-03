function [ oImg ] = imgaussfilt( aImg, aSigma, aSize )
%imgaussfilt Gaussian filtering with specific sigma and kernel size
%   Detailed explanation goes here

if mod(aSize, 2) == 0
    aSize = aSize+1;
end

kernel = fspecial('gaussian', aSize, aSigma);

oImg = conv2(aImg, kernel, 'same');

end


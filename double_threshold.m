function oPixel = double_threshold( aPixel, aLow, aHigh )
%double_threshold Perform double thresholding on single pixel
%   Detailed explanation goes here

if aPixel < aLow
    oPixel = 0;
elseif aPixel < aHigh
    oPixel = 0.5;
else
    oPixel = 1;

end


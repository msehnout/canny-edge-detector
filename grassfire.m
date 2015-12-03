function [ oBLOBs ] = grassfire( aImg )
%grassfire Recursive BLOB analysis 
%   Detailed explanation goes here

[r,c] = size(aImg);
blobs = largematrix;
blobs.matrix = zeros(r,c);
bin_img = largematrix;
bin_img.matrix = aImg;
seed = 1;
for i = 1:r
    for j = 1:c
        if bin_img.matrix(i,j) > 0
            burn(bin_img, i, j, blobs, seed);
            seed = seed + 1;
        end
    end
end

oBLOBs = blobs.matrix;

end

function [] = burn( aImg, row, col, aBLOBs, seed )
    % Burn the pixel
    %oImg = aImg;
    aImg.matrix(row,col) = 0;
    % Mark it as object
    %oBLOBs = aBLOBs;
    aBLOBs.matrix(row,col) = seed;
    % Check neighbors
    [r,c] = size(aImg.matrix);
    for k = (row-1):1:(row+1) %rows
        for l = (col-1):1:(col+1) %columns
            if k>0 && k<=r && l>0 && l<=c %check boundaries
                if aImg.matrix(k,l) > 0 %inspect all adjacent pixels
                    burn(aImg, k, l, aBLOBs, seed);
                end
            end
        end
    end
    
end
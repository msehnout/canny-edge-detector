function [ oBinImg ] = weak_edges_filter( aBLOBs, aImg )
%weak_edges_filter Filter all weak edges based on BLOB image.
%   Weak edge in this context mean BLOB without any strong edge pixel.

oBinImg = aImg;
num_of_edges = max(max(aBLOBs));
for i = 1:num_of_edges
    % find all occurrence of particular blob
    mask_image = aBLOBs == i;
    reversed_mask = ones(size(aImg)) - mask_image;
    % number of pixels in this edge
    num_of_pix = sum(sum(mask_image));
    % weak edge = 0.5
    % strong edge = 1
    % using this I can decide whether the edge contains at least one
    % strong edge pixel
    masked_img = aImg.*mask_image;
    sum_masked = sum(sum(masked_img));
    if sum_masked > (num_of_pix*0.5)
        % there is strong edge
        oBinImg = oBinImg.*reversed_mask; %delete edge
        oBinImg = oBinImg+mask_image;     %make the whole edge strong
    else
        % weak edge
        oBinImg = oBinImg.*reversed_mask; %delete edge
    end
end

end


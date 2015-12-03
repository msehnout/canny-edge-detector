function [ oImg ] = non_max_supression( aMagnitude, aTheta )
%nonMaxSupression Perform non-maximum suppression
%   Detailed explanation goes here

outOfMatrix = Inf;

oImg = aMagnitude;
[r,c] = size(aMagnitude);
for i=1:r %vertical
    for j=1:c %horizontal
        switch aTheta(i,j)
            case 0
                %   0 - east
                east = outOfMatrix;
                west = outOfMatrix;
                if (j+1) <= c
                    east = aMagnitude(i,j+1);
                end
                if (j-1) > 0
                    west = aMagnitude(i,j-1);
                end 
                if aMagnitude(i,j) < east || aMagnitude(i,j) < west
                    oImg(i,j) = 0;
                end
                
            case 1
                %   1 - north-east
                north_east = outOfMatrix;
                south_west = outOfMatrix;
                if (j+1) <= c && (i-1) > 0
                    north_east = aMagnitude(i-1,j+1);
                end
                if (j-1) > 0 && (i+1) <= r
                    south_west = aMagnitude(i+1,j-1);
                end 
                if aMagnitude(i,j) < north_east || aMagnitude(i,j) < south_west
                    oImg(i,j) = 0;
                end
                
            case 2
                %   2 - north
                north = outOfMatrix;
                south = outOfMatrix;
                if (i-1) > 0
                    north = aMagnitude(i-1,j);
                end
                if (i+1) <= r
                    south = aMagnitude(i+1,j);
                end 
                if aMagnitude(i,j) < north || aMagnitude(i,j) < south
                    oImg(i,j) = 0;
                end
                
            otherwise
                %   3 - north-west
                north_west = outOfMatrix;
                south_east = outOfMatrix;
                if (j-1) > 0 && (i-1) > 0
                    north_west = aMagnitude(i-1,j-1);
                end
                if (j+1) <= c && (i+1) <= r
                    south_east = aMagnitude(i+1,j+1);
                end 
                if aMagnitude(i,j) < north_west || aMagnitude(i,j) < south_east
                    oImg(i,j) = 0;
                end
        end
    end
end

end


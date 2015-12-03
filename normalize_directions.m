function direction = normalize_directions( angle )
%normalize_directions Transform angle into direction index
%   0 - east
%   1 - north-east
%   2 - north
%   3 - north-west

if angle>=-180 && angle<(-180+22.5)
    direction = 0;
elseif angle>=(-180+22.5) && angle<(-90-22.5)
    direction = 1;
elseif angle>=(-90-22.5) && angle<(-90+22.5)
    direction = 2;
elseif angle>=(-90+22.5) && angle<(-22.5)
    direction = 3;
elseif angle>=(-22.5) && angle<(22.5)
    direction = 0;
elseif angle>=(22.5) && angle<(90-22.5)
    direction = 1;
elseif angle>=(90-22.5) && angle<(90+22.5)
    direction = 2;
elseif angle>=(90+22.5) && angle<(180-22.5)
    direction = 3;
else
    direction = 0;
end

end


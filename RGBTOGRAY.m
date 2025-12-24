function [ gray ] = RGBTOGRAY( RGB ,Option )

[H, W, L] = size(RGB); 
Gray = zeros(H, W);
Gray = double(Gray);
RGB = double(RGB); 

for i = 1:H 
    for j = 1:W 
        if Option == 1
            Gray(i, j) = (RGB(i, j, 1) + RGB(i, j, 2) + RGB(i, j, 3)) / 3;
        elseif Option == 2
            Gray(i, j) = (0.2 * RGB(i, j, 1) + 0.4 * RGB(i, j, 2) + 0.4 * RGB(i, j, 3));
        elseif Option == 3
            Gray(i, j) = RGB(i, j, 1);
        elseif Option == 4
            Gray(i, j) = RGB(i, j, 2);
        elseif Option == 5
            Gray(i, j) = RGB(i, j, 3);
        end
    end
end
gray = uint8(Gray); 
end
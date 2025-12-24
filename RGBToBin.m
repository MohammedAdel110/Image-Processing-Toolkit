function output = RGBToBin(rgb, threshold, ax)
    [H, W, ~] = size(rgb);
    
    if size(rgb,3) == 3
        gray = zeros(H, W);
        for i = 1:H
            for j = 1:W
                gray(i,j) = (double(rgb(i,j,1)) + double(rgb(i,j,2)) + double(rgb(i,j,3)))/3;
            end
        end
    else
        gray = double(rgb);
    end

    binary = zeros(H,W);
    for i = 1:H
        for j = 1:W
            if gray(i,j) >= threshold
                binary(i,j) = 1;
            else
                binary(i,j) = 0;
            end
        end
    end

    output = logical(binary);
    axes(ax);
    imshow(output);
end

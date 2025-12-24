function out = Closing_Filter(img)
    [H, W, L] = size(img);    
    if L == 3
        img_double = im2double(img);
        img_grey = (img_double(:,:,1) + img_double(:,:,2) + img_double(:,:,3)) / 3;
    else
        img_grey = im2double(img);
    end
    img_binary = zeros(H, W);
    for i = 1:H
        for j = 1:W
            if img_grey(i, j) >= 0.5
                img_binary(i, j) = 1;
            else
                img_binary(i, j) = 0;
            end
        end
    end
    se = [1 1 1; 1 1 1; 1 1 1]; 
    se_size = 3;
    padding = floor(se_size / 2); 
    
    dilated = zeros(H, W);
    out = zeros(H, W);
    for i = 1 + padding : H - padding
        for j = 1 + padding : W - padding

            neighborhood = img_binary(i - padding : i + padding, j - padding : j + padding);
            if any(neighborhood(:) == se(:))
                dilated(i, j) = 1;
            else
                dilated(i, j) = 0;
            end
        end
    end
    for i = 1 + padding : H - padding
        for j = 1 + padding : W - padding
            neighborhood = dilated(i - padding : i + padding, j - padding : j + padding);
            if all(neighborhood(:) == se(:)) 
                out(i, j) = 1;
            else
                out(i, j) = 0;
            end
        end
    end    
end
function out = Boundary_Extraction(img)
    if size(img, 3) == 3
        img_gray = (double(img(:,:,1)) + double(img(:,:,2)) + double(img(:,:,3))) / 3;
    else
        img_gray = double(img);
    end
    
    img_binary = img_gray > 128; 
    se = ones(3,3); 
    
    eroded_img = Erosion_Internal(img_binary, se);
    
    out = img_binary - eroded_img;
    out = logical(out); 
end
function eroded_img = Erosion_Internal(img_bin, se)
    [H, W] = size(img_bin);
    eroded_img = false(H, W);
    padded = padarray(img_bin, [1 1], 0);
    for i = 1:H
        for j = 1:W
            sub = padded(i:i+2, j:j+2);
            if all(sub(se==1) == 1)
                eroded_img(i,j) = 1;
            end
        end
    end
end
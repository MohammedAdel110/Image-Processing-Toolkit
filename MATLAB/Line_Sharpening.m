function out = Line_Sharpening(img, direction)
    [H, W, L] = size(img);
    img_double = double(img);
    out = zeros(H, W, L);
    
    switch direction
        case 'H'  
            mask = [-1 -1 -1; 2 2 2; -1 -1 -1];
        case 'V'  
            mask = [-1 2 -1; -1 2 -1; -1 2 -1];
        case 'DL' 
            mask = [-1 -1 2; -1 2 -1; 2 -1 -1];
        case 'DR' 
            mask = [2 -1 -1; -1 2 -1; -1 -1 2];
    end
    
    padded = padarray(img_double, [1 1], 'replicate');
    
    for k = 1:L
        for i = 1:H
            for j = 1:W
                sub = padded(i:i+2, j:j+2, k);
                line_details = sum(sum(sub .* mask));
                out(i,j,k) = img_double(i,j,k) + line_details;
            end
        end
    end    
    out(out < 0) = 0;
    out(out > 255) = 255;
    out = uint8(out);
end
function out = Point_Sharpening(img)
    [H, W, L] = size(img);
    
    img_double = double(img);
    out = zeros(H, W, L);
    mask = [ 0 -1  0; 
            -1  5 -1; 
             0 -1  0];
             
    padded = padarray(img_double, [1 1], 'replicate');
    
    for k = 1:L
        for i = 1:H
            for j = 1:W
                sub = padded(i:i+2, j:j+2, k);                
                val = sum(sum(sub .* mask));
                out(i,j,k) = val;
            end
        end
    end    
    out(out < 0) = 0;
    out(out > 255) = 255;
    out = uint8(out);
end
function out = Weight_Filter(img)
    [H, W, L] = size(img);
    img = double(img);
    mask = [1 2 1; 
            2 4 2; 
            1 2 1] / 16;
    
    out = zeros(H, W, L);
    padded = padarray(img, [1 1], 'replicate');
    
    for k = 1:L
        for i = 1:H
            for j = 1:W
                sub = padded(i:i+2, j:j+2, k);
                out(i,j,k) = sum(sum(sub .* mask));
            end
        end
    end
    out = uint8(out);
end
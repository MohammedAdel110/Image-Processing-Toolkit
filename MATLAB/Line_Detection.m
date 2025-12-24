function out = Line_Detection(img, direction)
    [H, W, L] = size(img);
    if L == 3, img = RGBTOGRAY(img, 1); end
    img = double(img);
    out = zeros(H, W);
    
    switch direction
        case 1 
            mask = [-1 -2 -1; 0 0 0; 1 2 1];
        case 2 
            mask = [-1 0 1; -2 0 2; -1 0 1];
        case 3 
            mask = [0 1 2; -1 0 1; -2 -1 0];
        case 4 
            mask = [-2 -1 0; -1 0 1; 0 1 2];
    end
    
    padded = padarray(img, [1 1], 'replicate');
    for i = 1:H
        for j = 1:W
            sub = padded(i:i+2, j:j+2);
            out(i,j) = sum(sum(sub .* mask));
        end
    end
    out = uint8(abs(out)); 
end
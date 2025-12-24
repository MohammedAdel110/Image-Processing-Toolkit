function out = Correlation_Filter(img, mask)
    [H, W, L] = size(img);
    img = double(img);
    [m, n] = size(mask);
    ph = floor(m/2); pw = floor(n/2);
    %???? ????? ?????? ?? ???????? 
    %[-1 0 1; -2 0 2; -1 0 1] Edge 
    %[0 1 0; 1 -4 1; 0 1 0] laplac 
    padded = zeros(H + 2*ph, W + 2*pw, L);
    for k = 1:L
        for i = 1:H
            for j = 1:W
                padded(i+ph, j+pw, k) = img(i,j,k);
            end
        end
    end
    
    out = zeros(H, W, L);
    for k = 1:L
        for i = 1:H
            for j = 1:W
                sub = padded(i:i+m-1, j:j+n-1, k);
                out(i,j,k) = sum(sum(sub .* mask));
            end
        end
    end
    
    for k = 1:L
        plane = out(:,:,k);
        min_val = min(min(plane));
        max_val = max(max(plane));
        if max_val > min_val
            out(:,:,k) = (plane - min_val) / (max_val - min_val) * 255;
        else
            out(:,:,k) = plane;
        end
    end
    out = uint8(out);
end

function out = Adaptive_Mean_Filter(img)
    img_double = double(img);
    [h, w, l] = size(img_double);
    out = zeros(h, w, l);
    window_size = 7;
    half = floor(window_size / 2);
    padded = padarray(img_double, [half, half], 'replicate');
    noise_var = 500; 
    for k = 1:l
        for i = 1:h
            for j = 1:w
                subImg = padded(i:i+window_size-1, j:j+window_size-1, k);
                l_mean = mean(subImg(:));
                l_var = var(subImg(:));                
                if l_var < noise_var
                    out(i,j,k) = l_mean;
                else
                    out(i,j,k) = l_mean + ((l_var - noise_var) / l_var) * (img_double(i,j,k) - l_mean);
                end
            end
        end
    end
    out = uint8(out);
end
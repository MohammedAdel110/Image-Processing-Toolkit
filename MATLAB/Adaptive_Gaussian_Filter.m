function out = Adaptive_Gaussian_Filter(img, window_size, S)
    if nargin < 2, window_size = 7; end
    
    img_double = double(img);
    [h, w, l] = size(img_double);
    out = zeros(h, w, l);
    
    half = floor(window_size / 2);
    padded = padarray(img_double, [half, half], 'replicate');
    if nargin < 3
        noise_var = mean(var(img_double(:))); 
    else
        noise_var = S; 
    end

    for k = 1:l 
        for i = 1:h
            for j = 1:w
                subImg = padded(i:i+window_size-1, j:j+window_size-1, k);
                
                l_mean = mean(subImg(:)); % ??????? ??????
                l_var = var(subImg(:));   % ??????? ??????
                
                if l_var <= noise_var
                    k_weight = 0; % ??? ????? ???? ????? (???? ???????)
                else
                    k_weight = (l_var - noise_var) / l_var; 
                end                
                
                % ???????? ????????: ????? ??? ????? ????????
                out(i,j,k) = (1 - k_weight) * l_mean + k_weight * img_double(i,j,k);
            end
        end
    end
    out = uint8(out);
end
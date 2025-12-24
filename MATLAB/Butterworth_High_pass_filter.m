function [n] = Butterworth_High_pass_filter(img, D0, nb)
    if nargin < 3
        nb = 2;
    end
    if nargin < 2
        D0 = 30;
    end
    
    [H, W, L] = size(img);
    
    filter_low_pass = zeros(H, W, L); 
    
    for k = 1:L
        for i = 1:H
            for j = 1:W
                dis = sqrt((i - (H/2)).^2 + (j - (W/2)).^2);
                filter_low_pass(i, j, k) = 1 / (1 + (dis / D0)^(2 * nb));
            end
        end
    end

    filter_high_pass = 1 - filter_low_pass;
    f1 = fft2(img);
    f1 = fftshift(f1);
    n = f1 .* filter_high_pass;
    n = fftshift(n);
    n = ifft2(n);
    n = abs(n);
    n = mat2gray(n);

end
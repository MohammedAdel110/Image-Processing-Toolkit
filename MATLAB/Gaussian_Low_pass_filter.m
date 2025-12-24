function [n] = Gaussian_Low_pass_filter(img, D0)
    if nargin < 2
        D0 = 30;
    end
    
    img = double(img);
    [H, W, L] = size(img);
    
    filter_mask = zeros(H, W); 
    cx = H/2; cy = W/2;
    
    for i = 1:H 
        for j = 1:W 
            dis = sqrt((i - cx).^2 + (j - cy).^2);
            filter_mask(i, j) = exp(-(dis^2 / (2 * D0^2)));
        end
    end
    n = zeros(H, W, L); 
    for k = 1:L
        f_plane = fft2(img(:,:,k));
        f_shift = fftshift(f_plane);
        filtered_f = f_shift .* filter_mask;
        f_ishift = ifftshift(filtered_f);
        img_back = ifft2(f_ishift);
        n(:,:,k) = abs(img_back);
    end
    n = mat2gray(n); 
    n = uint8(n * 255); 
end
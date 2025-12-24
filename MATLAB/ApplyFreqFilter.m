function [final_image, filter_mask] = ApplyFreqFilter(img, type, D0)
    [H, W, L] = size(img);
    img = double(img);
    
    filter_mask = zeros(H, W);
    for j = 1:H
        for k = 1:W
            dis = sqrt((j-(H/2))^2 + (k-(W/2))^2);
            if dis <= D0
                filter_mask(j,k) = 1;
            end
        end
    end
    
    if strcmp(type, 'high')
        filter_mask = 1 - filter_mask;
    end
    
    final_image = zeros(H, W, L);
    
    for i = 1:L
        fi = fft2(img(:,:,i));
        fi = fftshift(fi);
        
        filtered_fi = fi .* filter_mask;
        
        NI = ifftshift(filtered_fi);
        NI = ifft2(NI);
        final_image(:,:,i) = abs(NI);
    end
    
    final_image = mat2gray(final_image);
end
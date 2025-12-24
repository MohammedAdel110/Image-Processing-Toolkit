function out = Segmentation_Filter(img)    
    [H, W, L] = size(img);
    if L == 3
        img_double = im2double(img);
        img_grey = (img_double(:,:,1) + img_double(:,:,2) + img_double(:,:,3)) / 3;
    else
        img_grey = im2double(img);
    end
    img_uint8 = im2uint8(img_grey);
    counts = zeros(256, 1);
    for i = 1:H
        for j = 1:W
            pixel_value = img_uint8(i, j);
            counts(pixel_value + 1) = counts(pixel_value + 1) + 1;
        end
    end
    
    probabilities = counts / numel(img_uint8);    
    total_mean = sum((0:255)' .* probabilities); 
    max_variance = 0; 
    optimal_threshold = 0; 
    
    for t = 1:255 
        
        prob_c0 = sum(probabilities(1:t));
        mean_c0 = sum((0:t-1)' .* probabilities(1:t)) / prob_c0;
        
        prob_c1 = sum(probabilities(t+1:256));
        if prob_c1 == 0
            continue; 
        end
        mean_c1 = sum((t:255)' .* probabilities(t+1:256)) / prob_c1; 
        variance_between = prob_c0 * (mean_c0 - total_mean)^2 + prob_c1 * (mean_c1 - total_mean)^2;
        
        if variance_between > max_variance
            max_variance = variance_between;
            optimal_threshold = t;
        end
    end
    level = optimal_threshold / 255;     
    out = zeros(H, W);
    for i = 1:H
        for j = 1:W
            if img_grey(i, j) >= level
                out(i, j) = 1; 
            else
                out(i, j) = 0; 
            end
        end
    end    
end
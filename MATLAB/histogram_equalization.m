function output_image = histogram_equalization(input_image)
    [rows, cols, channels] = size(input_image);
    output_image = zeros(rows, cols, channels, 'uint8');
    for ch = 1:channels
        img_double = double(input_image(:,:,ch));
        N_pixels = rows * cols; 
        L_levels = 256;    
        image_hist = zeros(L_levels, 1);
        for i = 1:rows
            for j = 1:cols
                intensity = round(img_double(i, j));
                image_hist(intensity + 1) = image_hist(intensity + 1) + 1;
            end
        end
        cumulative_sum_hist = cumsum(image_hist);        
        transformation_func = round((L_levels - 1) / N_pixels * cumulative_sum_hist);        
        for i = 1:rows
            for j = 1:cols
                original_level = round(img_double(i, j));
                output_image(i, j, ch) = transformation_func(original_level + 1);
            end
        end
    end
end
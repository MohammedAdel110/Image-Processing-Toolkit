function output_image = adjust_brightness(input_image, brightness_offset)
    image_class = class(input_image);
 
    if strcmp(image_class, 'uint8')
        img_double = double(input_image);
    elseif strcmp(image_class, 'double') || strcmp(image_class, 'single')
         
        img_double = input_image;
    else
        
        img_double = double(input_image);
    end

    adjusted_double = img_double + brightness_offset;

    if strcmp(image_class, 'uint8')
        
        adjusted_clamped = max(0, min(255, adjusted_double));
       
        output_image = uint8(adjusted_clamped);
    elseif strcmp(image_class, 'double') || strcmp(image_class, 'single')
        max_val = max(input_image(:));
        min_val = min(input_image(:));
        if max_val <= 1.01 && min_val >= -0.01
            adjusted_clamped = max(0, min(1, adjusted_double));
        else    
            adjusted_clamped = max(min_val, min(max_val, adjusted_double));
        end  
        if strcmp(image_class, 'double')
            output_image = adjusted_clamped;
        else
            output_image = single(adjusted_clamped);
        end
    else
        output_image = adjusted_double;
    end
end
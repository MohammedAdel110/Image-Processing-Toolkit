function new_image = Image_Transform(image, type, param)
    original_image_double = im2double(image);
    [H, W, L] = size(original_image_double);
    new_image_double = zeros(H, W, L);
    pixel = original_image_double; 
    switch lower(type)
        case 'power'
            new_image_double = pixel .^ param;
        case 'root'
            new_image_double = pixel .^ (1 / param);
        case 'log'
            c = param;
            new_image_double = c * log(1 + pixel);
        case 'log_inverse'
            c = param;
            new_image_double = (exp(param * pixel) - 1) / (exp(param) - 1); 
        case 'negative'
            new_image_double = 1 - pixel;
        otherwise
            warning('Image_Transform:UnknownType', 'Unknown transformation type: %s. Returning original image.', type);
            new_image_double = pixel;
    end
    new_image_double(new_image_double < 0) = 0; 
    new_image_normalized = mat2gray(new_image_double);
    new_image = im2uint8(new_image_normalized);
    figure;
    subplot(1, 2, 1);
    imshow(original_image_double);
    title('Original Image');
    subplot(1, 2, 2);
    imshow(new_image); 
    title([upper(type), ' Transform, param = ', num2str(param)]);
end
function stretched_image = contrastStretch(input_image, r_min, r_max, s_min, s_max)
    original_class = class(input_image);
    
    input_double = double(input_image);
    if r_max <= r_min
        error('r_max must be strictly greater than r_min.');
    end
   
    slope = (s_max - s_min) / (r_max - r_min);
    stretched_double = slope * (input_double - r_min) + s_min;
   
    stretched_double(input_double < r_min) = s_min;
    
    stretched_double(input_double > r_max) = s_max;
    
    stretched_double = max(s_min, min(s_max, stretched_double));
    stretched_image = cast(stretched_double, original_class);

end


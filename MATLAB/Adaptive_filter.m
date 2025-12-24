function [ out ] = Adaptive_filter( img, min_size, max_size )

    I = double(img);
    [h, w] = size(I);
    
    ph_max = floor(max_size / 2);

    loaded_img = padarray(I, [ph_max, ph_max], 'replicate');
    
    out = zeros(h, w);

    for i = 1:h
        for j = 1:w
            
            current_size = min_size;
            
            pixel_processed = false; 

            while current_size <= max_size && ~pixel_processed
                
                half_size = floor(current_size / 2);
                

                r_start_pad = (i + ph_max) - half_size;
                r_end_pad   = (i + ph_max) + half_size;
                c_start_pad = (j + ph_max) - half_size;
                c_end_pad   = (j + ph_max) + half_size;
                
                subImg = loaded_img(r_start_pad:r_end_pad, c_start_pad:c_end_pad);
                
                Zmin = min(subImg(:));
                Zmax = max(subImg(:));
                Zmed = median(subImg(:));
                Zxy  = loaded_img(i + ph_max, j + ph_max); 
                
                A1 = Zmed - Zmin;
                A2 = Zmed - Zmax;
                
                if (A1 > 0 && A2 < 0)
                    
                    B1 = Zxy - Zmin;
                    B2 = Zxy - Zmax;
                    
                    if (B1 > 0 && B2 < 0)
                        out(i, j) = Zxy; 
                    else
                        out(i, j) = Zmed;
                    end
                    
                    pixel_processed = true; 
                    
                else
                    current_size = current_size + 2;
                    
                    if current_size > max_size
                        out(i, j) = Zmed;
                        pixel_processed = true;
                    end
                end
            end
        end
    end

    out = uint8(out);
end
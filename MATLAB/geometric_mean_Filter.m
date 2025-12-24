function [ out ] = geometric_mean_Filter( img, mh, mw )
    [h, w] = size(img);
    out = zeros(h, w);
    ph = floor(mh/2);
    pw = floor(mw/2);
    img = padarray(img, [ph, pw], 'replicate');
    
    out = double(out);
    img = double(img);
    
    subImg = zeros(mh, mw);
    
    for i = 1:h
        for j = 1:w
            
            for x = 1:mh
                for y = 1:mw  
                    subImg(x, y) = img(i+x-1, j+y-1);
                end
            end
            product_val = prod(subImg(:)); 
            out(i, j) = product_val ^ (1 / (mh * mw));
            
        end
    end
    out = uint8(out);
end
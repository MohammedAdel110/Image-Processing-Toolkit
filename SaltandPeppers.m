function [ New_Img ] = SaltandPeppers( img, ps, pps )
    [h, w, l] = size(img);
    num_of_salt = round(ps * h * w);
    num_of_peppers = round(pps * h * w);

    for i = 1:num_of_salt
        row = ceil(rand() * h);
        column = ceil(rand() * w);
        img(row, column, :) = 255; 
    end

    for i = 1:num_of_peppers
        row = ceil(rand() * h);
        column = ceil(rand() * w);
        img(row, column, :) = 0;
    end

    New_Img = uint8(img);
end
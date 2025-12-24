function out = Gamma_Correction(img, gamma)
    img = im2double(img);
    out = img .^ gamma;
    out = im2uint8(out);
end
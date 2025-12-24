function spectrum_img = Show_Fourier_Spectrum(img)
    if size(img, 3) == 3
        img_gray = (double(img(:,:,1)) + double(img(:,:,2)) + double(img(:,:,3))) / 3;
    else
        img_gray = double(img);
    end
    F = fft2(img_gray);
    F_shifted = fftshift(F);
    
    mag = abs(F_shifted);
    
    spectrum_img = log(1 + mag);
    spectrum_img = (spectrum_img - min(spectrum_img(:))) / (max(spectrum_img(:)) - min(spectrum_img(:)));
end
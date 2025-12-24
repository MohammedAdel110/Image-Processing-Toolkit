function out_img = Inverse_Fourier_Transform(F_shifted)
    F = ifftshift(F_shifted);
    img_reconstructed = ifft2(F);
    out_img = real(img_reconstructed);
    out_img = uint8(mat2gray(out_img) * 255);
end
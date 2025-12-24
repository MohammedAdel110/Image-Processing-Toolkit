function [new_img] = Uniform_Noise(img)
img_double = double(img);
[H, W, L] = size(img);
a = -50;
b = 50; 
noise_matrix = a + (b - a) * rand(H, W, L);

img_noisy = img_double + noise_matrix;

for i = 1:H
    for j = 1:W
        for k = 1:L
            if img_noisy(i, j, k) < 0
                img_noisy(i, j, k) = 0;
            elseif img_noisy(i, j, k) > 255
                img_noisy(i, j, k) = 255;
            end
        end
    end
end

new_img = uint8(img_noisy);

end
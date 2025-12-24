function [new_img] = Gaussian_Noise(img)
u=1;
v=3;
[H W L] = size(img);


for k=1:L 
    for z=1:255
        %?? ???????? ???? ????? ???? 
        num_of_pixel = round(exp(-((z-u)^2) / 2*v*v) / (sqrt(2*3.14)*v) *H*W);
        for i=1:num_of_pixel
           row = ceil(rand(1,1)*H);
           col = ceil(rand(1,1)*W);
           img(row,col,k) = img(row,col,k)+z;
        end
    end
end

for ch=1:L
    oldmin = min(min(img(:,:,ch)));
    oldmax = max(max(img(:,:,ch)));
    % ??????  ??????? ???? ???? ????? ??? 0 ? 255
    new_img(:,:,ch) = ((img(:,:,ch)-oldmin) / (oldmax-oldmin))*255;
end

new_img = uint8(new_img);

%figure, imshow(new_img),title("After");
end

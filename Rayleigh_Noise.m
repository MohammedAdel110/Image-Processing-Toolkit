function [new_img] = Rayleigh_Noise(img)
a=9; %?? ??? ???? ???? ???? ???? ?? 9 ????? ???? ?????? ???
b=5;
[H W L] = size(img);

%imshow(img), title("Before");
img = double(img);

for k=1:L
    for z=1:255
       num_of_pixel = round(((2*(z-a)* exp(-((z-a)^2)/b))/b )*H*W);
       for i=1:num_of_pixel
           row = ceil(rand(1,1)*H);
           col = ceil(rand(1,1)*W);
           if z>=a % ????? ????? ????? ??? ????? ???? ???? ?? ?? ????? a
               img(row,col,k) = img(row,col,k)+z;
           else
               img(row,col,k) = 0;
           end
       end
    end
end

for ch=1:L
    oldmin = min(min(img(:,:,ch)));
    oldmax = max(max(img(:,:,ch)));
    new_img(:,:,ch) = ((img(:,:,ch)-oldmin) / (oldmax-oldmin))*255;
end

new_img = uint8(new_img);

%figure, imshow(new_img),title("After");

end
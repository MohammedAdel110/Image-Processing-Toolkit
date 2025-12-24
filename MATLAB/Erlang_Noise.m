function [new_img] = Erlang_Noise(img)
a=9;
b=3;
[H W L] = size(img);

img = double(img);

for k=1:L
    for z=-100:255
       num_of_pixel = round(( a* ((b-1).^(b-1)) )* ( exp(-b+1) ) / ( factorial(b-1) ));
       for i=1:num_of_pixel
           row = ceil(rand(1,1)*H);
           col = ceil(rand(1,1)*W);
           if (z >= 0)
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
end
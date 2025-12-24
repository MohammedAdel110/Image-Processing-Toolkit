function [ ] = HistoGramGray( img, targetAxes )
     axes(targetAxes);
    [H, W, L] = size(img);
    if L == 3
        img = rgb2gray(img);
    end
    Histg = zeros(256,1);
    [H, W] = size(img); 

    for i = 1:H
        for j = 1:W
            pixel_val = img(i,j);
            Histg(pixel_val+1) = Histg(pixel_val+1) + 1;
        end
    end
    bar(Histg);
    title('Grayscale Histogram');
    xlim([0 255]);
    grid on;
end
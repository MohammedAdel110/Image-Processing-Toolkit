function HistoGramRGB(img, target_axes) 

    axes(target_axes);
    cla(target_axes); 
    [H, W, L] = size(img);
    if L ~= 3
        msgbox('The image is not RGB!');
        return;
    end

    HistR = zeros(256,1); 
    HistG = zeros(256,1); 
    HistB = zeros(256,1);
    for i = 1:H
        for j = 1:W
            HistR(img(i,j,1)+1) = HistR(img(i,j,1)+1)+1;
            HistG(img(i,j,2)+1) = HistG(img(i,j,2)+1)+1;            
            HistB(img(i,j,3)+1) = HistB(img(i,j,3)+1)+1;
        end
    end    
    plot(0:255, HistR, 'r', 'LineWidth', 1); hold on;
    plot(0:255, HistG, 'g', 'LineWidth', 1);
    plot(0:255, HistB, 'b', 'LineWidth', 1); 
    title('RGB Histogram');
    xlabel('Pixel Value');
    ylabel('Frequency');
    xlim([0 255]); 
    grid on;      
    hold off;
end
function varargout = GUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function GUI_OpeningFcn(hObject, ~, handles, varargin)
handles.output = hObject;

filterFiles = {...
    '--- POINT PROCESSING ---', ...
    'RGBTOGRAY', ...
    'gray_to_binary', ...
    'RGBorGrayToBin', ...
    'adjust_brightness', ...
    'Image_Transform', ...
    'Gamma_Correction', ...
    'HistoGramRGB', ...
    'HistoGramGray', ...
    'histogram_equalization', ...
    'contrastStretch', ...
    '--- NOISE MODELS ---', ...
    'Uniform_Noise', ...
    'SaltandPeppers', ...
    'Rayleigh_Noise', ...
    'Gaussian_Noise', ...
    'Exponential_Noise', ...
    'Erlang_Noise', ...
    '--- SPATIAL FILTERS ---', ...
    'Mean_Filter', ...
    'geometric_mean_Filter', ...
    'Weight_Filter', ...
    'Median_Filter', ...
    'max_filter', ...
    'Min_Filter', ...
    'MidPoint_Filter', ...
    'Point_Detection', ...
    'Line_Detection', ...
    'Point_Sharpening', ...
    'Line_Sharpening', ...
    'labiac', ...
    'Correlation_Filter', ...
    '--- FREQUENCY DOMAIN ---', ...
    'Fourier_Transform', ...
    'Inverse_Fourier_Transform', ...
    'ApplyFreqFilter', ...
    'Gaussian_Low_pass_filter', ...
    'Gaussian_High_pass_filter', ...
    'Butterworth_Low_pass_filter', ...
    'Butterworth_High_pass_filter', ...
    '--- IMAGE RESTORATION ---', ...
    'Adaptive_filter', ...
    'Adaptive_Mean_Filter', ...
    'Adaptive_gaussian_Filter', ...
    '--- MORPHOLOGICAL ---', ...
    'Dilation_Filter', ...
    'Erosion_Filter', ...
    'Opening_Filter', ...
    'Closing_Filter', ...
    'Boundary_Extraction', ...
    'Segmentation_Filter' ...
};

set(handles.popupmenu1,'String',filterFiles);
guidata(hObject, handles);


function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function pushbutton1_Callback(hObject, eventdata, handles)
[file,path] = uigetfile({'*.jpg;*.png;*.bmp','Images'});
if isequal(file,0)
    return;
end

handles.Image = imread(fullfile(path,file));  

axes(handles.axes1);   
imshow(handles.Image);

guidata(hObject, handles);  

function pushbutton3_Callback(hObject, eventdata, handles)
if ~isfield(handles,'Image')
    msgbox('Please load an image first.');
    return;
end

filters = get(handles.popupmenu1,'String'); 
val = get(handles.popupmenu1,'Value'); 
selectedFilter = filters{val};
img = handles.Image;

try
    switch selectedFilter
        case 'RGBTOGRAY'
        Option = str2double(inputdlg('Enter Option (1-5):','RGBTOGRAY',1,{'1'}));
        output = RGBTOGRAY(img, Option);
        axes(handles.axes2); imshow(output);
        case 'RGBorGrayToBin'
        thres = str2double(inputdlg('Enter threshold (0-255):','Threshold',1,{'128'}));
        output = RGBToBin(img, thres, handles.axes2);  
        case 'labiac'
        type = str2double(inputdlg('Enter type (1=blur,2=edge,3=sharpen):','labiac',1,{'1'}));
        output = labiac(img, type);
        axes(handles.axes2); imshow(output);
        case 'Image_Transform'
        type = inputdlg('Enter transform type (power/root/log/log_inverse/negative):','Transform',1,{'negative'});
        type = type{1};
        if any(strcmpi(type,{'power','root','log','log_inverse'}))
            param = str2double(inputdlg('Enter parameter:','Parameter',1,{'1'}));
        else
            param = 1;
        end
        output = Image_Transform(img, type, param);
        axes(handles.axes2); imshow(output);
        case 'HistoGramRGB'
            HistoGramRGB(img, handles.axes2); return; 
        case 'HistoGramGray'
              HistoGramGray(img, handles.axes2); return;
        case 'histogram_equalization'
             output = histogram_equalization(img);
        axes(handles.axes2); imshow(output);
        
        case 'contrastStretch'
             answer = inputdlg({'r_min','r_max','s_min','s_max'},'contrastStretch',1,{'0','255','0','255'});
        r_min = str2double(answer{1}); r_max = str2double(answer{2});
        s_min = str2double(answer{3}); s_max = str2double(answer{4});
        output = contrastStretch(img,r_min,r_max,s_min,s_max);
        axes(handles.axes2); imshow(output);
        case 'Mean_Filter'
        answer = inputdlg({'Enter Height (m):', 'Enter Width (n):'}, 'Mean Filter', 1, {'3', '3'});
        if isempty(answer), return; end
        m_val = str2double(answer{1}); 
        n_val = str2double(answer{2});
        output = Mean_Filter(img, m_val, n_val);
        case 'Weight_Filter'
        output = Weight_Filter(img);
        case 'Line_Sharpening'
        ans = inputdlg('Enter Direction (H, V, DL, DR):', 'Line Sharpening', 1, {'H'});
        if ~isempty(ans)
        output = Line_Sharpening(img, upper(ans{1}));
        axes(handles.axes2);
        imshow(output);
        end
        case 'adjust_brightness'
             brightness_offset = str2double(inputdlg('Enter brightness offset:','Brightness',1,{'50'}));
        output = adjust_brightness(img, brightness_offset);
        axes(handles.axes2); imshow(output);
        case 'Point_Sharpening'
        output = Point_Sharpening(img);
        axes(handles.axes2);
        imshow(output);
        case 'ApplyFreqFilter'
        prompt = {'Enter Filter Type (low/high):', 'Enter Cutoff Frequency (D0):'};
        dlgtitle = 'Frequency Filter Settings';
        definput = {'low', '50'};
        answer = inputdlg(prompt, dlgtitle, [1 35], definput);
    
        if ~isempty(answer)
        type = lower(answer{1});
        D0 = str2double(answer{2});
        
        [output, mask] = ApplyFreqFilter(img, type, D0);
        
        axes(handles.axes2);
        imshow(output);
        title(['Result using ', type, ' pass filter']);
        
        figure('Name', 'Used Filter Mask');
        imshow(mask, []);
        title(['Ideal ', type, ' Pass Mask (D0 = ', num2str(D0), ')']);
        end
        case 'Gaussian_Low_pass_filter'
            D0 = str2double(inputdlg('Enter Cutoff Frequency (D0):','Gaussian LP',1,{'30'}));
            output = Gaussian_Low_pass_filter(img, D0);
            axes(handles.axes2); imshow(output);
            
        case 'Gaussian_High_pass_filter'
            D0 = str2double(inputdlg('Enter Cutoff Frequency (D0):','Gaussian HP',1,{'30'}));
            output = Gaussian_High_pass_filter(img, D0);
            axes(handles.axes2); imshow(output);
            
        case 'Butterworth_Low_pass_filter'
            prompt = {'Enter Cutoff Frequency (D0):', 'Enter Filter Order (n):'};
            answer = inputdlg(prompt, 'Butterworth LP', [1 35], {'30', '2'});
            D0 = str2double(answer{1}); n = str2double(answer{2});
            output = Butterworth_Low_pass_filter(img, D0, n); % ??? ???? ?????? ??????? ????? D0 ???? ?????? ???
            axes(handles.axes2); imshow(output);
            
        case 'Butterworth_High_pass_filter'
            prompt = {'Enter Cutoff Frequency (D0):', 'Enter Filter Order (n):'};
            answer = inputdlg(prompt, 'Butterworth HP', [1 35], {'30', '2'});
            D0 = str2double(answer{1}); n = str2double(answer{2});
            output = Butterworth_High_pass_filter(img, D0, n); % ??? ???? ?????? ??????? ????? D0 ???? ?????? ???
            axes(handles.axes2); imshow(output);

            
        case 'Uniform_Noise'
            output = Uniform_Noise(img);
            axes(handles.axes2); imshow(output);
        case 'Median_Filter'
            ans = inputdlg({'Enter Height (m):', 'Enter Width (n):'}, 'Median Filter', 1, {'3', '3'});
            if ~isempty(ans)
            m_val = str2double(ans{1});
            n_val = str2double(ans{2});
            output = Median_Filter(img, m_val, n_val);
            axes(handles.axes2);
            imshow(output);
            end
            
        case 'SaltandPeppers'
            prompt = {'Enter Salt Density (ps, e.g., 0.02):', 'Enter Pepper Density (pps, e.g., 0.02):'};
            answer = inputdlg(prompt, 'Salt and Pepper Noise', [1 35], {'0.02', '0.02'});
            ps = str2double(answer{1}); pps = str2double(answer{2});
            output = SaltandPeppers(img, ps, pps);
            axes(handles.axes2); imshow(output);
        case 'Rayleigh_Noise'
            output = Rayleigh_Noise(img); 
            axes(handles.axes2); imshow(output);
            
        case 'Gaussian_Noise'
            output = Gaussian_Noise(img); 
            axes(handles.axes2); imshow(output);
            
        case 'Exponential_Noise'
            output = Exponential_Noise(img); 
            axes(handles.axes2); imshow(output);
            
        case 'Erlang_Noise'
            output = Erlang_Noise(img); 
            axes(handles.axes2); imshow(output);

        
        case 'max_filter'
            output = max_filter(img); 
            axes(handles.axes2); imshow(output);
            
        case 'geometric_mean_Filter'
            prompt = {'Enter Height (mh):', 'Enter Width (mw):'};
            answer = inputdlg(prompt, 'Geometric Mean Filter', [1 35], {'3', '3'});
            mh = str2double(answer{1}); mw = str2double(answer{2});
            output = geometric_mean_Filter(img, mh, mw);
            axes(handles.axes2); imshow(output);

        case 'Adaptive_filter'
            prompt = {'Enter Min Window Size (min_size):', 'Enter Max Window Size (max_size):'};
            answer = inputdlg(prompt, 'Adaptive Filter', [1 35], {'3', '7'});
            min_size = str2double(answer{1}); max_size = str2double(answer{2});
            output = Adaptive_filter(img, min_size, max_size);
            axes(handles.axes2); imshow(output);
            
            
        case 'Segmentation_Filter'
            output = Segmentation_Filter(img);
            axes(handles.axes2); imshow(output);
        case 'Closing_Filter' 
        output = Closing_Filter(img);
        axes(handles.axes2); imshow(output);
        case 'Dilation_Filter' 
        output = Dilation_Filter(img);
        axes(handles.axes2); imshow(output);
        case 'Erosion_Filter'
        output = Erosion_Filter(img);
        axes(handles.axes2); imshow(output);
        case 'Opening_Filter' 
        output = Opening_Filter(img);
        axes(handles.axes2); imshow(output);
        case 'Gamma_Correction'
            gamma_val = str2double(inputdlg('Enter Gamma value (e.g., 0.5 or 2.0):','Gamma',1,{'1.0'}));
            output = Gamma_Correction(img, gamma_val);
        case 'Boundary_Extraction'
         output = Boundary_Extraction(img);
         axes(handles.axes2);
         imshow(output);

        case 'Min_Filter'
            answer = inputdlg({'Enter Height (m):', 'Enter Width (n):'}, 'Min Filter', 1, {'3', '3'});
            m = str2double(answer{1}); n = str2double(answer{2});
            output = Min_Filter(img, m, n);

        case 'MidPoint_Filter'
            answer = inputdlg({'Enter Height (m):', 'Enter Width (n):'}, 'MidPoint Filter', 1, {'3', '3'});
            m = str2double(answer{1}); n = str2double(answer{2});
            output = MidPoint_Filter(img, m, n);

        case 'Point_Detection'
            output = Point_Detection(img);

        case 'Line_Detection'
            direction = str2double(inputdlg('Enter Direction (1:H, 2:V, 3:DL, 4:DR):','Line Detection',1,{'1'}));
            output = Line_Detection(img, direction);
        case 'Correlation_Filter'
            mask_str = inputdlg('Enter Mask (e.g., [1 1 1; 1 1 1; 1 1 1]/9):', 'Correlation', 1, {'[1 1 1; 1 1 1; 1 1 1]/9'});
            if ~isempty(mask_str)
                mask = str2num(mask_str{1}); 
                if isempty(mask)
                    msgbox('Invalid mask format.');
                else
                    output = Correlation_Filter(img, mask);
                    axes(handles.axes2); imshow(output);
                end
            end
         case 'Fourier_Transform'
         output = Show_Fourier_Spectrum(img);   
         axes(handles.axes2);
         imshow(output, []); 
         title('Magnitude Spectrum (Frequency Domain)');
         case 'Inverse_Fourier_Transform'
         img_double = double(RGBTOGRAY(img, 1));
         F = fft2(img_double);
         reconstructed = ifft2(F);
         output = uint8(real(reconstructed));
         axes(handles.axes2); imshow(output);
        case 'Adaptive_Mean_Filter'
        output = Adaptive_Mean_Filter(img); 
        axes(handles.axes2);
        imshow(output);
        title('Adaptive Mean Filter Result');
        case 'Adaptive_gaussian_Filter'
        prompt = {'Enter Window Size Example 7 or 9:', 'Enter Sensitivity (S) Example 500 or 1000'};
        dlgtitle = 'Adaptive Gaussian Settings';
        definput = {'7', '500'}; % ??? ???????? ???? ????? ????
        answer = inputdlg(prompt, dlgtitle, [1 35], definput);

        if ~isempty(answer)
        w_size = str2double(answer{1});
        sens = str2double(answer{2});
        
        img_input = handles.Image; 
        
        output = Adaptive_Gaussian_Filter(img_input, w_size, sens);
        
        axes(handles.axes2);
        imshow(output);
        title(['Adaptive Gaussian (S=', num2str(sens), ')']);
    end
        otherwise
        axes(handles.axes2); imshow(img);
    end
catch ME
    msgbox(sprintf('Error in filter: %s\n%s', selectedFilter, ME.message));
    return;
end
if exist('output', 'var')
    axes(handles.axes2); 
    imshow(output);
end
guidata(hObject, handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
cla(handles.axes1, 'reset'); 
title(handles.axes1, ''); %

cla(handles.axes2, 'reset');
title(handles.axes2, ''); 

if isfield(handles, 'Image')
    handles = rmfield(handles, 'Image');
end
guidata(hObject, handles);

msgbox('Image Deleted Successfuly', 'Delete Image', 'help');

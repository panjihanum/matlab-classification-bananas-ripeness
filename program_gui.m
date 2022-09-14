function varargout = program_gui(varargin)
% PROGRAM_GUI MATLAB code for program_gui.fig
%      PROGRAM_GUI, by itself, creates a new PROGRAM_GUI or raises the existing
%      singleton*.
%
%      H = PROGRAM_GUI returns the handle to a new PROGRAM_GUI or the handle to
%      the existing singleton*.
%
%      PROGRAM_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROGRAM_GUI.M with the given input arguments.
%
%      PROGRAM_GUI('Property','Value',...) creates a new PROGRAM_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before program_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to program_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help program_gui

% Last Modified by GUIDE v2.5 27-Aug-2020 23:58:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @program_gui_OpeningFcn, ...
    'gui_OutputFcn',  @program_gui_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before program_gui is made visible.
function program_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to program_gui (see VARARGIN)

% Choose default command line output for program_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui(hObject,'center');

% UIWAIT makes program_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = program_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% menampilkan menu browse file
[nama_file,nama_path] = uigetfile({'*.jpg'});

% jika ada file yg dipilih maka mengeksekusi perintah2 yg ada di bawahnya
if ~isequal(nama_file,0)
    % mereset button2
    axes(handles.axes1)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    
    axes(handles.axes2)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    
    axes(handles.axes5)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    
    axes(handles.axes6)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])

    axes(handles.axes9)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])

    axes(handles.axes12)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])

    
    set(handles.edit1,'String','')
    set(handles.edit2,'String','')
    
    set(handles.uitable1,'Data',[],'RowName',{'' '' '' ''})
    set(handles.uitable3,'Data',[],'RowName',{'' '' '' ''})

        
    set(handles.pushbutton2,'Enable','on')
    set(handles.pushbutton3,'Enable','off')
    
    % membaca file citra
    Img = im2double(imread(fullfile(nama_path,nama_file)));
    
    % menampilkan citra pada axes
    axes(handles.axes1)
    cla('reset')
    imshow(Img)
    title('Citra RGB')

    % cropping
    [height, width] = size(Img);
    size_x = floor(height / 2);
    size_y = floor(width / 10);
    targetSize = [size_x size_y];
    win1 = centerCropWindow2d(size(Img),targetSize);
    Img = imcrop(Img,win1);

    axes(handles.axes9);
    cla('reset')
    imshow(Img)
    title('Citra Cropping')

    % menampilkan citra HSV pada axes
    axes(handles.axes5)
    cla('reset')
    imshow(rgb2hsv(Img))
    title('Citra HSV')
        
    
    % Menampilkan Citra Resizing Pada Axes
    axes(handles.axes12);
    cla('reset')
    imshow(imresize(rgb2hsv(Img),[28 28]))
    title('Citra Resizing')

    % menampilkan nama file pada edit text
    set(handles.edit1,'String',nama_file)

    % menyimpan variabel Img pada lokasi handles agar dapat dipanggil oleh
    % pushbutton yg lain
    handles.Img = Img;
    guidata(hObject, handles)
else
    % jika ada tidak file yg dipilih maka akan kembali
    return
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% mereset button2
axes(handles.axes2)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

set(handles.edit2,'String','')
set(handles.pushbutton3,'Enable','on')

% memanggil variabel Img yg ada di lokasi handles
Img = handles.Img;

% mengektrak komponen RGB
R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);

% menampilkan histogram pada axes
axes(handles.axes2)
cla('reset')
h = histogram(R(:));
h.FaceColor = [1 0 0];
xlim([0 1])
grid on
hold on
h = histogram(G(:));
h.FaceColor = [0 1 0];
xlim([0 1])
h = histogram(B(:));
h.FaceColor = [0 0 1];
xlim([0 1])
hold off
title('RGB Histogram')


% menghitung nilai rata2 masing2 komponen
Red = mean(R(:));
Green = mean(G(:));
Blue = mean(B(:));

% menampilkan nilai rata2 masing2 komponen pada tabel
data_tabel = cell(3,2);
data_tabel{1,1} = 'Red';
data_tabel{2,1} = 'Green';
data_tabel{3,1} = 'Blue';
data_tabel{1,2} = Red;
data_tabel{2,2} = Green;
data_tabel{3,2} = Blue;
set(handles.uitable1,'Data',data_tabel,'RowName',1:3)

% menampilkan nilai HSV rata2 masing2 komponen pada tabel

% Convert RGB to HSV

hsvImage = rgb2hsv(Img);
hImage = hsvImage(:, :, 1);
sImage = hsvImage(:, :, 2);
vImage = hsvImage(:, :, 3);

% menampilkan histogram pada axes
% Hue (Merah), Saturation (Hijau), Value(Biru)
axes(handles.axes6)
cla('reset')
h = histogram(hImage(:));
h.FaceColor = [1 0 0];
xlim([0 1])
grid on
hold on
h = histogram(sImage(:));
h.FaceColor = [0 1 0];
xlim([0 1])
h = histogram(vImage(:));
h.FaceColor = [0 0 1];
xlim([0 1])
hold off
title('HSV Histogram')

% menampilkan nilai rata2 masing2 komponen pada tabel
hHist = mean(hImage(:));
sHist = mean(sImage(:));
vHist = mean(vImage(:));

data_tabel2 = cell(3,2);
data_tabel2{1,1} = 'Hue';
data_tabel2{2,1} = 'Saturation';
data_tabel2{3,1} = 'Value';
data_tabel2{1,2} = hHist;
data_tabel2{2,2} = sHist;
data_tabel2{3,2} = vHist;

set(handles.uitable3,'Data',data_tabel2,'RowName',1:3)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% mereset button2
set(handles.edit2,'String','')

% memanggil variabel Img yg ada di lokasi handles
Img = handles.Img;

% melakukan konversi ke hsv daan resizing citra
Img_rsz = imresize(rgb2hsv(Img),[28 28]);

% load variabel net
load net;

Img_pisang(:,:,:,1) = Img_rsz;

% membaca nilai keluaran hasil pengujian
predictedLabels = classify(net,Img_pisang);

% mengubah nilai keluaran menjadi kelas keluaran
switch predictedLabels
    case '1'
        kelas_keluaran = 'Terlalu Matang';
    case '2'
        kelas_keluaran = 'Matang';
    case '3'
        kelas_keluaran = 'Setengah Matang';
    case '4'
        kelas_keluaran = 'Mentah';
    otherwise
        kelas_keluaran = 'Tidak Dikenali';
end

% menampilkan kelas keluaran pada edit text
set(handles.edit2,'String',kelas_keluaran)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% mereset button2
axes(handles.axes1)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes2)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes12)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])


set(handles.edit1,'String','')
set(handles.edit2,'String','')

set(handles.uitable1,'Data',[],'RowName',{'' '' '' ''})

set(handles.pushbutton2,'Enable','off')
set(handles.pushbutton3,'Enable','off')


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = canny_gui(varargin)
% CANNY_GUI MATLAB code for canny_gui.fig
%      CANNY_GUI, by itself, creates a new CANNY_GUI or raises the existing
%      singleton*.
%
%      H = CANNY_GUI returns the handle to a new CANNY_GUI or the handle to
%      the existing singleton*.
%
%      CANNY_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CANNY_GUI.M with the given input arguments.
%
%      CANNY_GUI('Property','Value',...) creates a new CANNY_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before canny_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to canny_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help canny_gui

% Last Modified by GUIDE v2.5 04-Dec-2015 00:27:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @canny_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @canny_gui_OutputFcn, ...
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


% --- Executes just before canny_gui is made visible.
function canny_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to canny_gui (see VARARGIN)

% Choose default command line output for canny_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Set recursion limit
set(0,'RecursionLimit',1000)

% UIWAIT makes canny_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = canny_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TOOLBAR


% --------------------------------------------------------------------
function tb_open_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to tb_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'Load image');
handles.original = imread([pathname filename]);
handles.display = handles.original;
handles.edges = zeros(size(handles.original));

imshow(handles.display, 'Parent', handles.main_image);

guidata(hObject, handles);

% --------------------------------------------------------------------
function tb_save_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to tb_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[file,path] = uiputfile('*.png','Save Image As');

imwrite(handles.display, [path file]);

% --------------------------------------------------------------------
function tb_datacursor_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to tb_datacursor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

rect = getrect;
rectInt = int32(rect);
xmin = rectInt(1);
ymin = rectInt(2);
width = rectInt(3);
height = rectInt(4);

if sum(sum(handles.edges)) == 0
    
    sigma = get(handles.edit_sigma,'String');
    size = get(handles.edit_kernel,'String');
    low = get(handles.edit_low_th,'String');
    high = get(handles.edit_high_th,'String');

    [sigma, status] = str2num(sigma);
    if status ~= 1
        sigma = 1.5;
    end

    [size, status] = str2num(size);
    if status ~= 1
        size = 5;
    end

    [low, status] = str2num(low);
    if status ~= 1
        low = 30;
    end

    [high, status] = str2num(high);
    if status ~= 1
        high = 70;
    end
    
    handles.edges = apply_canny(handles.original, sigma, size, low, high);
    
end

handles.display = handles.original;
handles.display(ymin:ymin+height, xmin:xmin+width) = ...
    handles.edges(ymin:ymin+height, xmin:xmin+width)*255;
imshow(handles.display, 'Parent', handles.main_image);

guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONTROL PANEL

% --- Executes on button press in button_apply.
function button_apply_Callback(hObject, eventdata, handles)
% hObject    handle to button_apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% handles = guidata(hObject);

sigma = get(handles.edit_sigma,'String');
size = get(handles.edit_kernel,'String');
low = get(handles.edit_low_th,'String');
high = get(handles.edit_high_th,'String');

[sigma, status] = str2num(sigma);
if status ~= 1
    sigma = 1.5;
end

[size, status] = str2num(size);
if status ~= 1
    size = 5;
end

[low, status] = str2num(low);
if status ~= 1
    low = 30;
end

[high, status] = str2num(high);
if status ~= 1
    high = 70;
end

handles.edges = apply_canny(handles.original, sigma, size, low, high);
handles.display = handles.edges;
imshow(handles.display, 'Parent', handles.main_image);

guidata(hObject, handles);

% --- Executes on button press in button_original.
function button_original_Callback(hObject, eventdata, handles)
% hObject    handle to button_original (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.display = handles.original;
imshow(handles.display, 'Parent', handles.main_image);

guidata(hObject, handles);

% --- Executes on button press in button_edges.
function button_edges_Callback(hObject, eventdata, handles)
% hObject    handle to button_edges (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.display = handles.edges;
imshow(handles.display, 'Parent', handles.main_image);

guidata(hObject, handles);

function edit_sigma_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sigma as text
%        str2double(get(hObject,'String')) returns contents of edit_sigma as a double


% --- Executes during object creation, after setting all properties.
function edit_sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_kernel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_kernel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_kernel as text
%        str2double(get(hObject,'String')) returns contents of edit_kernel as a double


% --- Executes during object creation, after setting all properties.
function edit_kernel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_kernel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_low_th_Callback(hObject, eventdata, handles)
% hObject    handle to edit_low_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_low_th as text
%        str2double(get(hObject,'String')) returns contents of edit_low_th as a double


% --- Executes during object creation, after setting all properties.
function edit_low_th_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_low_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_high_th_Callback(hObject, eventdata, handles)
% hObject    handle to edit_high_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_high_th as text
%        str2double(get(hObject,'String')) returns contents of edit_high_th as a double


% --- Executes during object creation, after setting all properties.
function edit_high_th_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_high_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

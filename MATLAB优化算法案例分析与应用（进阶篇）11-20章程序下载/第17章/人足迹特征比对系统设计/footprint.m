function varargout = footprint(varargin)
% FOOTPRINT MATLAB code for footprint.fig
%      FOOTPRINT, by itself, creates a new FOOTPRINT or raises the existing
%      singleton*.
%
%      H = FOOTPRINT returns the handle to a new FOOTPRINT or the handle to
%      the existing singleton*.
%
%      FOOTPRINT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOOTPRINT.M with the given input arguments.
%
%      FOOTPRINT('Property','Value',...) creates a new FOOTPRINT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before footprint_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to footprint_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help footprint

% Last Modified by GUIDE v2.5 09-May-2014 13:28:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @footprint_OpeningFcn, ...
                   'gui_OutputFcn',  @footprint_OutputFcn, ...
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


% --- Executes just before footprint is made visible.
function footprint_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to footprint (see VARARGIN)

% Choose default command line output for footprint
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes footprint wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = footprint_OutputFcn(hObject, eventdata, handles) 
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
global im
warning off
geshi = { '*.bmp','Bitmap image (*.bmp)';...
         '*.jpg','JPEG image (*.jpg)';...
       '*.*','All Files (*.*)'};
[FileName FilePath] = uigetfile(geshi,'�����ⲿ����',...
'*.bmp','MultiSelect','on');% ѡ�����е�ͼƬ
% ���ѡ����ͼƬ�ļ�������ͼƬ�ļ�������·���������˳����򣬲������к�������
if ~isequal([FileName,FilePath],[0,0]);
    FileFullName = strcat(FilePath,FileName);
else
    return;
end
im = imread(FileFullName); % ��ȡͼ��
axes(handles.axes1);%ʹ��AXES1
imshow(im);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc,clear;close all


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
msgbox('����ѡ�������⣡ .\correct_pic\');
pause(1)
warning off
geshi = { '*.bmp','Bitmap image (*.bmp)';...
         '*.jpg','JPEG image (*.jpg)';...
       '*.*','All Files (*.*)'};
[FileName FilePath] = uigetfile(geshi,'�����ⲿ����',...
'*.bmp','MultiSelect','on');% ѡ�����е�ͼƬ
% ���ѡ����ͼƬ�ļ�������ͼƬ�ļ�������·���������˳����򣬲������к�������
if ~isequal([FileName,FilePath],[0,0]);
    FileFullName = strcat(FilePath,FileName);
else
    return;
end
n = length(FileFullName);  % ѡ���ͼƬ�ļ�����
for i = 1 : n
    irow=[];icol=[];img=[];
    % ���ζ�ȡÿһ��ͼƬ
    im1 = imread(FileFullName{i}); % ��ȡͼ��
    if size(im1,3)==1
        a=im1;
    else
        hsi=rgb2hsi(im1);
        H = hsi(:, :, 1);
        S = hsi(:, :, 2);
        I = hsi(:, :, 3);
        a= I; 
    %     a= rgb2gray(im);
    end
    a = medfilt2(a,[5,5]);  % ��ֵ�˲�
    b = edge(a,'sobel');    %% sobel����
    c = edge(a,'prewitt');  %% prewitt����
    d = edge(a,'canny') ;   %% canny����
    e = edge(a,'Roberts') ; %% Roberts����
    f = kirsch_algorithm(a); %% kirsch��������
    p=max(b,c);
    p=min(d,p);
    p=max(e,p);
    p=max(f,p);
    p = im2bw(p);
    [y,x] = find(p == 1);
    obj = p(min(y):max(y),min(x):max(x),:);
    obj = imresize(obj,[250,120]);
    obj = medfilt2(obj,[3,3]);  % ��ֵ�˲�
    database{i} = obj;
end
% �Դ����ͼ����б�Ե��ȡ
if size(im,3)==1
    a=im;
else
    hsi=rgb2hsi(im);
    H = hsi(:, :, 1);
    S = hsi(:, :, 2);
    I = hsi(:, :, 3);
    a= I; 
%     a= rgb2gray(im);
end
a = medfilt2(a,[5,5]);  % ��ֵ�˲�
b = edge(a,'sobel');    %% sobel����
c = edge(a,'prewitt');  %% prewitt����
d = edge(a,'canny') ;   %% canny����
e = edge(a,'Roberts') ; %% Roberts����
f = kirsch_algorithm(a); %% kirsch��������
p=max(b,c);
p=min(d,p);
p=max(e,p);
p=max(f,p);
p = im2bw(p);
[y,x] = find(p == 1);
obj = p(min(y):max(y),min(x):max(x),:);
obj = imresize(obj,[250,120]);
obj = medfilt2(obj,[3,3]);  % ��ֵ�˲�

% ����ŷʽ����ȡ��С��ԭ��ó�ƥ���ͼ��
Euc_dist = [];
for i = 1 : n
    temp = ( norm( obj - database{i} ) )^2;
    Euc_dist = [Euc_dist temp];
end
[Euc_dist_value , Recognized_index] = sort(Euc_dist);
axes(handles.axes2);%ʹ��AXES2
imshow( imread( FileFullName{ Recognized_index(1) } ) ); % ��ȡͼ��
axes(handles.axes3);%ʹ��AXES3
imshow( imread( FileFullName{ Recognized_index(2) } ) ); % ��ȡͼ��
axes(handles.axes4);%ʹ��AXES4
imshow( imread( FileFullName{ Recognized_index(3) } ) ); % ��ȡͼ��
axes(handles.axes5);%ʹ��AXES5
imshow( imread( FileFullName{ Recognized_index(4) } ) ); % ��ȡͼ��

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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
if size(im,3)==1
    a=im;
else
    hsi=rgb2hsi(im);
    H = hsi(:, :, 1);
    S = hsi(:, :, 2);
    I = hsi(:, :, 3);
    a= I; 
%     a= rgb2gray(im);
end
a = medfilt2(a,[5,5]);  % ��ֵ�˲�
b = edge(a,'sobel');    %% sobel����
c = edge(a,'prewitt');  %% prewitt����
d = edge(a,'canny') ;   %% canny����
e = edge(a,'Roberts') ; %% Roberts����
f = kirsch_algorithm(a); %% kirsch��������
p=max(b,c);
p=min(d,p);
p=max(e,p);
p=max(f,p);
p = im2bw(p);
axes(handles.axes6);%ʹ��AXES1
imshow(p);

function varargout = ysw(varargin)
% YSW MATLAB code for ysw.fig
%      YSW, by itself, creates a new YSW or raises the existing
%      singleton*.
%
%      H = YSW returns the handle to a new YSW or the handle to
%      the existing singleton*.
%
%      YSW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in YSW.M with the given input arguments.
%
%      YSW('Property','Value',...) creates a new YSW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ysw_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ysw_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ysw

% Last Modified by GUIDE v2.5 10-Apr-2014 09:14:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ysw_OpeningFcn, ...
                   'gui_OutputFcn',  @ysw_OutputFcn, ...
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


% --- Executes just before ysw is made visible.
function ysw_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ysw (see VARARGIN)

% Choose default command line output for ysw
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ysw wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ysw_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc,clear,close all

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
warning off
%% ѵ������Ԥ��������ȡ
%���������������
load('data.mat');          % ԭʼ�������������ķ�ʽ�����workplace�ļ���
%% ����ѵ������
num_train = get(handles.edit2,'string');
num_train = str2num(num_train);
im_sep = MRI_pic(num_train);      % ѡȡ��30��ͼ��train ��������, ѡΪ30
% ��ȡ�������output
lev2 = 50/255;                    % ��ֵ
L = zeros(size(im_sep));          % 0=����
L(im_sep<lev2 & im_sep>0) = 2;    % 2=����
L(im_sep>=lev2) = 3;              % 3=����
L = mat2gray(L);      
% figure,imshow(L);title('�Ұ��ʷָ�ͼ')
%% train �����train ���
nd = size(im_sep);       % ���ݴ�С
% ѵ������
input_train = reshape(im_sep,nd(1,1)*nd(1,2),1)';  % ��Ϊ����
output_train = reshape(L,nd(1,1)*nd(1,2),1)';      % ��ΪĿ������
% ��������
num = get(handles.edit4,'string');                          % numȡֵ 13--31֮��
num = str2num(num);
im_sep_test = MRI_pic(num);        % ��ȡnum��ͼ��test ��������, ��������
nd_test = size(im_sep_test);       % ���ݴ�С
input_test = reshape(im_sep_test,nd_test(1,1)*nd_test(1,2),1)';  % ��Ϊ����

%% BP��������
%�ڵ����
inputnum=4;
hiddennum=7;
outputnum=1;

%��������
nntwarn off
net=newff(input_train,output_train,hiddennum);

%% BP����ѵ��
%�����������
net.trainParam.epochs = 40;
net.trainParam.lr = 0.1;
%net.trainParam.goal=0.00001;
%����ѵ��
[net,per2]=train(net,input_train,output_train);
output_test_simu = sim(net,input_test);  % BPԤ��
im = reshape(output_test_simu,nd_test(1,1),nd_test(1,2));
%��ͼ��ʾ
axes(handles.axes3);
imshow(im);
xlabel('����BP������ĻҰ��ʷָ�ͼ')
% figure,imshow(im_sep_test);title('MRI����ͼ��')



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
warning off
%% ѵ������Ԥ��������ȡ����һ��
%���������������
load('data.mat');          % ԭʼ�������������ķ�ʽ�����workplace�ļ���
%% ����ѵ������
num_train = get(handles.edit2,'string');
num_train = str2num(num_train);
im_sep = MRI_pic(num_train);      % ѡȡ��30��ͼ��train ��������, ѡΪ30
% ��ȡ�������output
lev2 = 50/255;                    % ��ֵ
L = zeros(size(im_sep));          % 0 = ����
L(im_sep<lev2 & im_sep>0) = 2;    % 2 = ����
L(im_sep>=lev2) = 3;              % 3 = ����
L = mat2gray(L);      
% figure,imshow(L);title('�Ұ��ʷָ�ͼ')
% ѵ������
nd = size(im_sep);       % ���ݴ�С
input_train = reshape(im_sep,nd(1,1)*nd(1,2),1)';  % ��Ϊ����
output_train = reshape(L,nd(1,1)*nd(1,2),1)';      % ��ΪĿ������

%% ��������
num = get(handles.edit4,'string');         % numȡֵ 13--31֮��
num = str2num(num);                        % numȡֵ 13--31֮��
im_sep_test = MRI_pic(num);        % ��ȡnum��ͼ��test ��������, ��������
nd_test = size(im_sep_test);       % ���ݴ�С
input_test = reshape(im_sep_test,nd_test(1,1)*nd_test(1,2),1)';  % ��Ϊ�������

%% BP��������
%�ڵ����
inputnum  = 1;
hiddennum = 7;
outputnum = 1;

%��������
nntwarn off
net=newff(input_train,output_train,hiddennum);

%% �Ŵ��㷨������ʼ��
maxgen = 5;                          %��������������������
sizepop = 5;                         %��Ⱥ��ģ
pcross = [0.3];                       %�������ѡ��0��1֮��
pmutation = [0.1];                    %�������ѡ��0��1֮��

%�ڵ�����
numsum=inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum;

lenchrom=ones(1,numsum);        
bound=[0*ones(numsum,1) 3*ones(numsum,1)];    %���ݷ�Χ

%------------------------------------------------------��Ⱥ��ʼ��--------------------------------------------------------
individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  %����Ⱥ��Ϣ����Ϊһ���ṹ��
avgfitness = [];                      %ÿһ����Ⱥ��ƽ����Ӧ��
bestfitness = [];                     %ÿһ����Ⱥ�������Ӧ��
bestchrom = [];                       %��Ӧ����õ�Ⱦɫ��
%��ʼ����Ⱥ
for i=1:sizepop
    %�������һ����Ⱥ
    individuals.chrom(i,:)=Code(lenchrom,bound); %���루binary��grey�ı�����Ϊһ��ʵ����float�ı�����Ϊһ��ʵ��������
    x=individuals.chrom(i,:);
    %������Ӧ��
    individuals.fitness(i)=fun(x,inputnum,hiddennum,outputnum,net,input_train,output_train);   %Ⱦɫ�����Ӧ��
end

%����õ�Ⱦɫ��
[bestfitness bestindex]=min(individuals.fitness);
bestchrom=individuals.chrom(bestindex,:);    % ��õ�Ⱦɫ��
avgfitness=sum(individuals.fitness)/sizepop; % Ⱦɫ���ƽ����Ӧ��
%��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��
trace=[avgfitness bestfitness]; 
 
%% ���������ѳ�ʼ��ֵ��Ȩֵ
% ������ʼ
for i=1:maxgen
    i
    % ѡ��
    individuals=Select(individuals,sizepop); 
    avgfitness=sum(individuals.fitness)/sizepop;
    %����
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop,bound);
    % ����
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,i,maxgen,bound);
    
    % ������Ӧ�� 
    for j=1:sizepop
        x=individuals.chrom(j,:); %����
        individuals.fitness(j)=fun(x,inputnum,hiddennum,outputnum,net,input_train,output_train);   
    end
    
  %�ҵ���С�������Ӧ�ȵ�Ⱦɫ�弰��������Ⱥ�е�λ��
    [newbestfitness,newbestindex]=min(individuals.fitness);
    [worestfitness,worestindex]=max(individuals.fitness);
    % ������һ�ν�������õ�Ⱦɫ��
    if bestfitness>newbestfitness
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom;
    individuals.fitness(worestindex)=bestfitness;
    
    avgfitness=sum(individuals.fitness)/sizepop;
    
    trace=[trace;avgfitness bestfitness]; %��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��

end
%% �Ŵ��㷨������� 
figure('color',[1,1,1]),
[r c]=size(trace);
plot([1:r]',trace(:,2),'b--');
title(['��Ӧ������  ' '��ֹ������' num2str(maxgen)]);
xlabel('��������');   ylabel('��Ӧ��');
legend('ƽ����Ӧ��','�����Ӧ��');
disp('��Ӧ��                   ����');
x=bestchrom;

%% �����ų�ʼ��ֵȨֵ��������Ԥ��
% %���Ŵ��㷨�Ż���BP�������ֵԤ��
w1=x(1:inputnum*hiddennum);
B1=x(inputnum*hiddennum+1:inputnum*hiddennum+hiddennum);
w2=x(inputnum*hiddennum+hiddennum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum);
B2=x(inputnum*hiddennum+hiddennum+hiddennum*outputnum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum);

net.iw{1,1}=reshape(w1,hiddennum,inputnum);
net.lw{2,1}=reshape(w2,outputnum,hiddennum);
net.b{1}=reshape(B1,hiddennum,1);
net.b{2}=B2;

%% BP����ѵ��
%�����������
net.trainParam.epochs=10;
net.trainParam.lr=0.1;
%net.trainParam.goal=0.00001;
%����ѵ��
[net,per2]=train(net,input_train,output_train);

%% BP����Ԥ��
[net,per2] = train(net,input_train,output_train);
output_test_simu = sim(net,input_test);  % BPԤ��
im = reshape(output_test_simu,nd_test(1,1),nd_test(1,2));
%��ͼ��ʾ
axes(handles.axes4);
imshow(im);
xlabel('����GA_BP�ĻҰ��ʷָ�ͼ')


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
warning off
%% ѵ������Ԥ��������ȡ
%���������������
load('data.mat');          % ԭʼ�������������ķ�ʽ�����workplace�ļ���
%% ����ѵ������
pic1 = get(handles.edit2,'string');
pic1 = str2num(pic1);
% ��13 - 31   ��32-44ȡ����
if pic1 <13 || pic1>31
    msgbox('num���ֲ��ԣ�num��13-31֮�䣡����');
else
    im_org = data(:,:,pic1);  % �� i ֡ͼ��
    axes(handles.axes1);
    imshow(im_org)
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
warning off
%% ѵ������Ԥ��������ȡ
%���������������
load('data.mat');          % ԭʼ�������������ķ�ʽ�����workplace�ļ���
%% �����������
pic1 = get(handles.edit4,'string');
pic1 = str2num(pic1);
% ��13 - 31   ��32-44ȡ����
if pic1 <13 || pic1>31
    msgbox('num���ֲ��ԣ�num��13-31֮�䣡����');
else
    im_org_test = data(:,:,pic1);  % �� i ֡ͼ��
    axes(handles.axes2);
    imshow(im_org_test)
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('ͼ��ı����13-31֮�䣬��ע���������');

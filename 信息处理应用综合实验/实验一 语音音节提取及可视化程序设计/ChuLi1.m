function varargout = ChuLi1(varargin)
% CHULI1 MATLAB code for ChuLi1.fig
%      CHULI1, by itself, creates a new CHULI1 or raises the existing
%      singleton*.
%
%      H = CHULI1 returns the handle to a new CHULI1 or the handle to
%      the existing singleton*.
%
%      CHULI1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHULI1.M with the given input arguments.
%
%      CHULI1('Property','Value',...) creates a new CHULI1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ChuLi1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ChuLi1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ChuLi1

% Last Modified by GUIDE v2.5 26-Sep-2023 14:54:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ChuLi1_OpeningFcn, ...
                   'gui_OutputFcn',  @ChuLi1_OutputFcn, ...
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


% --- Executes just before ChuLi1 is made visible.
function ChuLi1_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ChuLi1 (see VARARGIN)

% Choose default command line output for ChuLi1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ChuLi1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ChuLi1_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(~, ~, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;% 信号时域
global Fs;% 信号采样频率
global len;%信号长度
global t1;% 信号时域坐标范围
[filename,filepath]=uigetfile({'*.wav'},'音频路径');
if(isequal(filename,0)||isequal(filepath,0))
    return;
end
voice=[filepath,filename];
[handles.x,handles.Fs]=audioread(voice);
x=handles.x(:,1);
len=length(x);
Fs=handles.Fs;
axes(handles.axes1);
t1=[0:1/Fs:(length(x)-1)/Fs];
plot(t1,x);
axis([-inf inf -1.2 1.2]);
title('音频信号时域波形');
xlabel('时间/s');
ylabel('幅度');
grid on;
df=Fs/len;
w=[0:df:df*(len-1)]-Fs/2;
x1=fft(x);
x1=fftshift(x1);
axes(handles.axes2);
plot(w,abs(x1)/max(abs(x1)));
axis([-10000,10000,0,1]);
title('音频信号频域波形');
xlabel('频率/Hz');
ylabel('归一化幅度');
grid on;



function edit2_Callback(~, ~, ~)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, ~, ~)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(~, ~, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global len;
global x;
global Fs;
global zhenchang;
global zhen;
z=get(handles.edit2,'String');
zhenchang=str2num(z);
zhen=len/zhenchang;
%预加重
x4=zeros(len,1);
for i=0:zhen-1
    x2=x(i*zhenchang+1:i*zhenchang+zhenchang);
    x3=zeros(zhenchang,1);
    x3(1,1)=x2(1,1);
    for j=2:zhenchang
        x3(j)=x2(j)-0.98*x2(j-1);
    end
    x4(i*zhenchang+1:i*zhenchang+zhenchang)=x3;
end
axes(handles.axes3);
t2=[0:1/Fs:(length(x4)-1)/Fs];
plot(t2,x4);
axis([-inf inf -1.2 1.2]);
title('预加重后时域波形');
xlabel('时间/s');
ylabel('幅度');
grid on;
df=Fs/len;
w=[0:df:df*(len-1)]-Fs/2;
x1=fft(x4);
x1=fftshift(x1);
axes(handles.axes4);
plot(w,abs(x1)/max(abs(x1)));
axis([-10000,10000,0,1]);
title('预加重后频域波形');
xlabel('频率/Hz');
ylabel('归一化幅度');
grid on;


% --- Executes on selection change in listbox1.
function listbox1_Callback(~, ~, ~)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, ~, ~)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%矩形窗
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(~, ~, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
global zhenchang;
global Fs;
global len;
x2=enframe(x,boxcar(zhenchang),zhenchang/2);
axes(handles.axes5);
t2=[0:1/Fs:(length(x2)-1)/Fs];
plot(t2,x2);
axis([-inf inf -1.2 1.2]);
title('加矩形窗后时域波形');
xlabel('时间/s');
ylabel('幅度');
grid on;
df=Fs/len;
w=[0:df:df*(len-1)]-Fs/2;
x1=fft(x2);
x1=fftshift(x1);
axes(handles.axes6);
plot(w,abs(x1)/max(abs(x1)));
axis([-10000,10000,0,1]);
title('加矩形窗后频域波形');
xlabel('频率/Hz');
ylabel('归一化幅度');
grid on;

%汉明窗
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(~, ~, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
global zhenchang;
global Fs;
global len;
x2=enframe(x,hamming(zhenchang),zhenchang/2);
axes(handles.axes5);
t2=[0:1/Fs:(length(x2)-1)/Fs];
plot(t2,x2);
axis([-inf inf -1.2 1.2]);
title('加汉明窗后时域波形');
xlabel('时间/s');
ylabel('幅度');
grid on;
df=Fs/len;
w=[0:df:df*(len-1)]-Fs/2;
x1=fft(x2);
x1=fftshift(x1);
axes(handles.axes6);
plot(w,abs(x1)/max(abs(x1)));
axis([-10000,10000,0,1]);
title('加汉明窗后频域波形');
xlabel('频率/Hz');
ylabel('归一化幅度');
grid on;

%语音端点检测
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(~, ~, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
global zhenchang;
global zhen;
Em=zeros(1,(zhen-1)*zhenchang);
for i=1:(zhen-1)*zhenchang
    temp=x(i:i+zhenchang);
    Em(i)=sum(temp.*temp);
end
j=1:(zhen-1)*zhenchang;
axes(handles.axes7);
plot(j,Em,'b');
xlabel('帧数');
ylabel('短时能量');
title('短时平均能量');
grid on;
Mn=zeros(1,(zhen-1)*zhenchang);
for i=1:(zhen-1)*zhenchang
    temp=x(i:i+zhenchang);
    Mn(i)=sum(abs(temp))/zhenchang;
end
axes(handles.axes8);
plot(j,Mn,'b');
xlabel('帧数');
ylabel('短时平均幅度');
title('短时平均幅度');
grid on;
Zn=zeros(1,(zhen-1)*zhenchang);
for i=2:(zhen-1)*zhenchang
    temp1=sign(x(i:i+zhenchang));
    temp=sign(x(i-1:i+zhenchang-1));
    Zn(i)=sum(abs(temp1-temp));
end
axes(handles.axes8);
plot(j,Zn,'b');
xlabel('帧数');
ylabel('短时过零率');
title('短时过零率');
grid on;
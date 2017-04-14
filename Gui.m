<<<<<<< HEAD
function varargout = Gui(varargin)
% GUI MATLAB code for Gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gui

% Last Modified by GUIDE v2.5 03-Apr-2017 18:19:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Gui_OutputFcn, ...
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

% --- Executes just before Gui is made visible.
function Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gui (see VARARGIN)

% UIWAIT makes Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Choose default command line output for Gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%Added Code
graph(handles) %calls the graph funtion
rangeClearButton_Callback(hObject, eventdata, handles) %clears the range


% --- Outputs from this function are returned to the command line.
function varargout = Gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%     --- Executes on selection change in dataList.
function dataList_Callback(hObject, eventdata, handles)
listChoice = get(hObject,'Value'); %gets the selected choice
dataChoice = char(handles.NAMES(listChoice)); %dataChoice is the name of the selected file
handles.FULLDATAFILENAME = fullfile('DataFolder',dataChoice);  %This is the 
%   name of the file that contains the water usage data. Use as 
%   load(handles.FULLDATAFILENAME)

fprintf('Data Selection Changed to %s\n', handles.FULLDATAFILENAME);

guidata(hObject,handles) %saves the handles of FULLDATAFILENAME
graph(handles) %calls the graph function to update graph

% --- Executes during object creation, after setting all properties.
function dataList_CreateFcn(hObject, eventdata, handles)
dataSelection = dir(['DataFolder','\*.mat']); %gets info about the content in DataFolder
handles.NAMES = {dataSelection.name}; %gets only the file names in DataFolder
set(hObject,'String',handles.NAMES) %sets the list box to display those file names

listChoice = get(hObject,'Value'); %gets the selected choice (default is 1)
dataChoice = char(handles.NAMES(listChoice)); %dataChoice is the name of the selected file
handles.FULLDATAFILENAME = fullfile('DataFolder',dataChoice); %This is the 
%name of the file that contains the water usage data. Use as - load(handles.FULLDATAFILENAME)

guidata(hObject,handles) %saves the handles of NAMES and FULLDATAFILENAME


function maxLevelEditBox_Callback(hObject, eventdata, handles)
handles.maxLevel = str2double(get(hObject,'String')); %this variable contains user input for max level
if(isnan(handles.maxLevel)) %ensures that input is a number
    fprintf('Please input a number\n')
else
    fprintf('Max Level changed to %f\n',handles.maxLevel) %prints the change 
    guidata(hObject,handles) %updates the handles only if input is valid
end

% --- Executes during object creation, after setting all properties.
function maxLevelEditBox_CreateFcn(hObject, eventdata, handles)


function minLevelEditBox_Callback(hObject, eventdata, handles)
handles.minLevel = str2double(get(hObject,'String')); %this variable stores user imput for min level
if(isnan(handles.minLevel)) %ensures that input is a number
    fprintf('Please input a number\n')
else
    fprintf('Min Level changed to %f\n',handles.minLevel) %prints the change 
    guidata(hObject,handles) %updates the handles only if input is valid
end

% --- Executes during object creation, after setting all properties.
function minLevelEditBox_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in rangeClearButton.
function rangeClearButton_Callback(hObject, eventdata, handles)
handles.minLevel = 0; %sets both variables to 0
handles.maxLevel = 0;
set(handles.minLevelEditBox,'String','') %sets both edit boxes to blank
set(handles.maxLevelEditBox,'String','')
guidata(hObject,handles) %updates the handles
fprintf('Range Edit Boxes Cleared\n') %prints that the ranges were cleared


function timeEditBox_Callback(hObject, eventdata, handles)
% hObject    handle to timeEditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timeEditBox as text
%        str2double(get(hObject,'String')) returns contents of timeEditBox as a double


% --- Executes during object creation, after setting all properties.
function timeEditBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timeEditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in timeClearButton.
function timeClearButton_Callback(hObject, eventdata, handles)
% hObject    handle to timeClearButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%This function updates the graph
function graph(handles)
axes(handles.graphOutput) %points to graphOutput so the plot knows where to go
load(handles.FULLDATAFILENAME) %loads the currently selected data file into memory
rtank=5;%the dimension of the tank
htank=20;
wl(1)=10;%the initial water level
vm3(1)=rtank^2*pi*wl(1);% inital volumes in cubic meters 
vgal(1)=vm3(1)/.0038; % initial volume in gallons 
%sill need to add in the min and max lewvel 
for k=2:1:length(time)
    dt=(time(k)-time(k-1));
    vgal(k)=vgal(k-1)-water_usage(k)*dt; %finds the next volume in gallons
    vm3(k)=vgal(k)*.0038; % converts to volume cubic meters
    wl(k)=vm3(k)/(rtank^2*pi);% finds the nex twater level
    if wl>20
        error('water level exceeds the constraints the tank')
    elseif wl<0
        error('the water tank is empty')
    end
end
 %need to put in a get from the check baxes for an if sructer   
 % if includelevelCheckbox(is checked)
   plot(time,wl)
 %if includeRateCheckbox(is checked)&&galUnitButton(is checked)
%plot(time,water_usage)
%if includeRateCheckbox(is checked)&&galUnitButton(is checked)
% plot(time,water_usage*.0038)


% --- Executes on button press in galUnitButton.
function galUnitButton_Callback(hObject, eventdata, handles)
% hObject    handle to galUnitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of galUnitButton


% --- Executes on button press in m3UnitButton.
function m3UnitButton_Callback(hObject, eventdata, handles)
% hObject    handle to m3UnitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of m3UnitButton


% --- Executes on button press in includeLevelCheckbox.
function includeLevelCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to includeLevelCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of includeLevelCheckbox


% --- Executes on button press in includeRateCheckbox.
function includeRateCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to includeRateCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of includeRateCheckbox
=======
function varargout = Gui(varargin)
% GUI MATLAB code for Gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gui

% Last Modified by GUIDE v2.5 14-Apr-2017 08:25:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Gui_OutputFcn, ...
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

% --- Executes just before Gui is made visible.
function Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gui (see VARARGIN)

% UIWAIT makes Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Choose default command line output for Gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%Added Code
graph(hObject, handles) %calls the graph funtion



% --- Outputs from this function are returned to the command line.
function varargout = Gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%     --- Executes on selection change in dataList.
function dataList_Callback(hObject, eventdata, handles)
listChoice = get(hObject,'Value'); %gets the selected choice
dataChoice = char(handles.NAMES(listChoice)); %dataChoice is the name of the selected file
handles.FULLDATAFILENAME = fullfile('DataFolder',dataChoice);  %This is the 
%   name of the file that contains the water usage data. Use as 
%   load(handles.FULLDATAFILENAME)

fprintf('Data Selection Changed to %s\n', handles.FULLDATAFILENAME);

guidata(hObject,handles) %saves the handles of FULLDATAFILENAME
graph(hObject, handles) %calls the graph function to update graph

% --- Executes during object creation, after setting all properties.
function dataList_CreateFcn(hObject, eventdata, handles)
dataSelection = dir(['DataFolder','\*.mat']); %gets info about the content in DataFolder
handles.NAMES = {dataSelection.name}; %gets only the file names in DataFolder
set(hObject,'String',handles.NAMES) %sets the list box to display those file names

listChoice = get(hObject,'Value'); %gets the selected choice (default is 1)
dataChoice = char(handles.NAMES(listChoice)); %dataChoice is the name of the selected file
handles.FULLDATAFILENAME = fullfile('DataFolder',dataChoice); %This is the 
%name of the file that contains the water usage data. Use as - load(handles.FULLDATAFILENAME)

guidata(hObject,handles) %saves all the handles

function timeEditBox_Callback(hObject, eventdata, handles)
sTime = str2double(get(hObject,'String')); %gets the value stored in the box
sTimeIndex = find(handles.time == sTime); %finds the index of where the specific time is
sLevel = handles.waterLevel(sTimeIndex); %the water level at the specific time
sRate = handles.waterRate(sTimeIndex); %the rate at the specific time

set(handles.timeLevel,'String',sLevel) %sets both output texts to the right values
set(handles.timeRate,'String',sRate)


% --- Executes during object creation, after setting all properties.
function timeEditBox_CreateFcn(hObject, eventdata, handles)

% --- Executes on button press in timeClearButton.
function timeClearButton_Callback(hObject, eventdata, handles)
set(handles.timeLevel,'String','') %clears the specific time display 
set(handles.timeRate,'String','')
set(handles.timeEditBox,'String','')

%This function updates the graph
function graph(hObject, handles)
hold off;
axes(handles.graphOutput) %points to WaterLevel so the plot knows where to go
load(handles.FULLDATAFILENAME) %loads the currently selected data file into memory
rtank = 5;%the dimension of the tank
htank = 20;
wl(1)= 10;%i set the initial water level for ten because there wasnt anything saying what it would start at 
vm3(1)= rtank^2*pi*wl(1);% inital volumes in cubic meters 
vgal(1) = vm3(1)/.0038; % initial volume in gallons 
dt = 1;
pump(1)= 0;
wlmin = 2; % Assumed, this might have to be changed
wlmax = 18;
flowin = 1000;
%sill need to add in the min and max lewvel 
for k=2:1:length(time)
    pump(k)= pump(k-1);
    
    if pump(k)==0
        vgal(k)=vgal(k-1)-water_usage(k)*dt; %next volume in gallons if the pump is off
    else
        vgal(k)=vgal(k-1)+(flowin-water_usage(k))*dt; %next volume in gallons if the pump is on
    end
    vm3(k)= vgal(k)*.0038; %converts volume to cubic meters
    wl(k)= vm3(k)/(rtank^2*pi); %finds water level using the cubic meter volume
    if wl(k) < wlmin && pump(k)== 0 %pump controls 
        pump(k)=1;
        fprintf('The punp has been turned ON at %i. \nThe water level is %0.4f.\n',time(k),wl(k))
    elseif wl(k)>wlmax && pump(k)== 1
        pump(k)=0;
        fprintf('The punp has been turned OFF at %i. \nThe water level is %0.4f.\n',time(k),wl(k))
    end
    if wl>20
        error('water level exceeds the constraints the tank')
    elseif wl<0
        error('the water tank is empty')
    end
end

wlminp(1)=wlmin;
wlmaxp(1)=wlmax;
for k=2:1:length(time)
    wlminp(k)=wlmin;
    wlmaxp(k)=wlmax;
end
plot(time,wlminp,'--')%puts min and max lines on the graph
hold on
plot(time,wlmaxp,'--')
 %need to put in a get from the check baxes for an if sructer
 LevelCheckBox=get(handles.includeLevelCheckbox,'Value');
 RateCheckBox=get(handles.includeRateCheckbox,'Value');
 GalButton=get(handles.galUnitButton,'Value');
 m3Button=get(handles.m3UnitButton,'Value');
 if LevelCheckBox==1
   plot(time,wl)%plots the water level
 end
 if (RateCheckBox==1)&&(GalButton==1)
plot(time,water_usage)%plots rate in gallons per minute
 elseif (RateCheckBox==1)&&(m3Button==1)
plot(time,water_usage*.0038)%plots rate in cubic meters per minute 
 end
hold off

handles.waterLevel = wl; %this is the vector of the water level
handles.waterRate = water_usage; %this is the vector of the water usage
handles.time = time; %this is the vector of the times

guidata(hObject,handles) %updates the handles



% --- Executes on button press in galUnitButton.
function galUnitButton_Callback(hObject, eventdata, handles)
% hObject    handle to galUnitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
graph(hObject, handles)
% Hint: get(hObject,'Value') returns toggle state of galUnitButton


% --- Executes on button press in m3UnitButton.
function m3UnitButton_Callback(hObject, eventdata, handles)
% hObject    handle to m3UnitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
graph(hObject, handles)
% Hint: get(hObject,'Value') returns toggle state of m3UnitButton


% --- Executes on selection change in graphMenu.
function graphMenu_Callback(hObject, eventdata, handles)
% hObject    handle to graphMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns graphMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from graphMenu


% --- Executes during object creation, after setting all properties.
function graphMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to graphMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
>>>>>>> origin/master

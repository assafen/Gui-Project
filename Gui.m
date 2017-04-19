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

% Last Modified by GUIDE v2.5 18-Apr-2017 13:05:45

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

%Added Code to display graph
graph(handles, eventdata)
set(handles.inRange,'String','') %stops displaying out of range on opening

% --- Outputs from this function are returned to the command line.
function varargout = Gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function staticData(handles)
changeValue = handles.waterLevelUnits(end)-handles.waterLevelUnits(1);
if get(handles.m3UnitButton,'Value') == 1 %units are metric
    initialString = strcat(num2str(handles.waterLevelUnits(1)),' m');
    finalString = strcat(num2str(handles.waterLevelUnits(end)), ' m');
    changeString = strcat(num2str(changeValue), ' m');
else %units are imperial
    initialString = strcat(num2str(handles.waterLevelUnits(1)),' ft');
    finalString = strcat(num2str(handles.waterLevelUnits(end)), ' ft');
    changeString = strcat(num2str(changeValue), ' ft');
end

%sets the static data strings
set(handles.initialLevel,'String',initialString)
set(handles.finalLevel,'String',finalString)
set(handles.netChange,'String',changeString)
if changeValue >= 0
    set(handles.netChange,'ForegroundColor',[0,.5,0])%green
else
    set(handles.netChange,'ForegroundColor',[.5,0,0])%red
end

%     --- Executes on selection change in dataList.
function dataList_Callback(hObject, eventdata, handles)
listChoice = get(hObject,'Value'); %gets the selected choice
dataChoice = char(handles.NAMES(listChoice)); %dataChoice is the name of the selected file
handles.FULLDATAFILENAME = fullfile('DataFolder',dataChoice);  %This is the
%   name of the file that contains the water usage data.
fprintf('Data Selection Changed to %s\n', handles.FULLDATAFILENAME);

guidata(hObject,handles) %saves the handles of FULLDATAFILENAME
graph(handles, eventdata) %calls the graph function to update graph

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
%This allows decimal input and rounds down
sTime = str2double(get(hObject,'String')); %gets the value stored in the box;
remainderTime = mod(sTime,handles.dt);
normalTime = (sTime - remainderTime);

sTimeIndex = find(handles.time == normalTime); %finds the index of where the specific time is
sLevel = handles.waterLevelUnits(sTimeIndex); %the water level at the specific time
sVolume = handles.waterVolumeUnits(sTimeIndex); %the volume at the specific time
sRate = handles.waterRateUnits(sTimeIndex); %the rate at the specific time
sPump = handles.pump(sTimeIndex); %the pump status

if isempty(sTimeIndex)
    set(handles.inRange,'String','Out of Range')
else
    set(handles.inRange,'String','')
end
    
if get(handles.m3UnitButton,'Value') == 1 %units are metric
    set(handles.timeLevel,'String',strcat(num2str(sLevel),' m'))
    set(handles.timeVolume,'String',strcat(num2str(sVolume),' m^3'))
    set(handles.timeRate,'String',strcat(num2str(sRate),' m^3/min'))
    
else %units are U.S.
    set(handles.timeLevel,'String',strcat(num2str(sLevel),' ft'))
    set(handles.timeVolume,'String',strcat(num2str(sVolume),' gal'))
    set(handles.timeRate,'String',strcat(num2str(sRate),' gal/min'))
end

if sPump == 1
    set(handles.pumpStatus,'String','On')
    set(handles.pumpStatus,'ForegroundColor',[0,.5,0]) %green
else
    set(handles.pumpStatus,'String','Off')
    set(handles.pumpStatus,'ForegroundColor',[.5,0,0]) %red
end

if isempty(sTimeIndex) %if there not any valid data input
    timeClearButton_Callback(handles.timeClearButton, eventdata, handles) %clears the units
    set(handles.inRange,'String','Out of Range')
end

handles.sLevel = sLevel;
guidata(handles.timeEditBox, handles) %updates the handles
drawTank(handles)

% --- Executes on button press in timeClearButton.
function timeClearButton_Callback(hObject, eventdata, handles)
set(handles.timeLevel,'String','') %clears the specific time display
set(handles.timeVolume,'String','')
set(handles.timeRate,'String','')
set(handles.timeEditBox,'String','')
set(handles.pumpStatus,'String','')
set(handles.inRange,'String','')
handles.sLevel = '';
drawTank(handles) %updates the tank to be blank

%This function updates the graph
function graph(handles, eventdata)
handles.rTank = 5; %the dimension of the tank
handles.hTank = 20;

wl(1)= 10; %Initial Water Level ??????
wlmin = 2; % Assumed, this might have to be changed
wlmax = 18;
flowin = 1000; %pump rate in gal/min

vm3(1)= handles.rTank^2*pi*wl(1);% inital volumes in cubic meters
vgal(1) = vm3(1)/.0038; % initial volume in gallons
pump(1)= 0; %pump starts off

axes(handles.graphOutput) %points to graphOutput so the plot knows where to go
load(handles.FULLDATAFILENAME) %loads the currently selected data file into memory
dt = time(2) - time(1);

for k = 2:dt:length(time)
    pump(k)= pump(k-1);
    if pump(k)==0
        vgal(k)=vgal(k-1)-water_usage(k)*dt; %next volume in gallons if the pump is off
    else
        vgal(k)=vgal(k-1)+(flowin-water_usage(k))*dt; %next volume in gallons if the pump is on
    end
    vm3(k)= vgal(k)*.0038; %converts volume to cubic meters
    wl(k)= vm3(k)/(handles.rTank^2*pi); %finds water level using the cubic meter volume
    if wl(k) < wlmin && pump(k)== 0 %pump controls
        pump(k)=1;
        %fprintf('The pump has been turned ON at %i. \nThe water level is %0.4f.\n',time(k),wl(k))
    elseif wl(k)>wlmax && pump(k)== 1
        pump(k)=0;
        %fprintf('The pump has been turned OFF at %i. \nThe water level is %0.4f.\n',time(k),wl(k))
    end
end

%Data is altered based on Units
if get(handles.m3UnitButton,'Value') == 1 %Units are Metric
    waterLevelUnits = wl; %meters
    waterVolumeUnits = vm3; %meters
    waterRateUnits = water_usage*.00378541; %cubic meters per minute
    
    for k = 1:length(time)
        maxLevelPump(k) = wlmax; %vector of the pump turn-off level
        minLevelPump(k) = wlmin; %vector of the pump turn-on level
    end
    levelVAxis = 'Water Level (m)'; %vertical axis title for water level
    volumeVAxis = 'Water Volume (m^3)'; %vertical axis title for water level
    rateVAxis = 'Water Rate (m^3/min)'; %vertical axis title for water rate
    
else %Units are U.S.
    waterLevelUnits = wl*3.28084; %feet
    waterVolumeUnits = vgal; %gal
    waterRateUnits = water_usage; %gal per minute
    
    for k = 1:length(time)
        maxLevelPump(k) = wlmax*3.28084; %vector of the pump turn-off level
        minLevelPump(k) = wlmin*3.28084; %vector of the pump turn-on level
    end
    levelVAxis = 'Water Level (ft)'; %vertical axis title for water level
    volumeVAxis = 'Water Volume (gal)'; %vertical axis title for water level
    rateVAxis = 'Water Rate (gal/min)'; %vertical axis title for water rate
end

%Graphing based on drop down menu
if handles.type==1 %Water Level
    plot(time,waterLevelUnits) %plots water level in correct units
    xlabel('Time (minutes)')
    ylabel(levelVAxis) %gives unit based axis label
    title('Water Level in Tank')
    
    hold on %Adds the min/max lines
    plot(time,maxLevelPump,'--') %puts min and max lines on the graph
    plot(time,minLevelPump,'--') %Units are considered
    legend('Water Level', 'Max Level','Minimum Level','location','best')
    hold off
    
elseif handles.type==2 %Water Volume
    plot(time,waterVolumeUnits)%plots volume in correct units
    xlabel('Time (minutes)')
    ylabel(volumeVAxis) %y axis title with correct units
    title('Water Volume in Tank')
    
elseif handles.type==3 %Water Rate
    plot(time,waterRateUnits)%plots water rate in correct units
    xlabel('Time (minutes)')
    ylabel(rateVAxis) %y axis title with correct units
    title('Water Usage Rate')
end

%Creates and saves handles
handles.waterLevelUnits = waterLevelUnits; %Water Level vector in correct units
handles.waterVolumeUnits = waterVolumeUnits; %Water Volume vector in correct units
handles.waterRateUnits = waterRateUnits; %Water Rate vector in correct units
handles.pump = pump; %Vector of the pump status
handles.time = time; %Time vector from data
handles.dt = dt; %dt of the time vector

guidata(handles.graphMenu, handles) %updates the handles
staticData(handles) %updates Static Data
timeEditBox_Callback(handles.timeEditBox, eventdata, handles) %Updates units

% --- Executes on button press in galUnitButton.
function galUnitButton_Callback(hObject, eventdata, handles)
graph(handles, eventdata)

% --- Executes on button press in m3UnitButton.
function m3UnitButton_Callback(hObject, eventdata, handles)
graph(handles, eventdata)

% --- Executes on selection change in graphMenu.
function graphMenu_Callback(hObject, eventdata, handles)
handles.type = get(hObject,'Value');
guidata(hObject, handles)
graph(handles, eventdata)

% --- Executes during object creation, after setting all properties.
function graphMenu_CreateFcn(hObject, eventdata, handles)
handles.type = get(hObject,'Value');
guidata(hObject,handles)

function drawTank(handles)
currentLevel = handles.sLevel; %current water level with correct units
axes(handles.tankPicture) %points to the correct axes

if get(handles.m3UnitButton,'Value') == 1 %meters
    maxLevel = handles.hTank; %tank dimensions
    radius = handles.rTank;
    heightString = strcat(num2str(maxLevel), ' m');
    radiusString = strcat(num2str(radius), ' m');
else %feet
    maxLevel = handles.hTank*3.28084; %tank dimensions
    radius = handles.rTank*3.28084;
    heightString = strcat(num2str(maxLevel), ' ft');
    radiusString = strcat(num2str(radius), ' ft');
end

R = [radius radius]; %radius of the bottom and top of the cylinder
N = 15; %number of points on the cylinder circumference

%Draws the tank
[X,Y,Z] = cylinder(R,N);
Z(2,:) = maxLevel;
tankCylinder = surf(X,Y,Z);
set(tankCylinder,'FaceAlpha',0.1,'EdgeColor',[0 0 0],'EdgeAlpha',0.4, 'FaceColor',[0 0 0])

if isempty(currentLevel) == 0 %only executes if there is data to act on
    %Draws the water    
    hold on
    [X2,Y2,Z2] = cylinder(R,N); %creates a cyclinder with a radius = radius
    Z2(end,:) = currentLevel; %sets the cylinders height to the water level
    waterCylinder = surf(X2,Y2,Z2);
    set(waterCylinder,'EdgeColor',[0 0 0],'EdgeAlpha',0, 'FaceColor',[0 0 1])
    patch(X2(end,:), Y2(end,:), Z2(end,:),[0 0 1]); %colors the top face
    hold off
    
    %Title when data is present
    text(0,0,1.3*maxLevel,['Tank Status at ' get(handles.timeEditBox,...
        'String')  ' minutes'],'HorizontalAlignment','center')
else
    %Title when data is not present
    text(0,0,1.3*maxLevel,'Tank Status','HorizontalAlignment','center')
end
%Lists tank dimensions
text(-2*radius,0,maxLevel/2,['Tank Height: ' heightString],'HorizontalAlignment','right')
text(-2*radius,0,maxLevel/4,['Tank Radius: ' radiusString],'HorizontalAlignment','right')

axis equal
axis off

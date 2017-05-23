function varargout = closedlg(varargin)
% CLOSEDLG MATLAB code for closedlg.fig
%      CLOSEDLG, by itself, creates a new CLOSEDLG or raises the existing
%      singleton*.
%
%      H = CLOSEDLG returns the handle to a new CLOSEDLG or the handle to
%      the existing singleton*.
%
%      CLOSEDLG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLOSEDLG.M with the given input arguments.
%
%      CLOSEDLG('Property','Value',...) creates a new CLOSEDLG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before closedlg_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to closedlg_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help closedlg

% Last Modified by GUIDE v2.5 23-May-2017 17:00:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @closedlg_OpeningFcn, ...
                   'gui_OutputFcn',  @closedlg_OutputFcn, ...
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


% --- Executes just before closedlg is made visible.
function closedlg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to closedlg (see VARARGIN)

% Choose default command line output for closedlg
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes closedlg wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = closedlg_OutputFcn(hObject, eventdata, handles) 
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
% Get the current position from the handles structure
% to pass to the modal dialog
pos_size = get(handles.figure1, 'position');

% Call modaldlg with the argument 'Position'.
user_response = modaldlg('Title','Confirm Close');
switch user_response
    case 'No'
        % take no action
    case 'Yes'
        % Prepare to close apprication window
        delete(handles.figure1)
end

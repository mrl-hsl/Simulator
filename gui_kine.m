function varargout = gui_kine(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_kine_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_kine_OutputFcn, ...
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

function gui_kine_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
set(handles.text_ID_1,'string',get(handles.slider_ID_1,'Value'));
set(handles.text_ID_2,'string',get(handles.slider_ID_2,'Value'));
set(handles.text_ID_3,'string',get(handles.slider_ID_3,'Value'));
set(handles.text_ID_4,'string',get(handles.slider_ID_4,'Value'));
set(handles.text_ID_5,'string',get(handles.slider_ID_5,'Value'));
set(handles.text_ID_6,'string',get(handles.slider_ID_6,'Value'));
set(handles.text_ID_7,'string',get(handles.slider_ID_7,'Value'));
set(handles.text_ID_8,'string',get(handles.slider_ID_8,'Value'));
set(handles.text_ID_9,'string',get(handles.slider_ID_9,'Value'));
set(handles.text_ID_10,'string',get(handles.slider_ID_10,'Value'));
set(handles.text_ID_11,'string',get(handles.slider_ID_11,'Value'));
set(handles.text_ID_12,'string',get(handles.slider_ID_12,'Value'));
set(handles.text_ID_13,'string',get(handles.slider_ID_13,'Value'));
set(handles.text_ID_14,'string',get(handles.slider_ID_14,'Value'));
set(handles.text_ID_15,'string',get(handles.slider_ID_15,'Value'));
set(handles.text_ID_16,'string',get(handles.slider_ID_16,'Value'));
set(handles.text_ID_17,'string',get(handles.slider_ID_17,'Value'));
set(handles.text_ID_18,'string',get(handles.slider_ID_18,'Value'));
set(handles.text_ID_19,'string',get(handles.slider_ID_19,'Value'));
set(handles.text_ID_20,'string',get(handles.slider_ID_20,'Value'));
set(handles.text_Z,'string',get(handles.slider_Z,'Value'));
set(handles.text_Y,'string',get(handles.slider_Y,'Value'));
set(handles.text_X,'string',get(handles.slider_X,'Value'));

function varargout = gui_kine_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function slider_ID_1_Callback(hObject, eventdata, handles)
global q1;
q1 = get(hObject,'Value');
set_param('Hamed_Mahmoudi2017/Kinematics/Constant1','Value',num2str(q1))
set(handles.text_ID_1,'string',num2str(q1));

function slider_ID_1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_2_Callback(hObject, eventdata, handles)
global q2;
q2 = get(hObject,'Value');
set_param('robot_action/Kinematics/Constant2','Value',num2str(q2))
set(handles.text_ID_2,'string',num2str(q2));

function slider_ID_2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_3_Callback(hObject, eventdata, handles)
global q3;
q3 = get(hObject,'Value');
set_param('robot_action/Kinematics/Constant3','Value',num2str(q3))
set(handles.text_ID_3,'string',num2str(q3));

function slider_ID_3_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_4_Callback(hObject, eventdata, handles)
global q4;
q4 = get(hObject,'Value');
set_param('robot_action/Kinematics/Constant4','Value',num2str(q4))
set(handles.text_ID_4,'string',num2str(q4));

function slider_ID_4_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_5_Callback(hObject, eventdata, handles)
global q5;
q5 = get(hObject,'Value');
set_param('robot_action/Kinematics/Constant5','Value',num2str(q5))
set(handles.text_ID_5,'string',num2str(q5));

function slider_ID_5_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_6_Callback(hObject, eventdata, handles)
global q6;
q6 = get(hObject,'Value');
set_param('robot_action/Kinematics/Constant6','Value',num2str(q6))
set(handles.text_ID_6,'string',num2str(q6));

function slider_ID_6_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_7_Callback(hObject, eventdata, handles)
global q7;
q7 = get(hObject,'Value');
set_param('robot_action/Kinematics/Constant7','Value',num2str(q7))
set(handles.text_ID_7,'string',num2str(q7));

function slider_ID_7_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_8_Callback(hObject, eventdata, handles)
global q8;
q8 = get(hObject,'Value');
set_param('robot_action/Kinematics/Constant8','Value',num2str(q8))
set(handles.text_ID_8,'string',num2str(q8));

function slider_ID_8_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_9_Callback(hObject, eventdata, handles)
global q9;
q9 = get(hObject,'Value');
set_param('robot_action/Kinematics/Constant9','Value',num2str(q9))
set(handles.text_ID_9,'string',num2str(q9));

function slider_ID_9_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_10_Callback(hObject, eventdata, handles)
global q10;
q10 = get(hObject,'Value');
set_param('robot_action/Kinematics/Constant10','Value',num2str(q10))
set(handles.text_ID_10,'string',num2str(q10));

function slider_ID_10_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_11_Callback(hObject, eventdata, handles)
global q11;
q11 = get(hObject,'Value');
set_param('robot_action/Kinematics/Constant11','Value',num2str(q11))
set(handles.text_ID_11,'string',num2str(q11));

function slider_ID_11_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_12_Callback(hObject, eventdata, handles)
global q12;
q12 = get(hObject,'Value');
set_param('robot_action/Kinematics/Constant12','Value',num2str(q12))
set(handles.text_ID_12,'string',num2str(q12));

function slider_ID_12_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_13_Callback(hObject, eventdata, handles)
global q13;
q13 = get(hObject,'Value');
set_param('robot_action/Kinematics/Constant13','Value',num2str(q13))
set(handles.text_ID_13,'string',num2str(q13));

function slider_ID_13_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_14_Callback(hObject, eventdata, handles)
global q14;
q14 = get(hObject,'Value');
set_param('robot_action/Kinematics/Constant14','Value',num2str(q14))
set(handles.text_ID_14,'string',num2str(q14));

function slider_ID_14_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_15_Callback(hObject, eventdata, handles)
global q15;
q15 = get(hObject,'Value');
set_param('robot_action/Kinematics/Constant15','Value',num2str(q15))
set(handles.text_ID_15,'string',num2str(q15));

function slider_ID_15_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_16_Callback(hObject, eventdata, handles)
global q16;
q16 = get(hObject,'Value');
set_param('robot_action/Kinematics/Constant16','Value',num2str(q16))
set(handles.text_ID_16,'string',num2str(q16));

function slider_ID_16_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_17_Callback(hObject, eventdata, handles)
global q17;
q17 = get(hObject,'Value');
set_param('robot_action/Kinematics/Constant17','Value',num2str(q17))
set(handles.text_ID_17,'string',num2str(q17));

function slider_ID_17_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_18_Callback(hObject, eventdata, handles)
global q18;
q18 = get(hObject,'Value');
set_param('robot_action/Kinematics/Constant18','Value',num2str(q18))
set(handles.text_ID_18,'string',num2str(q18));

function slider_ID_18_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_19_Callback(hObject, eventdata, handles)
global q19;
q19 = get(hObject,'Value');
set_param('InverseKinematics/Kinematics/Constant19','Value',num2str(q19))
set(handles.text_ID_19,'string',num2str(q19));

function slider_ID_19_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_ID_20_Callback(hObject, eventdata, handles)
global q20;
q20 = get(hObject,'Value');
set_param('InverseKinematics/Kinematics/Constant20','Value',num2str(q20))
set(handles.text_ID_20,'string',num2str(q20));

function slider_ID_20_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_Z_Callback(hObject, eventdata, handles)
global Z;
Z = get(hObject,'Value');
set_param('InverseKinematics/Kinematics/Constant26','Value',num2str(Z))
set(handles.text_Z,'string',num2str(Z));

function slider_Z_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_Y_Callback(hObject, eventdata, handles)
global Y;
Y = get(hObject,'Value');
set_param('InverseKinematics/Kinematics/Constant25','Value',num2str(Y))
set(handles.text_Y,'string',num2str(Y));

function slider_Y_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_X_Callback(hObject, eventdata, handles)
global X;
X = get(hObject,'Value');
set_param('InverseKinematics/Kinematics/Constant24','Value',num2str(X))
set(handles.text_X,'string',num2str(X));

function slider_X_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

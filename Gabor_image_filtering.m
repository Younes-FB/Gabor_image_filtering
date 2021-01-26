function varargout = Gabor_image_filtering(varargin)
% GABOR_IMAGE_FILTERING MATLAB code for Gabor_image_filtering.fig
%      GABOR_IMAGE_FILTERING, by itself, creates a new GABOR_IMAGE_FILTERING or raises the existing
%      singleton*.
%
%      H = GABOR_IMAGE_FILTERING returns the handle to a new GABOR_IMAGE_FILTERING or the handle to
%      the existing singleton*.
%
%      GABOR_IMAGE_FILTERING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GABOR_IMAGE_FILTERING.M with the given input arguments.
%
%      GABOR_IMAGE_FILTERING('Property','Value',...) creates a new GABOR_IMAGE_FILTERING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gabor_image_filtering_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gabor_image_filtering_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE'sigma Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gabor_image_filtering

% Last Modified by GUIDE v2.5 26-Jan-2021 14:25:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gabor_image_filtering_OpeningFcn, ...
                   'gui_OutputFcn',  @Gabor_image_filtering_OutputFcn, ...
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
function Gabor_image_filtering_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
set(handles.intensity_slider,'Value',3);
set(handles.intensity1,'String',3);
set(handles.Intensity_gobarfilter,'Value',3);
set(handles.FrameSlider,'Value',1);
% Update handles structure
%%%%%%%%%%%%%% show gabor image
sigma = str2num(get(handles.Sigma,'String'));
lambda = str2num(get(handles.Lambda,'String'));
gama = str2num(get(handles.Gama,'String'));
psi = str2num(get(handles.Psi,'String'));
 handles.s_gabor=30; 
theta=pi/2;
size=handles.s_gabor; 
for x=-size:size
    for y=-size:size 
        xn=x*cos(theta)+y*sin(theta);
        yn=-x*sin(theta)+y*cos(theta);
        G(size+x+1,size+y+1)=exp(-pi*(xn^2/sigma^2+(gama^2)*yn^2/sigma^2))*(exp(1i*(2*pi/lambda*xn+psi))-exp(-pi*(sigma/lambda)^2));
    end
end
% figure,
% imshow(uint8(1000*real(G)+100),'Initialmagnification',800);
   imshow(uint8(100/max(max(real(G)))*real(G)+100),'Parent',handles.axes3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
guidata(hObject, handles);
% --- Outputs from this function are returned to the command line.
function varargout = Gabor_image_filtering_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
varargout{1} = handles.output;
% --- Executes on button press in Loadimage_button.
function Loadimage_button_Callback(hObject, eventdata, handles)
[file,Folder] = uigetfile('*.tif');% select a tif image or tif stack
handles.Folder=Folder;handles.file=file;
handles.Folder=Folder;handles.file=file;
      fullFileName = [Folder,file];
      InfoImage=imfinfo(fullFileName);
      NumberImages=length(InfoImage);
 for j=1:NumberImages
          clear im0
          im0 = imread(fullFileName,'Index',j);
          img(:,:,j)=im0;
 end
  handles.Im=uint8(img);
  handles.size=size(img,3);
  if handles.size>1
     set(handles.FrameSlider,'Value',round(handles.size/3+1))
     set(handles.Frame,'String',round(handles.size/2))
     imshow(handles.Im(:,:,round(get(handles.FrameSlider,'Value'))).*get(handles.intensity_slider,'Value'),'Parent',handles.axes1);
  elseif handles.size==1
     set(handles.FrameSlider,'Value',1)
     set(handles.Frame,'String',1)
      imshow(handles.Im(:,:,round(get(handles.FrameSlider,'Value'))).*get(handles.intensity_slider,'Value'),'Parent',handles.axes1);
  end
  
 guidata(hObject, handles);% update handles
% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% --- Executes on slider movement.
function intensity_slider_Callback(hObject, eventdata, handles)
%handles.R = round(100*get(handles.intensity_slider,'Value'))/100;
set(handles.intensity1,'String',get(handles.intensity_slider,'Value'));
 imshow(handles.Im(:,:,round(get(handles.FrameSlider,'Value'))).*get(handles.intensity_slider,'Value'),'Parent',handles.axes1);
guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function intensity_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function intensity1_Callback(hObject, eventdata, handles)
guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function intensity1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object deletion, before destroying properties.
function intensity1_DeleteFcn(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)

% --- Executes on slider movement.
function FrameSlider_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'Value') returns position of slider
if handles.size==1
     set(handles.FrameSlider,'Value',1)
     set(handles.Frame,'String',1)
    return
end
maxNumberOfImages = handles.size;
set(handles.FrameSlider, 'Min', 1);
set(handles.FrameSlider, 'Max', maxNumberOfImages);
set(handles.FrameSlider, 'SliderStep', [1/(maxNumberOfImages-1) , 10/(maxNumberOfImages-1) ]);
set(handles.Frame,'String',round(get(handles.FrameSlider,'Value')));
imshow(handles.Im(:,:,round(get(handles.FrameSlider,'Value'))).*get(handles.intensity_slider,'Value'),'Parent',handles.axes1)
guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function FrameSlider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function Frame_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function Frame_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Sigma_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function Sigma_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function Lambda_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function Lambda_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function Gama_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function Gama_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function Psi_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function Psi_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function RunFilter_button_Callback(hObject, eventdata, handles)
disp('wait')
sigma = str2num(get(handles.Sigma,'String'));
lambda = str2num(get(handles.Lambda,'String'));
gama = str2num(get(handles.Gama,'String'));
psi = str2num(get(handles.Psi,'String'));
Im=im2double(handles.Im(:,:,round(get(handles.FrameSlider,'Value'))));
AvIm=squeeze(max(handles.Im,[],3));
clear theta0
th0=0:45:136;
theta0=th0*(pi/180);
% theta0=0:pi/4:pi-0.1;
for i=1:length(theta0)
    clear im R G GABOUT
  theta=theta0(i);
  %%%%%%%%%%%%%%%%%%%%%%%%%%%
  size=handles.s_gabor; 
    for x=-size:size
       for y=-size:size 
        xn=x*cos(theta)+y*sin(theta);
        yn=-x*sin(theta)+y*cos(theta);
          G(size+x+1,size+y+1)=1*exp(-pi*(xn^2/sigma^2+(gama^2)*yn^2/sigma^2))*(exp(1i*(2*pi/lambda*xn+psi))-exp(-pi*(sigma/lambda)^2));
       end
    end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 GABOUT=conv2(Im,G*2,'same');
 im1(:,:,i)=uint8(real(GABOUT));
end
im1=uint8(im1);
Im2=squeeze(max(im1,[],3));
% Im2(Im2==1)=0;
handles.Im2=Im2;
set(handles.Intensity_gobarfilter,'Value',200/max(max(handles.Im2)))
imshow(handles.Im2(:,:).*get(handles.Intensity_gobarfilter,'Value'),'Parent',handles.axes2)
disp('Filtering completed')
guidata(hObject, handles);
% --- Executes on slider movement.
function Intensity_gobarfilter_Callback(hObject, eventdata, handles)
get(handles.Intensity_gobarfilter,'Value')
imshow(handles.Im2(:,:).*get(handles.Intensity_gobarfilter,'Value'),'Parent',handles.axes2)
guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function Intensity_gobarfilter_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end 

% --- Executes on button press in save_button.
function save_button_Callback(hObject, eventdata, handles)
for n=1:handles.size
       display(['Filtering_frame = ' num2str(n) ' ' 'out of' ' ' num2str(handles.size)])
       clear Jb J K I Im_f mf im1 Imm
 Im0=im2double(handles.Im(:,:,n));
 imshow(Im0.*get(handles.intensity_slider,'Value'),'Parent',handles.axes1)
 set(handles.Frame,'String',get(handles.intensity_slider,'Value'))
 pause(0.1)
sigma = str2num(get(handles.Sigma,'String'));
lambda = str2num(get(handles.Lambda,'String'));
gama = str2num(get(handles.Gama,'String'));
psi = str2num(get(handles.Psi,'String'));
clear theta0
th0=0:45:136;
theta0=th0*(pi/180);
for i=1:length(theta0)
  clear  im R G GABOUT
  theta=theta0(i);
   %%%%%%%%%%%%%%%%%%%%%%%%%%%
  size=handles.s_gabor; 
    for x=-size:size
       for y=-size:size 
        xn=x*cos(theta)+y*sin(theta);
        yn=-x*sin(theta)+y*cos(theta);
          G(size+x+1,size+y+1)=1*exp(-pi*(xn^2/sigma^2+(gama^2)*yn^2/sigma^2))*(exp(1i*(2*pi/lambda*xn+psi))-exp(-pi*(sigma/lambda)^2));
       end
    end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 GABOUT=conv2(Im0,G*2,'same');
 im1(:,:,i)=uint8(real(GABOUT));
end
im1=uint8(im1);
Im2=squeeze(max(im1,[],3));
% Im2(Im2==1)=0;
  imshow(Im2(:,:).*get(handles.Intensity_gobarfilter,'Value'),'Parent',handles.axes2)
        Imsave=Im2;
        newimagename = [handles.Folder handles.file(1:end-4) '_gobarFilter.tif'];   
        imwrite(Imsave,newimagename,'writemode', 'append');  
end
handles.Im2=Im2;
guidata(hObject, handles);


% --- Executes on button press in Gabor_out.
function Gabor_out_Callback(hObject, eventdata, handles)
sigma = str2num(get(handles.Sigma,'String'));
lambda = str2num(get(handles.Lambda,'String'));
gama = str2num(get(handles.Gama,'String'));
psi = str2num(get(handles.Psi,'String'));
theta=pi/2;
   %%%%%%%%%%%%%%%%%%%%%%%%%%%
  size=handles.s_gabor; 
    for x=-size:size
       for y=-size:size 
        xn=x*cos(theta)+y*sin(theta);
        yn=-x*sin(theta)+y*cos(theta);
          G(size+x+1,size+y+1)=1*exp(-pi*(xn^2/sigma^2+(gama^2)*yn^2/sigma^2))*(exp(1i*(2*pi/lambda*xn+psi))-exp(-pi*(sigma/lambda)^2));
       end
    end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   imshow(uint8(100/max(max(real(G)))*real(G)+100),'Parent',handles.axes3)
guidata(hObject, handles);

% i have installed a tolbox for video capture image acquisition at this
% link https://www.mathworks.com/hardware-support/video-capture-device.html?s_tid=AO_HS_info

% IMPORTANT: I am working with Logithech C922 Pro. This camera can be set
% at a frame rate of 60 frame per second if set at 720p. You have to set
% the quality of the video by using the logitech webcam app dowoloadable
% here https://www.logitech.com/en-roeu/product/capture

% FORM MAC USERS: 
 
% unfortunately i couldn't find a way to adjust the framerate of the camera
% via matlab. The only way is to set it via the app on a windows computer.
 
% After you set it, connect the camera and launch matlab. 
% If the code is not working, and matlab crash,
% that means that the camera doesn’t work because you don't have the rigths to access the camera.
% To overcome this problem you need to launch matlab via terminal and
% update the security settings to allow the terminal to control the webcams
 
% 1) open the terminal
% 2) type this: cd /Applications/MATLAB_R2019b.app/bin
% 3) type this: ./matlab
% keep it open and work on matlab.
 
 
% IMPORTANT: before start, select the video quality at 720p, 60 fps
% through the logitech app on a windows computer


clear all;
% for windows users use "winvideo"
infoCamera = imaqhwinfo('macvideo');
% see which formats are supported
infoCamera.DeviceInfo(1).SupportedFormats;

% define which camera you want to use and the supported format you want
% i selected camera 1 and 3 because i had 4 cameras. Check the cameras
% number by typing infoCamera.DeviceInfo.DeviceName
% open the infoCamera matrix to see your cameras and the number of cameras
% you have. Put the number related to your cameras in the videoinput

vid1 = videoinput('macvideo',1,'YCbCr422_1280x720');
vid2 = videoinput('macvideo',3,'YCbCr422_1280x720');

% preview the video to see where the camera is pointing

preview(vid1);
preview(vid2);

% select how many times you want to capture the video. If inf, it means that
% the video goes forever until you stop it with the command stop.

vid1.TriggerRepeat = Inf;
vid2.TriggerRepeat = Inf;


% put trigger manual to manually start the sampling. This will set a
% trigger: the camera would not start to collect images untile you send the
% command trigger(vid1) ( see later in the code).


triggerconfig(vid1,'manual');
triggerconfig(vid2,'manual');

% set that you want to save the video into your hard disk
vid1.LoggingMode = 'disk';
vid2.LoggingMode = 'disk';


% set the directory where you want to save your video and the name of your
% video. Set your own directory

vid1.DiskLogger = VideoWriter(['Type here your directory' '.AVI'],'Uncompressed AVI');
vid2.DiskLogger = VideoWriter(['Type here your directory' '.AVI'],'Uncompressed AVI');


% my cameras are set on a framerate of 60 frame per second (fps). You can adjust your
% framerate using your webcam app on your computer. most of them have 30
% fps, very rare cameras can be set at 60 fps. Mine works at 60 fps with a
% resolution of 760p.
 

% set how many frames to capture
seconds_video = 5  

frame_rate = 60;

vid1.FramesPerTrigger = seconds_video * frame_rate;
vid2.FramesPerTrigger = seconds_video * frame_rate;



%% ONLY FOR WINDOWS USERS:
% if you are using the logitech 922 pro
% Open the logitech camera app and set the preferences of the camera to 720p at 60 frames per second
% then in the matlab script set the framerate of the cameras

% vid1_src= getselectedsource(vid1);
% vid2_src= getselectedsource(vid2);

% vid1_src.FrameRate = 60
% vid2_src.FrameRate = 60

% then set the number of frames you want to capture 

% vid1.FramesPerTrigger = seconds_video * str2num(vid1_src.FrameRate);
% vid2.FramesPerTrigger = seconds_video * str2num(vid2_src.FrameRate);

%%

% Start acquistion


start(vid1);
start(vid2);

display('press spacebar to start')
pause

[~, StartTrialSecs, ~, ~] = KbCheck(-1);
flag = 0;

% the cameras will not start to sample the video until you give the command
% "trigger"
trigger([vid1 vid2]);

while flag == 0
    [~, MiddleTrialSecs, ~, ~] = KbCheck(-1);
    TrialMilliSecs = (MiddleTrialSecs - StartTrialSecs);
    if TrialMilliSecs >= seconds_video
    flag = 1;
    end
end

% the following command stop the camera sampling

stop([vid1 vid2]);

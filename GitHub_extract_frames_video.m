clear all

uiopen('Your video directory/nameofthevideo.avi',1);
uiopen('Your video directory/nameofthevideo.avi',1);

folder = 'D:\Ivan\ValidationDeepLabCut\Images_webcam_calibration\';
for i = 1:length(Ivan_camera1);
   imwrite(Ivan_camera1(i).cdata, [folder,'camera-1','-',sprintf('%02d',i),'.jpg']);
end

for i = 1:length(Ivan_camera2);
   imwrite(Ivan_camera2(i).cdata, [folder,'camera-2','-',sprintf('%02d',i),'.jpg']);
end
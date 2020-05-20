clear all 
close all

camera = CameraRGBD;
sensorProcessing = ProcessCameraData;
sensorProcessing.DetectBlueBlock(camera);

%% Leave temporarily for plotting image Data (let Max remove when ready)
% imshow(camera.rgbImg);
% imshow(camera.grayImg);
% hold on
% plot(sensorProcessing.blockCornerPoints);


% figure(1)
% imshow(camera.rgbImg);
% figure(2)
% imshow(camera.grayImg);
% figure(3)
% imshow(camera.depthImg)

%% program structure
% class for subscribing to camera (ROS)
% class for processing camera data to give object position (PROGRAM)
% class for controlling robot (PROGRAM)
% class for publishing to robot arm (ROS)

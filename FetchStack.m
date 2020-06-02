clear all 
close all

% Create camera object
camera = CameraRGBD();
% Create object for processing camera data
sensorProcessing = ProcessCameraData();

% Detect blue and red block
sensorProcessing.DetectBlueBlock(camera);
sensorProcessing.DetectRedBlock(camera);

% Move to blue block
keyboard;
fetch = FetchRobotArm();
fetch.MoveRobotArm(sensorProcessing.blueBlock);

%sensorProcessing.DetectGreenBlock(camera);
%% Leave temporarily for plotting image Data (let Max remove when ready)
% imshow(camera.rgbImg);
%             kern = [0, 1, 0;
%                 1, -4, 1;
%                 0, 1, 0];
%            cameraImage = uint8(conv2(camera.grayImg, kern, 'same'));
% imshow(cameraImage);
% imwrite(cameraImage, 'block.jpg');

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

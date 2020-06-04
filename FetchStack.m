clear all 
close all

% Create an origin point to move arm too after placing

%% Create objects of relevant classes
disp('Creating objects to subscribe and publish to fetch robot')
% Create camera object
camera = CameraRGBD();
% Create object for processing camera data
sensorProcessing = ProcessCameraData();
% Create object for moving robot
fetch = FetchRobotArm();


% Detect blue and red block
% disp('Detecting blue block')
% sensorProcessing.DetectBlueBlock(camera);
disp('Detecting red block')
sensorProcessing.DetectRedBlock(camera);
% disp('Detecting green block')
% sensorProcessing.DetectGreenBlock(camera);

%% Move to blue block
% if sensorProcessing.noBlueBlock == false && sensorProcessing.noRedBlock == false
%     fetch.PickUpBlock(sensorProcessing.blueBlock);
% else
%     % Right side of program flow chart
% end

% greenWaypoint = sensorProcessing.greenBlock;
% greenWaypoint.X_base(3) = greenWaypoint.X_base(3) + 0.16;
% fetch.MoveRobotArm(greenWaypoint);
% % keyboard;
% fetch.MoveRobotArm(sensorProcessing.greenBlock);
disp('Picking Up Red Blcok');
fetch.PickUpBlock(sensorProcessing.redBlock);

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

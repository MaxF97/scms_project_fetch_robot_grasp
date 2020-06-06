clear all 
close all

%% Create objects of relevant classes
disp('Creating objects to subscribe and publish to fetch robot')
% Create camera object
camera = CameraRGBD();
% Create object for processing camera data
sensorProcessing = ProcessCameraData();
% Create object for moving robot
fetch = FetchRobotArm();

% Move to origin
% -----------INSERT MOVE TO ORIGIN HERE -----------%

%% Detect blue and red blocks
disp('Detecting blue block')
sensorProcessing.DetectBlueBlock(camera);
disp('Detecting red block')
sensorProcessing.DetectRedBlock(camera);

%% Move to pick up block logic
if sensorProcessing.noBlueBlock == false && sensorProcessing.noRedBlock == false
    % Pick up red block
    disp('Pick up red block')
    fetch.PickUpBlock(sensorProcessing.redBlock)
    % Place red block
    disp('Place red block on blue block');
    fetch.PlaceGrippedBlockOn(sensorProcessing.redBlock, sensorProcessing.blueBlock);
    
    % -----------INSERT MOVE TO ORIGIN HERE -----------%
    
    % Detect red block
    disp('Detecting red block')
    sensorProcessing.DetectRedBlock(camera);
    if sensorProcessing.noRedBlock == true
        disp('ERROR: Red block is was misplaced')
    else
        % Detect green block
        disp('Detecting green block')
        sensorProcessing.DetectGreenBlock(camera);
        if sensorProcessing.noGreenBlock == false
            % Pick up green block
            disp('Pick up green block');
            fetch.PickUpBlock(sensorProcessing.greenBlock);
            % Place green block
            disp('Place green block on red block');
            fetch.PlaceGrippedBlockOn(sensorProcessing.greenBlock, sensorProcessing.redBlock);
        else
            disp('Green block is not on table')
        end
    end
else
    % Detect green block
    disp('Detecting green block')
    sensorProcessing.DetectGreenBlock(camera);
    
    % Blue block is on the table
    if sensorProcessing.noRedBlock == true && sensorProcessing.noBlueBlock == false
        disp('Red block is not on table')
        if sensorProcessing.noGreenBlock == false
            % Pick up green block
            disp('Pick up green block');
            fetch.PickUpBlock(sensorProcessing.greenBlock);
            % Place green block
            disp('Place green block on blue block');
            fetch.PlaceGrippedBlockOn(sensorProcessing.greenBlock, sensorProcessing.blueBlock);
        else 
            disp('Green block is not on table');
             % -----------FIX UP CENTRE VARIABLES BELOW TO BE CENTRE OF CAM-------------%
            centre.X_base = [0;0;0]; 
            centre.quat = [sqrt(2),0,-sqrt(2),0];
            fetch.PlaceGrippedBlockOn(sensorProcessing.blueBlock, centre);
        end
        
    % Red block is on the table
    elseif sensorProcessing.noBlueBlock == true && sensorProcessing.noRedBlock == false
        disp('Blue block is not on table')
        if sensorProcessing.noGreenBlock == false
            % Pick up green block
            disp('Pick up green block');
            fetch.PickUpBlock(sensorProcessing.greenBlock);
            % Place green block
            disp('Place green block on red block');
            fetch.PlaceGrippedBlockOn(sensorProcessing.greenBlock, sensorProcessing.redBlock);
        else
            disp('Green block is not on table')
             % -----------FIX UP CENTRE VARIABLES BELOW TO BE CENTRE OF CAM-------------%
            centre.X_base = [0;0;0]; 
            centre.quat = [sqrt(2),0,-sqrt(2),0];
            fetch.PlaceGrippedBlockOn(sensorProcessing.redBlock, centre);
        end
    % neither red or blue block is on the table
    else
        disp('Blue block is not on table')
        disp('Red block is not on table')
        if sensorProcessing.noGreenBlock == false
            % Pick up green block
            disp('Pick up green block');
            fetch.PickUpBlock(sensorProcessing.greenBlock);
            % Place green block
            disp('Place green block near middle block');
            
            
            
            % -----------FIX UP CENTRE VARIABLES BELOW TO BE CENTRE OF CAM-------------%
            centre.X_base = [0;0;0]; 
            centre.quat = [sqrt(2),0,-sqrt(2),0];
            fetch.PlaceGrippedBlockOn(sensorProcessing.greenBlock, centre);
            
            
        else
            disp('Green block is not on table')
        end
    end
    
    % -----------INSERT MOVE TO ORIGIN HERE -----------%
    
end

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


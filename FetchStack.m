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

%% Detect Blocks location
disp('Detecting blue block')
sensorProcessing.DetectBlueBlock(camera);
disp('Detecting red block')
sensorProcessing.DetectRedBlock(camera);
disp('Detecting green block')
sensorProcessing.DetectGreenBlock(camera);

%% Logic pending on what blocks are present
% blue and red block present
if sensorProcessing.noBlueBlock == false && sensorProcessing.noRedBlock == false
    % Pick up red block
    disp('Pick up red block')
    fetch.PickUpBlock(sensorProcessing.redBlock)
    % Place red block
    disp('Place red block on blue block');
    fetch.PlaceGrippedBlockOn(sensorProcessing.redBlock, sensorProcessing.blueBlock);
    % green block present
    if sensorProcessing.noGreenBlock == false
        %pick up green block
        disp('Pick up green block');
        fetch.PickUpBlock(sensorProcessing.greenBlock);
        % Place green block
        disp('Place green block on red block');
        finalStack = sensorProcessing.blueBlock;
        finalStack.X_base(3) = finalStack.X_base(3)+0.14;
        fetch.PlaceGrippedBlockOn(sensorProcessing.greenBlock, finalStack);
        disp('Stacking complete');
    % no green block
    else
        disp('Green block is missing')
    end
else
    % blue block is present, red block is missing
    if sensorProcessing.noBlueBlock == false && sensorProcessing.noRedBlock == true
        if sensorProcessing.noGreenBlock = true
            disp('Only blue block is on table')
        else
            disp('Pick up green block');
            fetch.PickUpBlock(sensorProcessing.greenBlock);
            % Place green block
            disp('Place green block on blue block');
            fetch.PlaceGrippedBlockOn(sensorProcessing.greenBlock, sensorProcessing.blueBlock);
            disp('Stacking complete');
        end
        
    % blue block is missing, red block is present
    elseif sensorProcessing.noBlueBlock == true && sensorProcessing.noRedBlock == false
        if sensorProcessing.noGreenBlock = true
            disp('Only red block is on table')
        else
             disp('Pick up green block');
            fetch.PickUpBlock(sensorProcessing.greenBlock);
            % Place green block
            disp('Place green block on red block');
            fetch.PlaceGrippedBlockOn(sensorProcessing.greenBlock, sensorProcessing.redBlock);
            disp('Stacking complete');
        end
    % blue and red blocks are missing
    else
        if sensorProcessing.noGreenBlock = true
            disp('No blocks on table')
        else
            disp('Only green block is on table');
        end
    end
    
end

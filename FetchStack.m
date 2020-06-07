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

% %% Detect blue and red blocks
% disp('Detecting blue block')
% sensorProcessing.DetectBlueBlock(camera);
% disp('Detecting red block')
% sensorProcessing.DetectRedBlock(camera);
% 
% %% Move to pick up block logic
% if sensorProcessing.noBlueBlock == false && sensorProcessing.noRedBlock == false
%     % Pick up red block
%     disp('Pick up red block')
%     fetch.PickUpBlock(sensorProcessing.redBlock)
%     % Place red block
%     disp('Place red block on blue block');
%     fetch.PlaceGrippedBlockOn(sensorProcessing.redBlock, sensorProcessing.blueBlock);
%     
%     % -----------INSERT MOVE TO ORIGIN HERE -----------%
%     
%     % Detect red block
%     disp('Detecting red block')
%     sensorProcessing.DetectRedBlock(camera);
%     if sensorProcessing.noRedBlock == true
%         disp('ERROR: Red block is was misplaced')
%     else
%         % Detect green block
%         disp('Detecting green block')
%         sensorProcessing.DetectGreenBlock(camera);
%         if sensorProcessing.noGreenBlock == false
%             % Pick up green block
%             disp('Pick up green block');
%             fetch.PickUpBlock(sensorProcessing.greenBlock);
%             % Place green block
%             disp('Place green block on red block');
%             fetch.PlaceGrippedBlockOn(sensorProcessing.greenBlock, sensorProcessing.redBlock);
%         else
%             disp('Green block is not on table')
%         end
%     end
% else
%     % Detect green block
%     disp('Detecting green block')
%     sensorProcessing.DetectGreenBlock(camera);
%     
%     % Blue block is on the table
%     if sensorProcessing.noRedBlock == true && sensorProcessing.noBlueBlock == false
%         disp('Red block is not on table')
%         if sensorProcessing.noGreenBlock == false
%             % Pick up green block
%             disp('Pick up green block');
%             fetch.PickUpBlock(sensorProcessing.greenBlock);
%             % Place green block
%             disp('Place green block on blue block');
%             fetch.PlaceGrippedBlockOn(sensorProcessing.greenBlock, sensorProcessing.blueBlock);
%         else 
%             disp('Green block is not on table');
%              % -----------FIX UP CENTRE VARIABLES BELOW TO BE CENTRE OF CAM-------------%
%             centre.X_base = [0;0;0]; 
%             centre.quat = [sqrt(2),0,-sqrt(2),0];
%             fetch.PlaceGrippedBlockOn(sensorProcessing.blueBlock, centre);
%         end
%         
%     % Red block is on the table
%     elseif sensorProcessing.noBlueBlock == true && sensorProcessing.noRedBlock == false
%         disp('Blue block is not on table')
%         if sensorProcessing.noGreenBlock == false
%             % Pick up green block
%             disp('Pick up green block');
%             fetch.PickUpBlock(sensorProcessing.greenBlock);
%             % Place green block
%             disp('Place green block on red block');
%             fetch.PlaceGrippedBlockOn(sensorProcessing.greenBlock, sensorProcessing.redBlock);
%         else
%             disp('Green block is not on table')
%              % -----------FIX UP CENTRE VARIABLES BELOW TO BE CENTRE OF CAM-------------%
%             centre.X_base = [0;0;0]; 
%             centre.quat = [sqrt(2),0,-sqrt(2),0];
%             fetch.PlaceGrippedBlockOn(sensorProcessing.redBlock, centre);
%         end
%     % neither red or blue block is on the table
%     else
%         disp('Blue block is not on table')
%         disp('Red block is not on table')
%         if sensorProcessing.noGreenBlock == false
%             % Pick up green block
%             disp('Pick up green block');
%             fetch.PickUpBlock(sensorProcessing.greenBlock);
%             % Place green block
%             disp('Place green block near middle block');
%             
%             
%             
%             % -----------FIX UP CENTRE VARIABLES BELOW TO BE CENTRE OF CAM-------------%
%             centre.X_base = [0;0;0]; 
%             centre.quat = [sqrt(2),0,-sqrt(2),0];
%             fetch.PlaceGrippedBlockOn(sensorProcessing.greenBlock, centre);
%             
%             
%         else
%             disp('Green block is not on table')
%         end
%     end
%     
%     % -----------INSERT MOVE TO ORIGIN HERE -----------%
%     
% end

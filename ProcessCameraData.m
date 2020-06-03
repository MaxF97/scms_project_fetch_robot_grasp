classdef ProcessCameraData < handle
    properties
        %blockCornerPoints = [];
        blockWidth = 0.06; % dimensions of cube {m}
        %depth = 0;          
        blueBlock;
        noBlueBlock = false; % is a blue block on the table? Assume blue block is present
        redBlock;
        noRedBlock = false; % is a red block on the table? Assume red block is present
        greenBlock;
        noGreenBlock = false; % is a green block on the table? Assume green block is present
    end
    methods
        %% Constructor
        function self = ProcessCameraData()
            % nothing inside constructor
        end
        
        %% Detect Blocks
        function DetectBlueBlock(self, camera)
            % Break RGB image into colour bands
            redBand = camera.rgbImg(:,:,1);
            greenBand = camera.rgbImg(:,:,2);
            blueBand = camera.rgbImg(:,:,3);
            
            % Search for blue points on image 
            % i.e. points with low red and green values
            bluePoints = [];
            counter = 0;
            for i=1:camera.rgbRawSub.LatestMessage.Height
                for j=1:camera.rgbRawSub.LatestMessage.Width
                    if greenBand(i,j) < 10 && redBand(i,j) < 10 && blueBand(i,j) > 80
                        counter = counter+1;
                        bluePoints(counter,:) = [i,j];
                    end
                end
            end
            
            % Find the middle of point of all blue points
            point = [0,0];
            point = round(mean(bluePoints));
            
            % Check if blue block is present on table
            if ~isnan(point)
%                 redBand(point(1),point(2)) = 255;
%                 greenBand(point(1),point(2)) = 0;
%                 blueBand(point(1),point(2)) = 0;
                
                self.blueBlock.u = point(2);
                self.blueBlock.v = point(1);
%                 im = cat(3,redBand,greenBand,blueBand);
%                 figure;
%                 imshow(im);
                
                self.blueBlock.X_cam = self.DetermineBlocksLocation(camera, self.blueBlock.u, self.blueBlock.v);
                self.blueBlock.X_base = self.TransformCameraToBase(self.blueBlock.X_cam);
                self.blueBlock.quat = self.determineBlocksRotation(camera, self.blueBlock.u, self.blueBlock.v);
                
                self.noBlueBlock = false;
            else
                self.noBlueBlock = true;
                self.blueBlock.u = NaN;
                self.blueBlock.v = NaN;
            end
        end
        
        function DetectRedBlock(self, camera)
            % Break RGB image into colour bands
            redBand = camera.rgbImg(:,:,1);
            greenBand = camera.rgbImg(:,:,2);
            blueBand = camera.rgbImg(:,:,3);
            
            % Search for blue points on image
            % i.e. points with low red and green values
            redPoints = [];
            counter = 0;
            for i=1:camera.rgbRawSub.LatestMessage.Height
                for j=1:camera.rgbRawSub.LatestMessage.Width
                    if greenBand(i,j) < 10 && blueBand(i,j) < 10 && redBand(i,j) > 80
                        counter = counter+1;
                        redPoints(counter,:) = [i,j];
                    end
                end
            end
            
            % Find the middle of point of all blue points
            point = [0,0];
            point = round(mean(redPoints));
            
            % Check if blue block is present on table
            if ~isnan(point)  
%                 redBand(point(1),point(2)) = 0;
%                 greenBand(point(1),point(2)) = 0;
%                 blueBand(point(1),point(2)) = 255;
                
                
                self.redBlock.u = point(2);
                self.redBlock.v = point(1);
%                 im = cat(3,redBand,greenBand,blueBand);
%                 figure;
%                 imshow(im);
                
                self.redBlock.X_cam = self.DetermineBlocksLocation(camera, self.redBlock.u, self.redBlock.v);
                self.redBlock.X_base = self.TransformCameraToBase(self.redBlock.X_cam);
                self.redBlock.quat = self.determineBlocksRotation(camera, self.redBlock.u, self.redBlock.v);
                
                self.noRedBlock = false;
            else
                self.noRedBlock = true;
                self.redBlock.u = NaN;
                self.redBlock.v = NaN;
            end
        end
        
         function DetectGreenBlock(self, camera)
            % Break RGB image into colour bands
            redBand = camera.rgbImg(:,:,1);
            greenBand = camera.rgbImg(:,:,2);
            blueBand = camera.rgbImg(:,:,3);
            
            % Search for blue points on image
            % i.e. points with low red and green values
            greenPoints = [];
            counter = 0;
            for i=1:camera.rgbRawSub.LatestMessage.Height
                for j=1:camera.rgbRawSub.LatestMessage.Width
                    if redBand(i,j) < 10 && blueBand(i,j) < 10 && greenBand(i,j) > 80
                        counter = counter+1;
                        greenPoints(counter,:) = [i,j];
                    end
                end
            end
            
            % Find the middle of point of all blue points
            point = [0,0];
            point = round(mean(greenPoints));
            
            % Check if blue block is present on table
            if ~isnan(point) 
%                 redBand(point(1),point(2)) = 0;
%                 redBand(point(1),point(2)) = 255;
%                 greenBand(point(1),point(2)) = 0;
%                 blueBand(point(1),point(2)) = 0;
                
                self.greenBlock.u = point(2);
                self.greenBlock.v = point(1);
%                 im = cat(3,redBand,greenBand,blueBand);
%                 figure;
%                 imshow(im);
                
                self.greenBlock.X_cam = self.DetermineBlocksLocation(camera, self.greenBlock.u, self.greenBlock.v);
                self.greenBlock.X_base = self.TransformCameraToBase(self.greenBlock.X_cam);
                self.greenBlock.quat = self.determineBlocksRotation(camera, self.greenBlock.u, self.greenBlock.v);
                
                self.noGreenBlock = false;
            else
                self.noGreenBlock = true;
                self.greenBlock.u = NaN;
                self.greenBlock.v = NaN;
            end
         end
        
        %% Determine pick up location
        function X_cam = DetermineBlocksLocation(self, camera, u, v)
            % Find Z value of point (add half the size of the block)
            Z = camera.depthImg(v,u)+self.blockWidth/2;
            % Camera intrinsic properties matrix
            K = camera.K;
            % extrinsic properties
            x = [u*Z; ...
                 v*Z; ...
                 Z];
            % Calculate the objects position in the camera's reference frame
            X_cam = inv(K)*x;
        end
        
        %% Transfer point in camera coordinate to base
        function X_base = TransformCameraToBase(self, X_cam)
            tftree = rostf;
            pause(0.5);
            
            node = ros.Node('/Transform/Points/Camera_to_base');
            tftree = ros.TransformationTree(node);
            pause(0.5);
            
            updateTime = tftree.LastUpdateTime;
            waitForTransform(tftree,'base_link','head_camera_rgb_optical_frame',5);

            pointCam = rosmessage('geometry_msgs/PointStamped');
            pointCam.Header.FrameId = 'head_camera_rgb_optical_frame';
            pointCam.Point.X = X_cam(1);
            pointCam.Point.Y = X_cam(2);
            pointCam.Point.Z = X_cam(3);
            
            pointBase = transform(tftree, 'base_link', pointCam);
            X_base = [pointBase.Point.X; ...
                      pointBase.Point.Y; ...
                      pointBase.Point.Z];
                  
            clear('node');
        end
    
        %% Determine the rotation of the block
        function quat = determineBlocksRotation(self, camera, u, v)
            % Depth of image either side of object
            counter = 2;
            dl = camera.depthImg(v,u-counter);
            dr = camera.depthImg(v,u+counter);
            % Height of triangle
            h = dl - dr;
            % Get the y coordinates of at each point either side of centre
            left = self.DetermineBlocksLocation(camera, u-counter, v);
            xl = left(1);
            right = self.DetermineBlocksLocation(camera, u+counter, v);
            xr = right(1);
            % Base of triangle
            b = abs(xr-xl);
            % Angle of object
            theta = atan(h/b);
            
            slope = theta;
            
            
            while (slope > theta - 0.01) && (slope < theta + 0.01)
                counter = counter + 1;
                dl = camera.depthImg(v,u-counter);
                dr = camera.depthImg(v,u+counter);
                
                h = dl - dr;
                
                left = self.DetermineBlocksLocation(camera, u-counter, v);
                xl = left(1);
                right = self.DetermineBlocksLocation(camera, u+counter, v);
                xr = right(1);
                
                b = abs(xr-xl);
                slope = atan(h/b);
            end
            dl = camera.depthImg(v,u-counter+2);
            dr = camera.depthImg(v,u+counter-2);
            
            h = dl - dr;
            
            left = self.DetermineBlocksLocation(camera, u-counter+2, v);
            xl = left(1);
            right = self.DetermineBlocksLocation(camera, u+counter-2, v);
            xr = right(1);
            
            b = abs(xr-xl);
            
            theta = atan(h/b);
            % Convert to quaternium
            quat = eul2quat([theta,-pi/2,0], 'XYZ');
            
        end
%             kern = [0, 1, 0;
%                 1, -4, 1;
%                 0, 1, 0];
%             cameraImage = uint8(conv2(camera.grayImg, kern, 'same')); 
%              %cameraImage = camera.rbgImg;
% % %            
% %             self.blockCornerPoints = detectHarrisFeatures(cameraImage,'MinQuality', 0.2);
% %             imshow(cameraImage);
% %             hold on
% %             plot(self.blockCornerPoints);
% 
%              blockImage = imread('block.jpg');
%              pointsBlock = detectORBFeatures(blockImage);
%              pointsCamera = detectORBFeatures(cameraImage);
%              [featuresBlock, validPointsBlock] = extractFeatures(blockImage, pointsBlock);
%              [featuresCamera, validPointsCamera] = extractFeatures(cameraImage, pointsCamera);
% %              
%              indexPairs = matchFeatures(featuresBlock, featuresCamera);
%              matchedPointsBlock = validPointsBlock(indexPairs(:,1));
%              matchedPointsCamera = validPointsCamera(indexPairs(:,2));
% %              
%              figure(1);
%              showMatchedFeatures(blockImage,cameraImage,matchedPointsBlock,matchedPointsCamera,'montage');
% %              title('Matching Points Using ORB');
% %              
% %              [tform,inlierBlock,inlierCamera] = estimateGeometricTransform(matchedPointsBlock,matchedPointsCamera,'similarity');
% %              
% %              figure(2);
% %              showMatchedFeatures(blockImage,cameraImage,inlierBlock,inlierCamera, 'montage');
% %              title('Matching Points Using ORB and RANSAC (inliers only)');
% %             a=1;
% %             self.DepthOfBlock(camera.depthImg);
% 
%         end
    end
end


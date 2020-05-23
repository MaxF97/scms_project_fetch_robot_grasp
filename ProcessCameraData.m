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
                    if greenBand(i,j) < 10 && redBand(i,j) < 10
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
                redBand(point(1),point(2)) = 255;
                greenBand(point(1),point(2)) = 0;
                blueBand(point(1),point(2)) = 0;
                
                self.blueBlock.u = point(1);
                self.blueBlock.v = point(2);
                im = cat(3,redBand,greenBand,blueBand);
                imshow(im);
                
                self.determineBlocksLocation(camera, self.blueBlock.u, self.blueBlock.v);
                
                self.noBlueBlock = false;
            else
                self.noBlueBlock = true;
                self.blueBlock.u = NaN;
                self.blueBlock.v = NaN;
            end
            

            
            %self.depth = camera.depthImg( self.blueBlock.u, self.blueBlock.v) + self.blockWidth/2;

            
            
            
            
%             kern = [0, 1, 0;
%                 1, -4, 1;
%                 0, 1, 0];
%             cameraImage = uint8(conv2(camera.grayImg, kern, 'same')); 
%              %cameraImage = camera.rbgImg;
% %            
%             self.blockCornerPoints = detectHarrisFeatures(cameraImage,'MinQuality', 0.2);
%             imshow(cameraImage);
%             hold on
%             plot(self.blockCornerPoints);
%              blockImage = imread('block.jpg');
%              pointsBlock = detectORBFeatures(blockImage);
%              pointsCamera = detectORBFeatures(cameraImage);
%              [featuresBlock, validPointsBlock] = extractFeatures(blockImage, pointsBlock);
%              [featuresCamera, validPointsCamera] = extractFeatures(cameraImage, pointsCamera);
%              
%              indexPairs = matchFeatures(featuresBlock, featuresCamera);
%              matchedPointsBlock = validPointsBlock(indexPairs(:,1));
%              matchedPointsCamera = validPointsCamera(indexPairs(:,2));
%              
%              figure(1);
%              showMatchedFeatures(blockImage,cameraImage,matchedPointsBlock,matchedPointsCamera,'montage');
%              title('Matching Points Using ORB');
%              
%              [tform,inlierBlock,inlierCamera] = estimateGeometricTransform(matchedPointsBlock,matchedPointsCamera,'similarity');
%              
%              figure(2);
%              showMatchedFeatures(blockImage,cameraImage,inlierBlock,inlierCamera, 'montage');
%              title('Matching Points Using ORB and RANSAC (inliers only)');
%             a=1;
%             self.DepthOfBlock(camera.depthImg);
            
            % somehow work out how to group the points
            
            % use other function to get the depth of the corner points
        end
        
        %% Determine pick up location
        function determineBlocksLocation(self, camera, u, v) % add rotation into here I think.
            d = camera.depthImg(u,v);
            px = camera.px;
            py = camera.py;
            f = camera.f;
            
            y = py-v;
            x = u-px;
            % i need to find depth on the x,y axis (not the full depth)
%             d^2
%             (1+(f/y)^2)
%             (1+(f/y)^2)^2
%             
%             Y = sqrt((d^2*(1+(f/y)^2)-d^2)/(1+(1+(f/y)^2)^2));
%             
%             X = sqrt((d^2*(1+(f/x)^2)-d^2)/(1+(1+(f/x)^2)^2));
            
            
            self.blueBlock.X = d/sqrt(1+(y/x)^2+(f/x)^2);%sqrt(d^2/(1+(f/(u-px))^2));
            if u < px
                self.blueBlock.X = -self.blueBlock.X;
            end
            self.blueBlock.Y = d/sqrt(1+(x/y)^2+(f/y)^2);%sqrt(d^2/(1+(f/(py-v))^2));
            if v < py
                self.blueBlock.Y = -self.blueBlock.Y;
            end
            self.blueBlock.Z = abs(self.blueBlock.X)*f/x%sqrt(d^2/(1+((py-v)/f)^2));
        end
    end
end


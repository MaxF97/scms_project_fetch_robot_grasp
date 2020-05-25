classdef CameraRGBD < handle
    properties 
        % Sensor subscribers
        rgbRawSub = [];
        depthRawSub = [];
        
        % Sensor images in MATLAB format
        rgbImg = [];
        grayImg = [];
        depthImg = [];

        % Intrinsic Camera paramters obtained from 
        px = 320.5;                 % Principal point x
        py = 240.5;                 % Principal point y
        f = 554.254691191187;       % Focal length
        K = [554.254691191187, 0, 320.5; ...          % Camera Matrix
             0, 554.254691191187, 240.5; ...
             0, 0, 1];
    end
    
    methods
        %% Constructor
        function self = CameraRGBD()
            try rosinit; end
            self.SubscribeROSCamera();
            self.GetCurrentImage();
        end
        
        %% Subscribe to camera Data
        function SubscribeROSCamera(self)
            % subscribe to camera data
            self.rgbRawSub = rossubscriber('/head_camera/rgb/image_raw');
            self.depthRawSub = rossubscriber('/head_camera/depth_registered/image_raw');            
            % Need to pause for 0.5 seconds not really sure why
            pause(0.5);
        end
        
        %% Get the current rgb and depth data from sensors
        function GetCurrentImage(self)                       
            % Store the current images into container in MATLAB format
            self.rgbImg = readImage(self.rgbRawSub.LatestMessage);
            self.grayImg = rgb2gray(self.rgbImg);
            self.depthImg = readImage(self.depthRawSub.LatestMessage);
        end
    end
end


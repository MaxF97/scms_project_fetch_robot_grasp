classdef CameraRGBD < handle
    properties 
        % Sensor subscribers
        rgbRawSub = [];
        depthRawSub = [];
        
        % Sensor images in MATLAB format
        rgbImg = [];
        grayImg = [];
        depthImg = [];
        
        % Intrinsic Camera paramters obtained from performing a camera calibration
        px=319.166862061345000;                         % Principal point X
        py=239.433267282686018;                         % Principal point Y
        f= (553.599234489766104+553.614309214737091)/2; % Focal Length
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
            % Need to pause for 0.5 second to allow data to be collected
            pause(0.5);
        end
        
        %% Get the current rgb and depth data from sensors
        function GetCurrentImage(self)                       
            % Store images into container in MATLAB format
            self.rgbImg = readImage(self.rgbRawSub.LatestMessage);
            self.grayImg = rgb2gray(self.rgbImg);
            self.depthImg = readImage(self.depthRawSub.LatestMessage);
        end
    end
end


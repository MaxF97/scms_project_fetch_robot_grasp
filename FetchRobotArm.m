classdef FetchRobotArm < handle
    properties
        % Sensor subscribers
        q1Pub = [];
        q2Pub = [];
        q3Pub = [];
        q4Pub = [];
        q5Pub = [];
        q6Pub = [];
        q7Pub = [];
        
        gripperLPublisher= [];
        gripperRPublisher= [];
        
        cameraAnglePublisher = [];
        
        q1;
        q2;
        q3;
        q4;
        q5;
        q6;
        q7;
        
        
        gripperL;
        gripperR;
        
        cameraAngle;
    end
    
    methods
        %% Constructor
        function self = FetchRobotArm()
            try rosinit; end
            self.PublishToRobotArm();
            self.Publish();
        end
        
        function PublishToRobotArm = method1(obj,inputArg)
            self.q1Pub = rospublisher('/head_camera/rgb/image_raw');
            % Augustine: publishing to joint topics 1-7
            % Sam: publish to lgripper and Rgripper
            % Max: publsih Camera Angle
        end
    end
end


classdef FetchRobotArm < handle
    properties
        pose;
        poseMsg;
        motionComplete = false;
    end
    
    methods
        %% Constructor
        function self = FetchRobotArm()
            try rosinit; end
            self.PublishToMoveit();
            self.SubscribeToMoveit();
        end
        
        function PublishToMoveit(self)
            [self.pose, self.poseMsg] = rospublisher('Pose', 'geometry_msgs/PoseStamped');
        end
        
        function SubscribeToMoveit(self)
            self.motionComplete = rossubscriber('Check', 'std_msgs/Bool');
        end
        
        function MoveRobotArm(self, block)
            self.poseMsg.Pose.Position.X = block.X_base(1);
            self.poseMsg.Pose.Position.Y = block.X_base(2);
            self.poseMsg.Pose.Position.Z = block.X_base(3);
            
            % Once orientation calc is complete replace with
            self.poseMsg.Pose.Orientation.X = block.quat(1);%sqrt(2); %block.quat(1);
            self.poseMsg.Pose.Orientation.Y = block.quat(2);%0; %block.quat00(2);
            self.poseMsg.Pose.Orientation.Z = block.quat(3);%-sqrt(2); %block.quat(3);
            self.poseMsg.Pose.Orientation.W = block.quat(4);%0; %block.quat(4);
            send(self.pose,self.poseMsg);
        end
    end
end


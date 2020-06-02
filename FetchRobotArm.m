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
            self.msg.poseMsg.Position.X = block.X_Base(1);
            self.msg.poseMsg.Position.Y = block.X_Base(1);
            self.msg.poseMsg.Position.X = block.X_Base(1);
            
            % Once orientation calc is complete replace with
            self.msg.poseMsg.Orientation.X = sqrt(2); %block.quat(1);
            self.msg.poseMsg.Orientation.Y = 0; %block.quat(2);
            self.msg.poseMsg.Orientation.Z = -sqrt(2); %block.quat(3);
            self.msg.poseMsg.Orientation.W = 1; %block.quat(4);
            send(self.pose,self.poseMsg);
        end
    end
end


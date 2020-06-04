classdef FetchRobotArm < handle
    properties
        pose;
        poseMsg;
        motionComplete = false;
        
        gripper;
        gripperMsg;
    end
    
    methods
        %% Constructor
        function self = FetchRobotArm()
            try rosinit; end
            self.PublishToMoveit();
            self.SubscribeToMoveit();
        end
        
        %% Set up Publish Pose to topic
        function PublishToMoveit(self)
            [self.pose, self.poseMsg] = rospublisher('Pose', 'geometry_msgs/PoseStamped');
            pause(0.5);
        end
        
        %% Set up Subribe to see when movement is complete
        function SubscribeToMoveit(self)
            self.motionComplete = rossubscriber('Check', 'std_msgs/Bool');
            pause(0.5);
        end
        
        %% Gripper Publisher
        function PublishToGripper(self)
            [self.gripper, self.gripperMsg] = rospublisher('State', 'std_msgs/Bool'); %
            %[self.changeState, self.changeStateMsg] = rospublisher('MoveToDesiredState', 'std_msgs/Bool');
        end
        
        %% Move Robot Arm to Pose
        function MoveRobotArm(self, block)
            self.poseMsg.Pose.Position.X = block.X_base(1);
            self.poseMsg.Pose.Position.Y = block.X_base(2);
            self.poseMsg.Pose.Position.Z = block.X_base(3);
       
            self.poseMsg.Pose.Orientation.X = block.quat(1);
            self.poseMsg.Pose.Orientation.Y = block.quat(2);
            self.poseMsg.Pose.Orientation.Z = block.quat(3);
            self.poseMsg.Pose.Orientation.W = block.quat(4);
            send(self.pose,self.poseMsg);
            
            % should I put something in here to wait till it is complete?
            disp('Waiting for motion to be complete');
            pause(1);
            while self.motionComplete.LatestMessage == 0
            end
        end
        
        %% Pick up block
        function PickUpBlock(self, block)
            waypoint = block;
            waypoint.X_base(3) = waypoint.X_base(3) + 0.16;
            self.MoveRobotArm(waypoint);
            keyboard;
            self.MoveRobotArm(block);
            % close gripper code goes here
        end
        
        %% Place the block
        function PlaceTheBlock(self, pose)
            waypoint = pose;
            waypoint.X_base(3) = waypoint.X_base(3) + 0.16;
            self.MoveRobotArm(waypoint);
            keyboard;
            self.MoveRobotArm(pose);
            % Open gripper code goes here
        end
        %% Return arm to Origin
        function MoveArmToOrigin(self)
            origin.X_base = [0;0;0];
            origin.quat = [0,0,0,0];
            self.MoveRobotArm(origin);
        end
    end
end


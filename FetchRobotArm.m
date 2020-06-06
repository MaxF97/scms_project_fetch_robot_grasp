classdef FetchRobotArm < handle
    properties
        pose;
        poseMsg;
        motionComplete;
        
        gripComplete;
        originComplete
        
        gripper;
        gripperMsg;
        
        moveOrigin;
        moveOriginMsg;
    end
    
    methods
        %% Constructor
        function self = FetchRobotArm()
            try rosinit; end
            self.PublishToMoveit();
            self.PublishToGripper();
            self.SubscribeToMoveit();
            self.PublishToOrigin();
            pause(1);
        end
        
        %% Set up Publish Pose to topic
        function PublishToMoveit(self)
            [self.pose, self.poseMsg] = rospublisher('Pose', 'geometry_msgs/PoseStamped');
        end
        
        %% Set up Subribe to see when movement is complete
        function SubscribeToMoveit(self)
            self.motionComplete = rossubscriber('Check', 'std_msgs/Bool');
            self.gripComplete = rossubscriber('GripCheck', 'std_msgs/Bool');
            self.originComplete = rossubscriber('OriginCheck', 'std_msgs/Bool');
        end
        
        %% Gripper Publisher
        function PublishToGripper(self)
            [self.gripper, self.gripperMsg] = rospublisher('State', 'std_msgs/Bool');
        end
        
        %% Move to Origin publisher
        function PublishToOrigin(self)
            [self.moveOrigin, self.moveOriginMsg] = rospublisher('MoveToOrigin', 'std_msgs/Bool'); 
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
            pause(1);
            send(self.pose,self.poseMsg);
            
            disp('Waiting for motion to be complete');
            pause(0.5);
            while self.motionComplete.LatestMessage.Data == 0 
            end
        end
        
        %% Grip block
        function GripReleaseBlock(self, grip) % grip = true means grip, grip = false means open
            self.gripperMsg.Data = grip;
            pause(1);
            send(self.gripper, self.gripperMsg);
            
            disp('Waiting for gripper to finish');
            pause(0.5);
            while self.gripComplete.LatestMessage.Data == 0 
            end
        end
        
        %% Pick up block
        function PickUpBlock(self, block)
            waypoint = block;
            waypoint.X_base(3) = waypoint.X_base(3) + 0.16;
            self.MoveRobotArm(waypoint);
            self.MoveRobotArm(block);
            self.GripReleaseBlock(true);
        end
        
        %% Place the block
        function PlaceGrippedBlockOn(self, grippedBlock, baseBlock)
            % Create waypoint straight up from curent block
            waypoint = grippedBlock;
            waypoint.X_base(3) = grippedBlock.X_base(3) + 0.16;
            %keyboard;
            self.MoveRobotArm(waypoint);
            
            % Create goal pose just above block
            goalPose = self.CalcPoseAboveBlock(baseBlock);
            % Create waypoint just above goal pose
            waypoint = goalPose;
            waypoint.X_base(3) = waypoint.X_base(3) + 0.16;
            
            %keyboard;
            self.MoveRobotArm(waypoint);
            %keyboard;
            self.MoveRobotArm(goalPose);
            %keyboard;
            self.GripReleaseBlock(false);
            
            % Move just above placed block
            self.MoveRobotArm(waypoint);
        end
        %% Return arm to Origin
        function MoveArmToOrigin(self)
            self.moveOriginMsg.Data = true;
            send(self.moveOrigin, self.moveOriginMsg);
            
            disp('Waiting fetch to move to origin');
            while self.originComplete.LatestMessage.Data == 0
            end
            self.moveOriginMsg.Data = false;
            send(self.moveOrigin, self.moveOriginMsg);
        end
        
        %% Calculate point to place block above 
        function dropOffPose = CalcPoseAboveBlock(self, baseBlock)
            dropOffPose = baseBlock;
            dropOffPose.X_base(3) = dropOffPose.X_base(3) + 0.07;
        end
    end
end
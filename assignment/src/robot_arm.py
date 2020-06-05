import copy
import actionlib
import rospy

#Import the interface in Moveit package
from moveit_python import MoveGroupInterface, PlanningSceneInterface
from moveit_msgs.msg import MoveItErrorCodes
from geometry_msgs.msg import PoseStamped

class RobotArm:
    def __init__(self):
        self.moveGroup = MoveGroupInterface("arm_with_torso", "base_link")
        self.planning_scene = PlanningSceneInterface("base_link")
        self.planning_scene.addCube("my_front_ground", 2, 1.1, 0.0, -1.0)
        self.planning_scene.addCube("my_back_ground", 2, -1.2, 0.0, -1.0)
        self.planning_scene.addCube("my_left_ground", 2, 0.0, 1.2, -1.0)
        self.planning_scene.addCube("my_right_ground", 2, 0.0, -1.2, -1.0)
        self.planning_scene.removeCollisionObject("my_front_ground")
        self.planning_scene.removeCollisionObject("my_back_ground")
        self.planning_scene.removeCollisionObject("my_right_ground")
        self.planning_scene.removeCollisionObject("my_left_ground")
        self.planning_scene.removeCollisionObject("table1")
        

    def MoveToPose(self,X,Y,Z,x,y,z,w):
        self.poseStamped = PoseStamped()
        self.poseStamped.header.frame_id = 'base_link'
        self.poseStamped.header.stamp = rospy.Time.now()

        self.poseStamped.pose.position.x = X
        self.poseStamped.pose.position.y = Y 
        self.poseStamped.pose.position.z = Z
        
        self.poseStamped.pose.orientation.x = x
        self.poseStamped.pose.orientation.y = y
        self.poseStamped.pose.orientation.z = z
        self.poseStamped.pose.orientation.w = w

        self.moveGroup.moveToPose(self.poseStamped, 'gripper_link')
        self.result = self.moveGroup.get_move_action().get_result()

    def OriginReturn(self,X,Y,Z,x,y,z,w):
        #First Move to Above Block
        self.poseStamped = PoseStamped()
        self.poseStamped.header.frame_id = 'base_link'
        self.poseStamped.header.stamp = rospy.Time.now()

        self.poseStamped.pose.position.x = X
        self.poseStamped.pose.position.y = Y 
        self.poseStamped.pose.position.z = Z + 0.2
        
        self.poseStamped.pose.orientation.x = x
        self.poseStamped.pose.orientation.y = y
        self.poseStamped.pose.orientation.z = z
        self.poseStamped.pose.orientation.w = w

        self.moveGroup.moveToPose(self.poseStamped, 'gripper_link')
        self.result = self.moveGroup.get_move_action().get_result()    

    def OriginPart2(self,X,Y,Z,x,y,z,w):
        self.poseStamped = PoseStamped()
        self.poseStamped.header.frame_id = 'base_link'
        self.poseStamped.header.stamp = rospy.Time.now()

        self.poseStamped.pose.position.x = 0.35
        self.poseStamped.pose.position.y = 0.37
        self.poseStamped.pose.position.z = Z + 0.2
        
        self.poseStamped.pose.orientation.x = x
        self.poseStamped.pose.orientation.y = y
        self.poseStamped.pose.orientation.z = z
        self.poseStamped.pose.orientation.w = w

        self.moveGroup.moveToPose(self.poseStamped, 'gripper_link')
        self.result = self.moveGroup.get_move_action().get_result() 

    def OriginPart3(self,X,Y,Z,x,y,z,w):
        self.poseStamped = PoseStamped()
        self.poseStamped.header.frame_id = 'base_link'
        self.poseStamped.header.stamp = rospy.Time.now()

        self.poseStamped.pose.position.x = 0.35
        self.poseStamped.pose.position.y = 0.37
        self.poseStamped.pose.position.z = 0.55
        
        self.poseStamped.pose.orientation.x = x
        self.poseStamped.pose.orientation.y = y
        self.poseStamped.pose.orientation.z = z
        self.poseStamped.pose.orientation.w = w

        self.moveGroup.moveToPose(self.poseStamped, 'gripper_link')
        self.result = self.moveGroup.get_move_action().get_result()    

    def CheckGoal(self):
        if self.result:
            if self.result.error_code.val == MoveItErrorCodes.SUCCESS:
                return 1
            else:
                return 2
        else:
            return 0

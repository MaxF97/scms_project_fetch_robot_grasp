import copy
import actionlib
import rospy
import math

from environments import Environments

from moveit_python import MoveGroupInterface
from moveit_msgs.msg import PlaceLocation, MoveItErrorCodes

if __name__ == '__main__':
    rospy.init_node("fetch_builder")
    build = Environments()
    move_group = MoveGroupInterface("arm", "base_link") 
    while not rospy.is_shutdown():
        joints = ["shoulder_pan_joint", "shoulder_lift_joint", "upperarm_roll_joint", "elbow_flex_joint", "forearm_roll_joint", "wrist_flex_joint", "wrist_roll_joint"]
        pose1 = [1.32, 0.7, 0.0, -2.0, 0.0, -0.57, 0.0]
        result = move_group.moveToJointPosition(joints, pose1, 0.01)
        pose2 = [0.7, -0.3, 0.0, -0.3, 0.0, -0.57, 0.0]
        result = move_group.moveToJointPosition(joints, pose2, 0.01)
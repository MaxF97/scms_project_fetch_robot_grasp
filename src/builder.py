#!/usr/bin/env python

#note 
#import tf 

import rospy

from robot_arm import RobotArm
from ROSInterface import ROSInterface
from geometry_msgs.msg import Pose


if __name__ == "__main__":
    # Create a node
    rospy.init_node("fetch_builder",anonymous=True)

    # Setup clients
    Ros = ROSInterface()
    Arm = RobotArm()
    Ros.Subscriber()
    while not rospy.is_shutdown():
        while 1:
            Arm.MoveToPose(Ros.x, Ros.y, Ros.z, Ros.a, Ros.b, Ros.c, Ros.d)
            if Arm.CheckGoal() == 1:
                break
        
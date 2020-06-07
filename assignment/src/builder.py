#!/usr/bin/env python 

import rospy
import time

from robot_arm import RobotArm
from ROSInterface import ROSInterface
from gripper import Gripper
from headController import FetchHeadController
from gripInterface import GripInterface
from originInterface import OriginInterface
counter = 0
publisher_counter=0



if __name__ == "__main__":
    # Setup clients
    Ros = ROSInterface()
    Arm = RobotArm()
    GripRos = GripInterface()
    GripHand = Gripper()
    HeadTilt = FetchHeadController()
    OriginROS = OriginInterface()
    HeadTilt.look_at(0.7, 0, 0.7, "base_link")
    print("Yes I looked")
    
    while 1:
        try:
            Ros.Subscriber()
            GripRos.GripSubscriber()
            break
        except:
            rospy.loginfo('waiting for matlab')
            print(counter)

    
    while not rospy.is_shutdown():
        Ros.PPublisher()
        GripRos.GripPublisher()
        
        if(GripRos.grip_callback == 1):
            GripHand.GripChoose(GripRos.grip_state)
            GripRos.GetGripCheck(1)
            GripRos.grip_callback = 0

        if (Ros.callback == 1):
            Arm.MoveToPose(Ros.x, Ros.y, Ros.z, Ros.a, Ros.b, Ros.c, Ros.d)
            Ros.GetCheck(1)
            Ros.callback = 0

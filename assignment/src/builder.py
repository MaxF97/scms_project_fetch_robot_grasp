#!/usr/bin/env python 

import rospy

from robot_arm import RobotArm
from ROSInterface import ROSInterface
from gripper import Gripper
counter = 0



if __name__ == "__main__":
    # Setup clients
    Ros = ROSInterface()
    Arm = RobotArm()
    GripHand = Gripper()
    grip_state = 0
    while 1:
        try:
            Ros.Subscriber()
            break
        except:
            rospy.loginfo('waiting for matlab')
            print(counter)

    
    while not rospy.is_shutdown():
        try:
            Ros.Publisher()
        except rospy.ROSInterruptException:
            pass
        if (Ros.callback == 1):
            Arm.MoveToPose(Ros.x, Ros.y, Ros.z, Ros.a, Ros.b, Ros.c, Ros.d)
            if Arm.CheckGoal() == 1:
                Ros.GetCheck(1)
                Ros.callback = 0
                grip_state = 1
                counter+=1
                print(counter)
            else:
                Ros.GetCheck(0)
        if(counter == 2):
            GripHand.GripClose()
            GripHand.GripOpen()
            counter+=1
        if(counter == 1):
            print(counter)
        if(counter == 2):
            print(counter)
            print("yes")
        
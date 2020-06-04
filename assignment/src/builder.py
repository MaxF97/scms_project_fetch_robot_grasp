#!/usr/bin/env python 

import rospy

from robot_arm import RobotArm
from ROSInterface import ROSInterface



if __name__ == "__main__":
    # Setup clients
    Ros = ROSInterface()
    Arm = RobotArm()
    while 1:
        try:
            Ros.Subscriber()
            break
        except:
            rospy.loginfo('waiting for matlab')

    
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
            else:
                Ros.GetCheck(0)
        
#!/usr/bin/env python 

import rospy

from robot_arm import RobotArm
from ROSInterface import ROSInterface



if __name__ == "__main__":
    # Create a node
    rospy.init_node("fetch_builder",anonymous=True)

    # Setup clients
    Ros = ROSInterface()
    while 1:
        try:
            Ros.Subscriber()
            break
        except:
            rospy.loginfo('waiting for matlab')

    Arm = RobotArm()

    while not rospy.is_shutdown():
        if (Ros.callback == 1):
            Arm.MoveToPose(Ros.x, Ros.y, Ros.z, Ros.a, Ros.b, Ros.c, Ros.d)
            if Arm.CheckGoal() == 1:
                try:
                    Ros.Publisher(1)
                except rospy.ROSInterruptException:
                    pass
                Ros.callback = 0
            else:
                try:
                    Ros.Publisher(0)
                except rospy.ROSInterruptException:
                    pass
        
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
            #GripHand.GripOpen()
            counter+=1
        if(counter == 3):
            #print(counter)
            print("yes")
            Arm.MoveToPose(Ros.x, Ros.y, (Ros.z+0.2), Ros.a, Ros.b, Ros.c, Ros.d)
            counter+=1
        if(counter == 4):
            print("hahha")
            Arm.MoveToPose(0.35, 0.37, (0.2+Ros.z), Ros.a, Ros.b, Ros.c, Ros.d)
            counter+=1

        if(counter == 5):
            print ("oh no")
            Arm.MoveToPose(0.35, 0.37, 0.3, Ros.a, Ros.b, Ros.c, Ros.d)
            counter+=1
            #Stop here to test Camera
            #Needs to go Down and then up again
        if(counter == 6):
            print("yesterday Today")
            Arm.MoveToPose(0.35, 0.37, Ros.z, Ros.a, Ros.b, Ros.c, Ros.d)
            counter+=1
        if(counter == 7):
            print("I'm Tired")
            Arm.MoveToPose(0.708, -0.026, 0.9, Ros.a, Ros.b, Ros.c, Ros.d)
            counter+=1
        if(counter ==8):
            print("Drop the Cube")
            GripHand.GripOpen()
            counter +=1





        
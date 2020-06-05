#!/usr/bin/env python 

import rospy

from robot_arm import RobotArm
from ROSInterface import ROSInterface
from gripper import Gripper
from headController import FetchHeadController
counter = 0
publisher_counter=0



if __name__ == "__main__":
    # Setup clients
    Ros = ROSInterface()
    Arm = RobotArm()
    GripHand = Gripper()
    HeadTilt = FetchHeadController()
    HeadTilt.look_at(1.23, 0, 0, "frame")
    print("Yes I looked")
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
            print(publisher_counter)
            publisher_counter+=1
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
        if(grip_state ==1 ):
            GripHand.GripClose
        if(grip_state ==2):
            GripHand.GripOpen    
        if(counter == 2):
            print("Close Grip")
            GripHand.GripClose()
            counter+=1
            #grip_state = 1
        if(counter == 3):
            print("Begin Origin Return Process")
            print("Move Up Slightly")
            Arm.MoveToPose(Ros.x, Ros.y, (Ros.z+0.2), Ros.a, Ros.b, Ros.c, Ros.d)
            print("Move to Side to Avoid Collision")
            Arm.MoveToPose(0.35, 0.37, (0.2+Ros.z), Ros.a, Ros.b, Ros.c, Ros.d)
            print("Move Down Slightly")
            Arm.MoveToPose(0.35, 0.37, (1), Ros.a, Ros.b, Ros.c, Ros.d)
            counter+=1
        if(counter ==4):
            print("Return to Origin Pose")
            Arm.OriginReturn()
            counter+=1
        if(counter == 5):
            #Test Can Find Blue Block?
            print("Move to Approximate Above Blue Block Position")
            #Approximate Blue Block Position
            Arm.MoveToPose(0.708, -0.026, 0.88, Ros.a, Ros.b, Ros.c, Ros.d)
            print("Drop the Cube")
            GripHand.GripOpen()   
            counter+=1         
        if(counter == 6):
            print("Begin Origin Return Process")
            #print("Move Up Slightly")
            Arm.MoveToPose(0.708, -0.026, 1.1, Ros.a, Ros.b, Ros.c, Ros.d)
            print("Move to Side to Avoid Collision")
            Arm.MoveToPose(0.35, 0.37, (0.2+Ros.z), Ros.a, Ros.b, Ros.c, Ros.d)
            print("Return to Origin Pose")
            Arm.OriginReturn()
            counter+=1
        if(counter == 7):
            print("Can Detect Green Block??")






        
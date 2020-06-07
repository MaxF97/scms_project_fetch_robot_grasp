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
    temp_count = 0
    origin_counter = 0
    while 1:
        try:
            Ros.Subscriber()
            #GripRos.GripSubscriber()
            break
        except:
            rospy.loginfo('waiting for matlab')
            print(counter)

    
    while not rospy.is_shutdown():
        try:
            Ros.PPublisher()
            Ros.GetCheck(0)
            Ros.PPublisher()
            #GripRos.GripPublisher()
            #print("Pub Counter is", publisher_counter)
            #print("Ros Callback is", Ros.callback)
            publisher_counter+=1
        except rospy.ROSInterruptException:
            pass


        """
        if(GripRos.grip_callback == 1):
            print("Is Gripping. Also Grip State is")
            #print(GripRos.grip_state)
            #Potentially include CheckGoal for Gripper using stalled value for gripper
            GripHand.GripChoose(GripRos.grip_state)
            if (GripHand.grip_complete==1):
                GripRos.GetGripCheck(1)
                GripRos.grip_callback = 0
                GripHand.grip_complete = 0
            else:
                GripRos.GetGripCheck(0)
        """
        
        if (Ros.callback == 1):
            print("Arm willl move")
            Arm.MoveToPose(Ros.x, Ros.y, Ros.z, Ros.a, Ros.b, Ros.c, Ros.d)
            print("Arm has moved")
            if Arm.CheckGoal() == 1:
                print("Check Goal was 1")
                Ros.GetCheck(1)
                Ros.callback = 0
                #counter+=1
                #print(counter)
            else:
                Ros.GetCheck(0)
                print(" check goal was not 1")

        """
        if (OriginROS.origin_callback == 1):
            if(origin_counter >=2):
                print("Origin Return Process")
                #Yet to finish
                #if(temp_count ==2):
                print("Begin Origin Return Process")
                print("Move Up Slightly")
                Arm.MoveToPose(Ros.x, Ros.y, (Ros.z+0.2), Ros.a, Ros.b, Ros.c, Ros.d)
                print("Move to Side to Avoid Collision")
                Arm.MoveToPose(0.35, 0.37, (0.2+Ros.z), Ros.a, Ros.b, Ros.c, Ros.d)
                print("Move Down Slightly")
                Arm.MoveToPose(0.35, 0.37, (1), Ros.a, Ros.b, Ros.c, Ros.d)
                print("Return to Origin Pose")
                time.sleep(1)
                Arm.OriginReturn()
                time.sleep(1)
                OriginROS.OriginCheck(1)
                OriginROS.origin_callback = 0   
                origin_counter = 0
                #temp_count = 0
            else:
                origin_counter+=1
        """
        """if(counter == 2):
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
            print("Can Detect Green Block??")"""


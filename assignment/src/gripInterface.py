#!/usr/bin/env python

import rospy
from std_msgs.msg import Bool
#message type for matlab 
#from robot_arm import RobotArm

class GripInterface:
    def __init__(self):
        #rospy.init_node("grip_builder",anonymous=True)
        # Variables for endeffector pose
        self.grip_state = False
        #callback function runs => =1
        self.grip_callback = 0
        #Check the arm reach the goal 
        self.grip_check = 0
        #Publisher
        self.grip_pub = rospy.Publisher('GripCheck', Bool, queue_size=10)
        self.rate = rospy.Rate(10)
        
    def GripCallback(self,data):
        self.grip_state = data.data
        self.grip_callback = 1
        rospy.loginfo(rospy.get_caller_id() + "%r",self.grip_state)


    def GripSubscriber(self):
        rospy.Subscriber("State",Bool, self.GripCallback)

    def GripPublisher(self):


        self.grip_pub.publish(self.grip_check)
        self.rate.sleep()


    def GetGripCheck(self, grip_check):
        self.grip_check = grip_check


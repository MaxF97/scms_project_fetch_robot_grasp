#!/usr/bin/env python

import rospy
from geometry_msgs.msg import PoseStamped
from std_msgs.msg import Bool
#message type for matlab 
#from robot_arm import RobotArm

class ROSInterface:
    def __init__(self):
        rospy.init_node("fetch_builder",anonymous=True)
        # Variables for endeffector pose
        self.x = None
        self.y = None
        self.z = None
        self.a = None
        self.b = None
        self.c = None
        self.d = None
        #callback function runs => =1
        self.callback = 0
        #Check the arm reach the goal 
        self.check = 0
        #Publisher
        self.pub = rospy.Publisher('Check', Bool , queue_size = 10)
        self.rate = rospy.Rate(10) # 10hz

    def Callback(self,data):
        self.x = data.pose.position.x
        self.y = data.pose.position.y
        self.z = data.pose.position.z
        self.a = data.pose.orientation.x
        self.b = data.pose.orientation.y
        self.c = data.pose.orientation.z
        self.d = data.pose.orientation.w

        self.callback = 1
        rospy.loginfo(rospy.get_caller_id() + "%f %f %f %f %f %f %f", self.x,self.y,self.z,self.a,self.b,self.c,self.d)
    
    def Subscriber(self):
        rospy.Subscriber("Pose", PoseStamped, self.Callback)
        
    def Publisher(self):
        self.pub.publish(self.check)
        self.rate.sleep()

    def GetCheck(self,check):
        self.check = check


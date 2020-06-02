#!/usr/bin/env python

import rospy
from geometry_msgs.msg import PoseStamped
from std_msgs.msg import Bool
#message type for matlab 
#from robot_arm import RobotArm

class ROSInterface:
    def __init__(self):
        self.x = None
        self.y = None
        self.z = None
        self.a = None
        self.b = None
        self.c = None
        self.d = None
        self.pub = rospy.Publisher('Check', Bool,queue_size = 10)
        self.rate = rospy.Rate(10) # 10hz

    def Callback(self,data):
        self.x = data.pose.position.x
        self.y = data.pose.position.y
        self.z = data.pose.position.z
        self.a = data.pose.orientation.x
        self.b = data.pose.orientation.y
        self.c = data.pose.orientation.z
        self.d = data.pose.orientation.w
        rospy.loginfo(rospy.get_caller_id() + "%f %f %f %f %f %f %F", self.x,self.y,self.z,self.a,self.b,self.c,self.d)
    
    def Subscriber(self):
        rospy.Subscriber("Pose", PoseStamped, self.Callback)
        
    def Publisher(self,check):
        self.pub.publish(check)
        self.rate.sleep()


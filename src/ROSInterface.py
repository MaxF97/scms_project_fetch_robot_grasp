#!/usr/bin/env python

import rospy
from geometry_msgs.msg import Pose
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

    def Callback(self,data):
        self.x = data.position.x
        self.y = data.position.y
        self.z = data.position.z
        self.a = data.orientation.x
        self.b = data.orientation.y
        self.c = data.orientation.z
        self.d = data.orientation.w
        rospy.loginfo(rospy.get_caller_id() + "%f %f %f %f %f %f %F", self.x,self.y,self.z,self.a,self.b,self.c,self.d)
    
    def Subscriber(self):
        rospy.Subscriber("Pose", Pose, self.Callback)
        

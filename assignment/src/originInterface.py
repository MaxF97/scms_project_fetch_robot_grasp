#!/usr/bin/env python

import rospy
from std_msgs.msg import Bool

class OriginInterface:
    def __init__(self):
        self.origin_state = False
        self.origin_callback = 0
        self.origin_check = 0
        self.origin_pub = rospy.Publisher('OriginCheck', Bool, queue_size = 10)
        self.rate = rospy.Rate(10)

        
    def OriginCallback(self,data):
        self.origin_state = data.data
        self.origin_callback = 1
        rospy.loginfo(rospy.get_caller_id() + "%r", self.origin_state)

    def OriginSubscriber(self):
        rospy.Subscriber("MoveToOrigin", Bool, self.OriginCallback)

    def OriginPublisher(self):
        self.origin_pub.publish(self.origin_check)
        self.rate.sleep()

    def OriginCheck(self, origin_check):
        self.origin_check = origin_check
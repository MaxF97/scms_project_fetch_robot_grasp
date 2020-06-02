#!/usr/bin/env python

import actionlib
import rospy

from control_msgs.msg import PointHeadAction, PointHeadGoal

class RobotHead(object):
    def RobotHead(self):
        self.client = actionlib.SimpleActionClient("head_controller/point_head", PointHeadAction)
        self.client.wait_for_server()

    def Look(self, x, y, z, frame, duration = 2):
        goal = PointHeadGoal()
        goal.target.header.frame_id = frame
        goal.target.point.x = x
        goal.target.point.y = y
        goal.target.point.z = z
        goal.min_duration = rospy.Duration(duration)
        self.client.send_goal(goal)
        self.client.wait_for_result()

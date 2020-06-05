
import rospy

import actionlib
import control_msgs.msg
import sys
import time

ACTION_SERVER = 'gripper_controller/gripper_action'
class Gripper:
    def __init__(self):
        #effort_min = 30
        #effort_max = 100
        self._client = actionlib.SimpleActionClient(ACTION_SERVER, control_msgs.msg.GripperCommandAction)
        #self._results = actionlib.SimpleActionClient(ACTION_SERVER, control_msgs.msg.GripperCommandResult)
        self._client.wait_for_server(rospy.Duration(10))
        #goal = actionlib.msg.TestActionGoal.

    def GripOpen(self):
        goal = control_msgs.msg.GripperCommandGoal()
        goal.command.position = 0.10
        self._client.send_goal_and_wait(goal, rospy.Duration(10))


    def GripClose(self):
        effort_max = 150
        
        goal = control_msgs.msg.GripperCommandGoal()
        goal.command.max_effort = effort_max
        self._client.send_goal_and_wait(goal, rospy.Duration(1))
    
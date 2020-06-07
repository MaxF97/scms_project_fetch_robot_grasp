
import rospy

import actionlib
import control_msgs.msg
import sys
import time
from moveit_msgs.msg import MoveItErrorCodes

ACTION_SERVER = 'gripper_controller/gripper_action'
class Gripper:
    def __init__(self):
        #effort_min = 30
        #effort_max = 100
        self.grip_complete = 0
        self._client = actionlib.SimpleActionClient(ACTION_SERVER, control_msgs.msg.GripperCommandAction)
        self._client.wait_for_server()


    def GripChoose(self, grip_goal):
        #Assume grip_goal == true to be close and false to be open
        if (grip_goal == True):
            effort_max = 150
            goal = control_msgs.msg.GripperCommandGoal()
            goal.command.max_effort = effort_max
            self._client.send_goal(goal)
            self._client.wait_for_result()
            self.result = self._client.get_result()

        if(grip_goal == False):
            goal = control_msgs.msg.GripperCommandGoal()
            goal.command.position = 0.10
            self._client.send_goal(goal)
            self._client.wait_for_result()
            self.result = self._client.get_result()




    
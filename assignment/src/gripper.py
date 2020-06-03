import copy
import actionlib
import rospy

from moveit_python import PickPlaceInterface
from moveit_msgs.msg import Grasp, PlaceLocation


#rospy.init_node("moveit_py")

#p = PickPlaceInterface("arm", "gripper")

#g = Grasp()

#p.pickup("object_name", [g, ], support_name = "supporting_surface")

#l = PlaceLocation()

#p.place("object_name" [1, ], goal_is_eef = True, support_name = "supporting_surface")


class Gripper:
    def __init__(self):
        picker = PickPlaceInterface("GripArm", "Gripper")
        self.grasp = Grasp()
        self.grasp.id = "grasper"
        #self.grasp.grasp_quality 2
        self.grasp.max_contact_force 100
        self.grasp.allowed_touch_objects ["Cube1", "Cube2", "Cube3"]
        #self.grasp.

    def CloseGrip(self):
        self.picker.pickup("Gripper", [self.grasp,], support_name = "table_surface")

    def OpenGrip():




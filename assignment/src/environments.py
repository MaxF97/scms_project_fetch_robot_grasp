import actionlib
import rospy

from moveit_python import PlanningSceneInterface
from grasping_msgs.msg import FindGraspableObjectsAction, FindGraspableObjectsGoal

class Environments(object):
    def Environments(self):
        self.scene = PlanningSceneInterface("base_link")
        self.scene.clear()
        self.scene.addCube(self,'Cube1', 0.05, 0.8, 0.1, 0.723687, use_service=True)
        self.scene.addCube(self,'Cube2', 0.05, 0.8, -0.15, 0.723687, use_service=True)
        self.scene.addCube(self,'Cube3', 0.05, 1.3, 0, 0.723687, use_service=True)
        self.scene.setColor(self, 'Cube1', 255, 0, 0, a=0.9)
        self.scene.setColor(self, 'Cube2', 0, 255, 0, a=0.9)
        self.scene.setColor(self, 'Cube3', 0, 0, 255, a=0.9)
        self.scene.sendColors()
    
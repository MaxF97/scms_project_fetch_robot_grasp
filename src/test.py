import rospy

def callback(data):
    rospy.loginfo("%f", data.position.x)

def listener():
    rospy.Subscriber("Pose", Pose, callback)
    rospy.spin()

if __name__ == '__main__':
    rospy.init_node('Fetch_builder', anonymous=True)
    listener()


import rospy

from geometry_msgs.msg import PoseStamped
from robot_arm import RobotArm
from ROSInterface import ROSInterface

from geometry_msgs.msg import Pose

if __name__ == "__main__":
    # Create a node
    #rospy.init_node("fetch_builder",anonymous=True)

    # Setup clients
    Ros = ROSInterface()
    #Arm = RobotArm()

    while not rospy.is_shutdown():
        Ros.Subscriber()
        rospy.loginfo(rospy.get_caller_id() + "I heard %f", Ros.x)
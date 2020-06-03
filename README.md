# Sensors and Control for Mechatronic Systems
# Project: Fetch Robot Grasping
This project will grasp and stack blocks using the fetch robot

# 1. Required packages
the following packages are required to run this code.
- fetch_ros https://github.com/fetchrobotics/fetch_ros
- movit_python https://github.com/mikeferguson/moveit_python

These can be found in the attached links. To get these packages use:

     cd ~/catkin_ws/src
     git clone https://github.com/fetchrobotics/fetch_ros

     cd ~/catkin_ws/src
     git clone https://github.com/mikeferguson/moveit_python

# 2. Setup Gazebo Enivronment Launch File
The files located in the 'environment' folder of this repository need to be located in the following places:

A3_environment.launch
must be saved in: 
~/catkin_ws/src/fetch_gazebo/fetch_gazebo/launch

A3_world.sdf
must be saved in: 
~/catkin_ws/src/fetch_gazebo/fetch_gazebo/worlds

# 3. Save Python Files Correctly
The folder in this repository called 'assignment' must be saved in the following location:
~/catkin_ws/src

# 4. To run program
4.1. Open the gazebo environment by typing the following into the terminal:

     roslaunch fetch_gazebo A3_environment.launch
4.2. Start moveit
     
     roslaunch fetch_moveit_config move_group.launch
4.3. Start running the python script by typing the following into a new terminal:

     rosrun assignment builder.py
4.4.  Start the program by running the MATLAB script 'FetchStack.m'

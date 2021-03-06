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


# Program & Video Code Contributions:



|Contributions                          |Dinh Dang Khoa Le |MaxFarmer | Samuel Gallagher | 
|---------------------------------------|------------------|----------|------------------|
|Environmental Setup and Configuration  |0%                |0%        |100%              |
|Sense Blocks position & Orientation    |0%                |100%      |0%                |
|Matlab ROS Publishing and Subscribing  |20%               |60%       |20%               |    
|Python ROS Publishing and Subscribing  |80%               |0%        |20%               |
|Arm Movement                           |75%               |5%(Matlab)|20%               |
|Arm Gripping                           |5%                |5%(Matlab)|90%               |
|Program Logic                          |10%               |70%       |20%               |
|Program Testing                        |33.3%             |33.3%     |33.3%             |
|Video Filing                           |50%               |0%        |50%               |
|Video Editing                          |5%                |90%       |5%                | 
|Overall Contributions                  |33.3%             |33.3%     |33.3%             |



# Video Description:
This video demonstrates what we achieved. It shows the robot sensing each block, then moving the arm to pick up and stack the blocks. The blue block on the bottom, then red, then green.

link to video: https://drive.google.com/file/d/1s4SIYk5H8ItrYylYKuZEmBcP9EIBZTi0/view?usp=sharing 

# Operation Program Flow:

![Operation_Flow-image](https://user-images.githubusercontent.com/43405112/83962201-d7814200-a8de-11ea-92e2-6610aa5a2389.png)

# Class Program Flow:

![class Program Flow](https://user-images.githubusercontent.com/43405112/83962309-be2cc580-a8df-11ea-8318-fb7e13f06f70.png)


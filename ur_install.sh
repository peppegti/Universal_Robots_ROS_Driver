#!/bin/bash

# This script installs the repository automatically.
# Put this file in the home and start it.
# peppegti 2022 - peppegti@gmail.com

echo "Universal_Robots_ROS_Driver setup"
read -p "Press enter to continue"

# source global ros
ROS_DISTRO="melodic"
source /opt/ros/$ROS_DISTRO/setup.bash

# create a catkin workspace
mkdir -p ur_ws/src && cd ur_ws

# build the workspace
cd $HOME/ur_ws/ && catkin_make

# clone the driver
git clone https://github.com/peppegti/Universal_Robots_ROS_Driver.git src/Universal_Robots_ROS_Driver

# clone fork of the description. This is currently necessary, until the changes are merged upstream.
git clone -b calibration_devel https://github.com/peppegti/universal_robot.git src/fmauch_universal_robot

# install dependencies
sudo apt update -qq
rosdep update
rosdep install --from-paths src --ignore-src -y

# build the workspace
cd $HOME/ur_ws/ && catkin_make

# activate the workspace (ie: source it)
source $HOME/ur_ws/devel/setup.bash
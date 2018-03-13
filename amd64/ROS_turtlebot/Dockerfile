# ROS Ubuntu
# for amd64
# 20180221
# http://wiki.ros.org/kinetic/Installation/Ubuntu
# http://wiki.ros.org/turtlebot/Tutorials/indigo/Turtlebot%20Installation
 
FROM	wei1234c/ros_ubuntu_amd64

MAINTAINER Wei Lin


USER	root

# Install Anaconda ______________________________________________________________ 

RUN	apt-get update && \
	apt-get install -y ros-kinetic-turtlebot ros-kinetic-turtlebot-gazebo \
	ros-kinetic-turtlebot-apps ros-kinetic-turtlebot-interactions \
	ros-kinetic-turtlebot-simulator ros-kinetic-kobuki-ftdi \
	ros-kinetic-ar-track-alvar-msgs

#	ros-kinetic-rocon-remocon ros-kinetic-rocon-qt-library

USER	pi

WORKDIR	/home/pi

# Expose ports.
EXPOSE	11311

CMD	["/bin/bash"]

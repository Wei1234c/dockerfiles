#!/usr/bin/env bash

docker run -it --rm \
	--name=ROS_turtlebot \
	--net=host \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e DISPLAY=unix$DISPLAY \
	--cap-add=SYS_ADMIN \
	--device /dev/snd \
	--device /dev/dri \
	-v /dev/shm:/dev/shm \
	-p 11311:11311 \
	wei1234c/ros_ubuntu_amd64_turtlebot

# export TURTLEBOT_GAZEBO_WORLD_FILE=/opt/ros/kinetic/share/turtlebot_gazebo/worlds/playground.world
# roslaunch turtlebot_gazebo turtlebot_world.launch

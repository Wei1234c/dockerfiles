#!/usr/bin/env bash

docker run -it --rm \
	--net=host \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e DISPLAY=unix$DISPLAY \
	--cap-add=SYS_ADMIN \
	--device /dev/snd \
	-v /dev/shm:/dev/shm \
	-p 11311:11311 \
	wei1234c/ros_armv7


#	--name=ROS \


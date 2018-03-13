#!/usr/bin/env bash

docker run -it --rm \
	--net=host \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e DISPLAY=unix$DISPLAY \
	--cap-add=SYS_ADMIN \
	--device /dev/snd \
	--device /dev/dri \
	-v /dev/shm:/dev/shm \
	-p 11311:11311 \
	wei1234c/ros_ubuntu_amd64


#	--name=ROS \

# docker run -it --rm \
#        -e DISPLAY=$DISPLAY \
#        -v /tmp/.X11-unix:/tmp/.X11-unix \
#        wei1234c/ros_ubuntu_amd64

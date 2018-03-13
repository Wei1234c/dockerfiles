#!/usr/bin/env bash

docker run -it --rm \
	--name=ROS_python \
	--net=host \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e DISPLAY=unix$DISPLAY \
	--cap-add=SYS_ADMIN \
	--device /dev/snd \
	--device /dev/dri \
	-v /dev/shm:/dev/shm \
	-p 8888:8888 \
	-p 11311:11311 \
	-v /home/wei/Dropbox/Coding/notebooks/工具與技術/ROS/github/notebooks:/home/pi/notebooks \
	wei1234c/ros_ubuntu_amd64_python

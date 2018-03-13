#!/usr/bin/env bash

docker run -it --rm \
	--net host \
	--cpuset-cpus 0 \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e DISPLAY=unix$DISPLAY \
	--cap-add=SYS_ADMIN \
	-v $HOME/Downloads:/home/pi/Downloads \
	-v $HOME/.config/google-chrome/:/home/pi/data \
	--device /dev/snd \
	--device /dev/dri \
	-v /dev/shm:/dev/shm \
	--name chrome \
	wei1234c/chrome
	
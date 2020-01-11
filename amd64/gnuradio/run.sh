# https://newtoypia.blogspot.com/2018/07/docker-gui.html
# https://hub.docker.com/r/marcelmaatkamp/gnuradio

docker run -it --rm \
	--name gnuradio \
	-e DISPLAY=$DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ${HOME}/Templates:/tmp/sdr \
	-v /dev/bus/usb:/dev/bus/usb \
	--privileged \
	wei1234c/gnuradio:3.7  \
	/bin/bash
	

# https://newtoypia.blogspot.com/2018/07/docker-gui.html
# https://hub.docker.com/r/marcelmaatkamp/gnuradio

docker run -it --rm \
	--name gnuradio \
	-e DISPLAY=$DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ${HOME}/Templates:/tmp/gnuradio \
	--privileged -v /dev/bus/usb:/dev/bus/usb \
	wei1234c/gnuradio:3.8  \
	/bin/bash
	

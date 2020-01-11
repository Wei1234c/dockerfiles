# https://hub.docker.com/r/jopohl/urh/

docker run -it --rm \
	--name urh \
	-e DISPLAY=$DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ${HOME}/Templates:/tmp/sdr \
	-v /dev/bus/usb:/dev/bus/usb \
	--privileged \
	wei1234c/urh
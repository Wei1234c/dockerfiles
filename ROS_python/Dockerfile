# ROS Ubuntu
# for amd64
# 20180221
# http://wiki.ros.org/kinetic/Installation/Ubuntu
 
FROM	wei1234c/ros_ubuntu_amd64

MAINTAINER Wei Lin

USER	pi


# Install Anaconda ______________________________________________________________ 
WORKDIR	/home/pi/Downloads

RUN	export installer=Anaconda3-5.1.0-Linux-x86_64.sh && \
	wget https://repo.continuum.io/archive/${installer} && \
	chmod +x ${installer} && \
	./${installer} -b && \
	rm ${installer}

ENV	PATH="/home/pi/anaconda3/bin:${PATH}"

RUN	pip install catkin_pkg rospkg empy



WORKDIR	/home/pi

COPY	--chown=pi jn .
RUN 	chmod +x jn && \
	mkdir -p /home/pi/notebooks

# Expose ports.
EXPOSE	11311 8888

CMD	["/bin/bash"]

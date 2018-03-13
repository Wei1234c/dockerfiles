# ROS Ubuntu
# for amd64
# 20180221
# http://wiki.ros.org/ROSberryPi/Installing%20ROS%20Kinetic%20on%20the%20Raspberry%20Pi
 
FROM	resin/rpi-raspbian

MAINTAINER	Wei Lin

USER	root

RUN	apt-get update && \
	apt-get install -y wget sudo unzip


# Setup ROS Repositories _________________________________________________________________________________
# 
RUN	sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
RUN	apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

# make sure your Debian package index is up-to-date
RUN	apt-get update && apt-get upgrade

# Install Bootstrap Dependencies
RUN	apt-get install -y python-rosdep python-rosinstall-generator python-wstool python-rosinstall build-essential cmake


# Initializing rosdep ____________________________________________________________________________________

# RUN	chmod +x /opt/ros/kinetic/setup.* 
RUN	rosdep init
RUN	echo "source /opt/ros/kinetic/setup.bash" >> /etc/bash.bashrc
 

# X11. ______________________________________________________________________________________________________

# Add user pi
RUN	useradd -G adm,sudo,users,audio,video -s /bin/bash -m pi && \
	echo 'pi:raspberry' | chpasswd

RUN	mkdir -p /etc/sudoers.d/ && \
	echo "pi ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/pi && \
	chmod 0440 /etc/sudoers.d/pi



# Environment variables __________________________________________________________________________________
RUN	echo " " >> /etc/bash.bashrc && \
	echo "#_____________________" >> /etc/bash.bashrc && \
	echo "force_color_prompt=yes" >> /etc/bash.bashrc && \
	echo "alias cls='clear'" >> /etc/bash.bashrc && \	
	echo "alias l='ls -CF'" >> /etc/bash.bashrc && \
	echo "alias la='ls -A'" >> /etc/bash.bashrc && \
	echo "alias ls='ls --color=auto'" >> /etc/bash.bashrc && \
	echo "alias ll='ls -alhF'" >> /etc/bash.bashrc && \
	echo "egrep='egrep --color=auto'" >> /etc/bash.bashrc && \
	echo "fgrep='fgrep --color=auto'" >> /etc/bash.bashrc && \
	echo "grep='grep --color=auto'" >> /etc/bash.bashrc && \
	echo "export TERM=linux" >> /etc/bash.bashrc 	


# Installation ____________________________________________________________________________________________

USER pi

# update ROS (cannot run as root) _________________________________________________________________________
WORKDIR /home/pi
RUN	mkdir -p /home/pi/Downloads
RUN	rosdep update

# Create a catkin Workspace
RUN	mkdir -p /home/pi/ros_catkin_ws
WORKDIR /home/pi/ros_catkin_ws

# Fetch the core packages so we can build them
# ROS-Comm: (recommended) ROS package, build, and communication libraries. No GUI tools.
RUN	rosinstall_generator ros_comm --rosdistro kinetic --deps --wet-only --tar > kinetic-ros_comm-wet.rosinstall && \
	wstool init src kinetic-ros_comm-wet.rosinstall

# Desktop: ROS, rqt, rviz, and robot-generic libraries
# RUN	rosinstall_generator desktop --rosdistro kinetic --deps --wet-only --tar > kinetic-desktop-wet.rosinstall && \
#	wstool init src kinetic-desktop-wet.rosinstall

# So far, only these two variants have been tested on the Raspberry Pi in Kinetic; however, 
# more are defined in REP 131 such as robot, perception, etc. Just change the package path to the one you want, e.g., for robot do:
# RUN	rosinstall_generator robot --rosdistro kinetic --deps --wet-only --tar > kinetic-robot-wet.rosinstall && \
#	wstool init src kinetic-robot-wet.rosinstall

# Resolve Dependencies
# Unavailable Dependencies
RUN	mkdir -p /home/pi/ros_catkin_ws/external_src && \
	cd /home/pi/ros_catkin_ws/external_src && \
	wget http://sourceforge.net/projects/assimp/files/assimp-3.1/assimp-3.1.1_no_test_models.zip/download -O assimp-3.1.1_no_test_models.zip && \
	unzip assimp-3.1.1_no_test_models.zip && \
	cd assimp-3.1.1 && \
	cmake . && \
	make && \
	sudo make install

# Resolving Dependencies with rosdep
WORKDIR /home/pi/ros_catkin_ws
RUN	rosdep install -y --from-paths src --ignore-src --rosdistro kinetic -r --os=debian:jessie

# Building the catkin Workspace
RUN	sudo src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release --install-space /opt/ros/kinetic -j1
RUN	sudo chmod +x /opt/ros/kinetic/setup.*
RUN	source /opt/ros/kinetic/setup.bash
# RUN	echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc

# Maintaining a Source Checkout
# Adding Released Packages
WORKDIR /home/pi/ros_catkin_ws
RUN	rosinstall_generator ros_comm ros_control joystick_drivers --rosdistro kinetic --deps --wet-only --tar > kinetic-custom_ros.rosinstall

# update the workspace with wstool:
RUN	wstool merge -t src kinetic-custom_ros.rosinstall && \
	wstool update -t src

# run rosdep to install any new dependencies that are required:
RUN	rosdep install --from-paths src --ignore-src --rosdistro kinetic -y -r --os=debian:jessie

# rebuild the workspace:
RUN	sudo src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release --install-space /opt/ros/kinetic



# Expose ports.
EXPOSE	11311

CMD	["/bin/bash"]


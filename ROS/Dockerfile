# ROS Ubuntu
# for amd64
# 20180221
# http://wiki.ros.org/kinetic/Installation/Ubuntu
 
FROM	ubuntu

MAINTAINER	Wei Lin

USER	root

RUN	apt-get update && \
	apt-get install -y wget sudo


# Install ROS ____________________________________________________________________________________________

RUN	sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
RUN	apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
RUN	apt-get update && \
	apt-get install -y ros-kinetic-desktop-full
RUN	apt-get install -y python-rosinstall python-rosinstall-generator python-wstool build-essential


# Initialize ROS _________________________________________________________________________________________
RUN	chmod +x /opt/ros/kinetic/setup.* 
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



USER pi

# update ROS (cannot run as root) _________________________________________________________________________
WORKDIR /home/pi
RUN	mkdir -p /home/pi/Downloads
RUN	rosdep update 



# Expose ports.
EXPOSE	11311

CMD	["/bin/bash"]


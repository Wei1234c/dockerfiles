# lubuntu-desktop
# ref: https://github.com/dockerfile/ubuntu-desktop/blob/master/Dockerfile
# to launch:
# ddesktop(){
	# docker run \
	# -dit \
	# -p 2022:22 \
	# -p 3389:3389 \
	# -p 3389:3389/udp \
	# -p 5800:5800 \
	# -p 5800:5800/udp \
	# -p 5900:5900 \
	# -p 5900:5900/udp \
	# -p 5901:5901 \
	# -p 5901:5901/udp \
	# --name=desktop \
	# lubuntu-desktop 
	
	# docker exec desktop service ssh start
	# docker exec desktop service xrdp start
	# docker exec desktop vncserver
# }
# vncpassword: 12345678

FROM wei1234c/ubuntu_armv7

MAINTAINER Wei Lin

ENV TERM linux 

USER root
RUN echo 'root:raspberry' | chpasswd	 


# ADD USER PI __________________________
RUN \
	useradd -G adm,sudo,users -s /bin/bash -m pi && \
	echo 'pi:raspberry' | chpasswd



# Install SSH ________________________________________________________________________________________________
RUN \
	apt-get update && \
	apt-get install -y openssh-server && \
	mkdir /var/run/sshd
	

# root password and login permission / use user pi instead
# SSH login fix. Otherwise user is kicked off after login
RUN \
	service ssh stop && \
	sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
	sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# RUN	service ssh restart


 
# Install LXDE VNC XRDP Chrome __________________________
RUN \
	DEBIAN_FRONTEND=noninteractive apt-get install -y \
	lubuntu-desktop \
	tightvncserver \
	xrdp \
	chromium-browser \
	htop

	
# .xsession __________________________
RUN \
	echo lxsession -s Lubuntu -e LXDE > /root/.xsession && \
	cp /root/.xsession /home/pi/ && \
	service xrdp stop && \
	rm -f /run/xrdp/xrdp.pid && \
	rm -f /var/run/xrdp/xrdp-sesman.pid
	 

	
# VNC setting __________________________
ENV	USER	root

RUN \
	mkdir /root/.vnc && \
	echo "12345678" | vncpasswd -f > /root/.vnc/passwd && \
	chmod 600 /root/.vnc/passwd

# RUN	vncserver



 
# Define working directory.
WORKDIR /data

# SSHD
EXPOSE 22 3389 5800 5900 5901

# Boot up ________________________________________________________________________________________________
CMD	["bash"]




# Misc. ______________________________________________________________________________________________________

# Upgrade and clean up
RUN \
	apt-get dist-upgrade -y && \
	apt-get autoremove -y && \
	apt-get autoclean -y && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/*


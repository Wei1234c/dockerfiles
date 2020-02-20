# https://github.com/F5OEO/rpitx

FROM	armv7/armhf-ubuntu

MAINTAINER	Wei Lin

ENV	TERM	linux 

USER	root

# Install SSH ________________________________________________________________________________________________
RUN \ 
	apt-get update && \ 
	apt-get install git	


# Add user pi
RUN \
	useradd -G adm,sudo,users -s /bin/bash -m pi && \
	echo 'pi:raspberry' | chpasswd
 

USER	pi

RUN \ 
	cd /home/pi && \ 
	git clone https://github.com/F5OEO/rpitx && \ 
	cd rpitx && \ 
	./install.sh

 
# Define default command.
CMD	["bash"]
# CMD	["/home/pi/rpitx/easytest.sh"] 
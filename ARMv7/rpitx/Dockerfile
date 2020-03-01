# https://github.com/F5OEO/rpitx

FROM	raspbian/jessie

MAINTAINER	Wei Lin

ENV	TERM	linux 
ENV	DEBIAN_FRONTEND=noninteractive 

USER	root

# Install rpitx ________________________________________________________________________________________________
RUN \ 
	apt-get update && \ 
	apt-get install -y git
RUN \ 	
	apt-get install -y sudo make
RUN \ 	
	apt-get install -y dialog
RUN \ 
	git clone https://github.com/F5OEO/rpitx
RUN \ 
	apt-get install -y gcc
RUN \ 
	apt-get install -y libpaper1 libpaper-dev libpaper-utils
ENV	CONT	y
RUN \	
	cd rpitx && \ 
	./install.sh
 
# Define default command.
CMD	["bash"]
# CMD	["/rpitx/easytest.sh"] 

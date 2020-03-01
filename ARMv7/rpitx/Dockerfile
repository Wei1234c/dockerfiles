# https://github.com/F5OEO/rpitx

FROM	raspbian/jessie

MAINTAINER	Wei Lin

ENV	TERM	linux 
ENV	DEBIAN_FRONTEND=noninteractive 
ENV	CONT	y   # to configure libpaper automatically.

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
	apt-get install -y build-essential 
# gcc g++ c++
RUN \ 
	apt-get install -y libpaper1 libpaper-dev libpaper-utils
RUN \ 
	git clone https://github.com/F5OEO/rpitx
RUN \	
	cd rpitx && \ 
	./install.sh
 
# Define default command.
WORKDIR	/rpitx
CMD	["bash"]
# CMD	["/rpitx/easytest.sh"] 

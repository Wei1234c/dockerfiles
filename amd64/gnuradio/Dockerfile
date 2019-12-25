FROM	ubuntu:18.04

ENV	DEBIAN_FRONTEND=noninteractive 

# Update & Upgrade ************************************
RUN	\ 
	apt-get update	
RUN	\ 
	apt-get install -y sudo
RUN	\ 
	apt-get install -y software-properties-common



# HackRF ***********************************************
# https://github.com/mossmann/hackrf/wiki
# https://github.com/mossmann/hackrf/wiki/Operating-System-Tips
RUN \ 
	apt-get install -y gqrx-sdr
RUN \ 
	apt-get install -y gr-osmosdr
RUN \ 
	apt-get install -y libhackrf0
RUN \ 
	apt-get install -y libhackrf-dev
RUN \ 
	apt-get install -y hackrf
 
 
# GNU Radio  *******************************************
# https://github.com/gnuradio/gnuradio
# https://github.com/mossmann/hackrf/wiki/Getting-Started-with-HackRF-and-GNU-Radio
# https://wiki.gnuradio.org/index.php/Tutorials
# https://wiki.gnuradio.org/index.php/InstallingGR#Ubuntu_PPA_Installation 
RUN  \ 
	add-apt-repository ppa:gnuradio/gnuradio-releases
RUN  \ 
	apt-get update  
RUN \ 
	apt-get install -y libgtk-3-dev
RUN \ 
	apt-get install -y gnuradio	
# ENV	NO_AT_BRIDGE=1


# RUN  \ 
	# apt autoremove -y

	
# for Xwindow **********************************************
ARG	user_id=1000
ARG	user_name=gnuradio_user
ARG workdir=/tmp/gnuradio

RUN \ 
	useradd --create-home \ 
				  --shell /bin/bash \ 
				  --groups audio,video,sudo \ 
				  --uid $user_id \ 
				  $user_name && \ 
	echo $user_name:gnuradio | chpasswd
	
	
USER	$user_name
WORKDIR	$workdir


# CMD **********************************************
CMD	["/bin/bash"]

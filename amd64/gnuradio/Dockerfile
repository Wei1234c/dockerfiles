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
 
RUN \ 
	apt-get install -y libgtk-3-dev
RUN \ 
	apt-get install -y libcanberra-gtk-module
	
ARG	version=-3.7
# RUN  \ 
	# add-apt-repository ppa:gnuradio/gnuradio-releases
RUN  \ 
	add-apt-repository ppa:gnuradio/gnuradio-releases$version  # to be compatible with gr-osmosdr
RUN  \ 
	apt-get update 
RUN \ 
	apt-get install -y gnuradio	
	
# ENV	NO_AT_BRIDGE=1


RUN  \ 
	apt autoremove -y


# sudo apt-get install -y git cmake
# sudo apt-get install -y libgmp-dev libgmp3-dev libgmp10

# sudo apt-get install -y libuhd-dev libgnuradio-uhd
# sudo apt-get install -y libgnuradio-fcd3.7.11 libgnuradio-fcdproplus3.7.11
# sudo apt-get install -y libosmosdr-dev librtlsdr-dev libmirisdr-dev libairspy-dev libbladerf-dev libfreesrp-dev libfreesrp0
# sudo apt-get install -y libsoapysdr-dev doxygen

# git clone git://git.osmocom.org/gr-osmosdr
# cd gr-osmosdr/
# mkdir build
# cd build/
# cmake ../s
# make
# sudo make install
# sudo ldconfig

	
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
	
RUN	chown -R root:sudo /tmp	

USER	$user_name
RUN	mkdir -p /home/$user_name/.local/share/
WORKDIR	$workdir


# CMD **********************************************
CMD	["/bin/bash"]

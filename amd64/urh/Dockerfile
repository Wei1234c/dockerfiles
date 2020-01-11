FROM	wei1234c/gnuradio:3.7

ENV	DEBIAN_FRONTEND=noninteractive 
 
USER	root

RUN	apt-get install -y libairspy-dev libhackrf-dev librtlsdr-dev libuhd-dev
RUN	apt-get install -y python3 python3-pip 
RUN	apt-get install -y python3-dev
RUN	apt-get install -y python3-pyqt5

RUN	pip3 install Cython
RUN	pip3 install -U urh


	
# for Xwindow **********************************************
# ARG	user_id=1000
ARG	user_name=sdr_user
ARG workdir=/tmp/sdr
 

USER	$user_name
WORKDIR	$workdir


# CMD **********************************************
CMD	["/bin/bash"]
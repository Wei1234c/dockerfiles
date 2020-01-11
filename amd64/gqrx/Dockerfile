FROM	wei1234c/gnuradio:3.7

ENV	DEBIAN_FRONTEND=noninteractive 
 
USER	root

RUN	apt-get install -y gqrx-sdr
	
# for Xwindow **********************************************
# ARG	user_id=1000
ARG	user_name=sdr_user
ARG workdir=/tmp/sdr
 

USER	$user_name
WORKDIR	$workdir


# CMD **********************************************
CMD	["/bin/bash"]
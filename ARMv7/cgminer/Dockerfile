# CGMiner dockerfile for armv7
# by: Wei Lin
# date: 2015/9/6
# 

FROM wei1234c/sshd_armv7

MAINTAINER Wei Lin

ENV TERM linux 

USER root



# Install SSH ________________________________________________________________________________________________

# passwordless ssh
RUN \
	ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa && \
	cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys


# Install CGMiner ____________________________________________________________________________________________
ENV	CGMiner_VERSION_MAIN 4.9
ENV	CGMiner_VERSION 4.9.1
ENV	CGMiner_HOME /usr/local/cgminer
ENV	LIBCURL_CFLAGS ' -I/usr/include/curl'

RUN	apt-get update && \
	apt-get install -y git wget curl && \
	apt-get install -y libusb-1.0-0-dev libusb-1.0-0 libusb-dev \
		libcurl4-openssl-dev libcurl4-gnutls-dev libncurses5-dev libudev-dev  \
		screen libtool autoconf automake pkg-config \
		libjansson-dev libtool pkg-config

RUN	apt-get install -y --reinstall make

RUN	apt-get dist-upgrade -y && \
	cd /usr/local && \
	git clone https://github.com/bitmaintech/cgminer && \	
	ls -alF


RUN	cd ${CGMiner_HOME} && \
	./autogen.sh

RUN	./configure --enable-bmsc
# RUN	./configure --enable-cpumining


RUN	pwd && \
	make && \
	cd 

# ENV PATH ${PATH}:${CGMiner_HOME}


# Boot up
CMD ["bash"]

# Web-related ports
EXPOSE 80 8080 8088 443
# BTC ports
EXPOSE 8339 3333 3335 
# api-port
EXPOSE 4028

# SSHD
EXPOSE 22




# Misc. ______________________________________________________________________________________________________

# Upgrade and clean up
RUN \
	apt-get dist-upgrade -y && \
	apt-get autoremove -y && \
	apt-get autoclean -y && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/*

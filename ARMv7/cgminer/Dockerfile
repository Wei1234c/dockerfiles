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
# Environmant variables
ENV	CGMiner_VERSION_MAIN 4.9
ENV	CGMiner_VERSION 4.9.1
ENV	CGMiner_HOME /usr/local/cgminer
ENV	LIBCURL_CFLAGS ' -I/usr/include/curl'

# Install related packages
RUN	apt-get update && \
	apt-get install -y git wget curl \
			libgusb2 libgusb-dev \
			libcurl4-openssl-dev \
			libncurses5-dev \
			libudev-dev && \
	apt-get install -y screen libtool autoconf automake pkg-config build-essential \ 
			libjansson-dev  && \
	apt-get install -y --reinstall make && \
	apt-get dist-upgrade -y

# Clone CGMiner source code
RUN	cd /usr/local && \
	git clone https://github.com/bitmaintech/cgminer && \
	cd ${CGMiner_HOME} && \
	git checkout v2.9.6 && \	
	ls -alF

# Compile source
WORKDIR	${CGMiner_HOME}

RUN	./autogen.sh && \
	./configure --enable-cpumining && \
	make

#RUN	./autogen.sh && \
#	./configure   --disable-libcurl --enable-cpumining && \
#	make


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
 

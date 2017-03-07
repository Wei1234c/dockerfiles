# by: 	Wei Lin
# date: 2017/2/18
# ref:	https://github.com/pfalcon/esp-open-sdk
#	https://gist.github.com/hoihu/bebcb195287233b7c6ff477e235d2fc4 


FROM 	ubuntu:16.04

MAINTAINER Wei Lin

ENV 	TERM linux

RUN 	apt-get update && apt-get dist-upgrade -y
RUN	apt-get install -y \
	make unrar-free autoconf automake libtool gcc g++ gperf \
	flex bison texinfo gawk ncurses-dev libexpat-dev python-dev python python-serial \
	sed git unzip bash help2man wget bzip2 libtool-bin 

RUN	useradd -G sudo,users -s /bin/bash -m xtensa && \
	echo 'xtensa:raspberry' | chpasswd

# install ESP SDK 
WORKDIR /home/xtensa
RUN 	git clone --recursive https://github.com/pfalcon/esp-open-sdk.git
RUN 	chmod 777 -R /home/xtensa/esp-open-sdk
RUN 	chown -R xtensa:xtensa /home/xtensa/esp-open-sdk/
ENV 	PATH /home/xtensa/esp-open-sdk/xtensa-lx106-elf/bin:$PATH

USER xtensa
WORKDIR /home/xtensa/esp-open-sdk
RUN 	make
# RUN 	make STANDALONE=y


# Misc. ______________________________________________________________________________________________________

USER 	root

# Upgrade and clean up
RUN	apt-get dist-upgrade -y && \
	apt-get autoremove -y && \
	apt-get autoclean -y && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/*

USER 	xtensa
RUN	cd


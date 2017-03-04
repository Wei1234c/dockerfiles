# by: Wei Lin
# date: 2015/10/1

FROM	armv7/armhf-ubuntu:14.04

MAINTAINER	Wei Lin

ENV	TERM	linux

USER	root


# Misc. ______________________________________________________________________________________________________

# Set time zone
RUN \
	echo "Asia/Taipei" > /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata

# Set default locale
ENV	LANG	en_US.UTF-8
RUN \
	locale-gen en_US.UTF-8 && \
 	locale-gen zh_TW && \
 	locale-gen zh_TW.UTF-8 && \
 	locale-gen zh_CN.UTF-8 && \
 	update-locale LANG=en_US.UTF-8
	 
# Environment variables
RUN \
	echo " " >> /etc/bash.bashrc && \
	echo "#_____________________" >> /etc/bash.bashrc && \
	echo "force_color_prompt=yes" >> /etc/bash.bashrc && \
	echo "alias cls='clear'" >> /etc/bash.bashrc && \	
	echo "alias l='ls -CF'" >> /etc/bash.bashrc && \
	echo "alias la='ls -A'" >> /etc/bash.bashrc && \
	echo "alias ls='ls --color=auto'" >> /etc/bash.bashrc && \
	echo "alias ll='ls -alhF'" >> /etc/bash.bashrc && \
	echo "egrep='egrep --color=auto'" >> /etc/bash.bashrc && \
	echo "fgrep='fgrep --color=auto'" >> /etc/bash.bashrc && \
	echo "grep='grep --color=auto'" >> /etc/bash.bashrc && \
	echo "export TERM=linux" >> /etc/bash.bashrc 	

# Upgrade and clean up
RUN \
	apt-get update && \
	apt-get install -y htop && \
	apt-get dist-upgrade -y && \
	apt-get autoremove -y && \
	apt-get autoclean -y && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/*

CMD	["bash"]

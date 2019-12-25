# Run Chrome in a container
#
# https://blog.jessfraz.com/post/docker-containers-on-the-desktop/

FROM ubuntu:16.04 

USER root

# Install Chrome ____________________________________________________________________________________________
RUN apt-get update && apt-get install -y wget gnupg2
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -  
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -y google-chrome-stable


# X11. ______________________________________________________________________________________________________

RUN mkdir -p /etc/sudoers.d/

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/pi && \
    echo "pi:x:${uid}:${gid}:pi,,,:/home/pi:/bin/bash" >> /etc/passwd && \
    echo "pi:x:${uid}:" >> /etc/group && \
    echo "pi ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/pi && \
    chmod 0440 /etc/sudoers.d/pi && \
    chown ${uid}:${gid} -R /home/pi


# Add pi user
RUN usermod -a -G audio,video,sudo pi
# RUN groupadd -r pi && useradd -r -g pi -G audio,video pi 

RUN mkdir -p /home/pi/Downloads && \
	mkdir -p /home/pi/data && \
	chown -R pi:pi /home/pi

# COPY local.conf /etc/fonts/local.conf
# RUN fc-cache -fv


# Misc. ______________________________________________________________________________________________________
 
# Set time zone **************************************
RUN \
	echo "Asia/Taipei" > /etc/timezone
RUN \
	apt-get update && \
	apt-get install -y apt-utils software-properties-common 
RUN \
	apt-get install -yf tzdata locales

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

RUN dpkg-reconfigure locales 
	 
# Environment variables _____________________________________________________________________________________
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


# Run Chrome as non privileged user __________________________________________________________________________
USER pi 
ENV HOME /home/pi


# Autorun chrome
ENTRYPOINT [ "google-chrome" ]
CMD [ "--user-data-dir=/home/pi/data" ]

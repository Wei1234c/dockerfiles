# Python Dockerfile
#
# https://github.com/dockerfile/python
# https://raw.githubusercontent.com/dockerfile/python/master/Dockerfile
# 
# modified by: Wei Lin
# date: 2015/9/3

# Pull base image.
FROM armv7/armhf-ubuntu:14.04

MAINTAINER Wei Lin

ENV TERM linux

# Install Python. ____________________________________________________________________________________________
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-dev python3-numpy python3-scipy python3-matplotlib python3-pandas && \
    apt-get install -y python python-pip python-dev
    
# Define working directory.
WORKDIR /data

# Define default command.
CMD ["bash"]




# Misc. ______________________________________________________________________________________________________

# Set time zone
RUN \
     echo "Asia/Taipei" > /etc/timezone && \
     dpkg-reconfigure -f noninteractive tzdata
	
# Environment variables
RUN \
     echo " " >> /etc/bash.bashrc && \
     echo "#_____________________" >> /etc/bash.bashrc && \
     echo "force_color_prompt=yes" >> /etc/bash.bashrc && \
     echo "alias cls='clear'" >> /etc/bash.bashrc && \
     echo "export TERM=linux" >> /etc/bash.bashrc 	

# Upgrade and clean up
RUN \
     apt-get dist-upgrade -y && \
     apt-get autoremove -y && \
     apt-get autoclean -y && \
     apt-get clean -y && \
     rm -rf /var/lib/apt/lists/*

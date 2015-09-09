# MongoDB Dockerfile
# https://github.com/dockerfile/mongodb
#
# origin: https://raw.githubusercontent.com/dockerfile/mongodb/master/Dockerfile
# modified by: Wei Lin
# date: 2015/9/3

# Pull base image.
FROM armv7/armhf-ubuntu:14.04

MAINTAINER Wei Lin

ENV TERM linux

# Install MongoDB. ___________________________________________________________________________________________
RUN apt-get update && \
    apt-get install -y mongodb

# RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
#    echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list && \
#    apt-get update && \
#    apt-get install -y mongodb-org mongodb mongodb-clients mongodb-dev mongodb-server

    
# Define mountable directories.
VOLUME ["/data/db"]

# Define working directory.
WORKDIR /data

# Expose ports.
#   - 27017: process
#   - 28017: http
EXPOSE 27017
EXPOSE 28017

# Define default command.
CMD ["mongod"]



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

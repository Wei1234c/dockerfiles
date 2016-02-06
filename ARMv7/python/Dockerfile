# Python Dockerfile
#
# https://github.com/dockerfile/python
# https://raw.githubusercontent.com/dockerfile/python/master/Dockerfile
# 
# modified by: Wei Lin
# date: 2015/9/3

# Pull base image.
FROM wei1234c/ubuntu_armv7

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

# Upgrade and clean up
RUN \
     apt-get dist-upgrade -y && \
     apt-get autoremove -y && \
     apt-get autoclean -y && \
     apt-get clean -y && \
     rm -rf /var/lib/apt/lists/*

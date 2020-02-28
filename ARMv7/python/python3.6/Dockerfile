# Python Dockerfile
#
# https://github.com/dockerfile/python
# https://raw.githubusercontent.com/dockerfile/python/master/Dockerfile
# 
# modified by: Wei Lin
# date: 2020/2/28

# Pull base image.
FROM raspbian/jessie

MAINTAINER Wei Lin

ENV TERM linux

USER	root

# Install Python. ____________________________________________________________________________________________
RUN apt-get update && \ 
	apt-get install -y build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev
	apt-get install -y zlib1g zlib1g-dev
	apt-get install -y openssl libssl-dev

# Add user pi
RUN \ 
	useradd -G adm,users,sudo,staff,dialout -s /bin/bash -m pi && \
	echo 'pi:raspberry' | chpasswd
	
USER	pi

WORKDIR /home/pi
RUN \ 
	wget https://www.python.org/ftp/python/3.6.10/Python-3.6.10.tar.xz && \ 
	tar -xvf Python-3.6.10.tar.xz && \ 

WORKDIR /home/pi/Python-3.6.10 
RUN \ 
	./configure --with-ssl && \ 
	make
RUN \ 
	make altinstall && \ 

RUN \ 
	sudo ln -s /usr/local/bin/python3.6 /usr/bin/python3 && \ 
	sudo ln -s /usr/local/bin/pip3.6 /usr/bin/pip3


# Define default command.
WORKDIR /home/pi
CMD ["bash"] 
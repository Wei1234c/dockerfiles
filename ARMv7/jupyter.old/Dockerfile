# Installs Jupyter Notebook and IPython kernel from the current branch
# Another Docker container should inherit with `FROM jupyter/notebook`
# to run actual services.
#
# origin: 
#	https://hub.docker.com/r/jupyter/notebook/
#	https://github.com/jupyter/notebook


# Pull base image.
FROM armv7/armhf-ubuntu:14.04

MAINTAINER Wei Lin

# export TERM=linux
ENV TERM linux 

ENV DEBIAN_FRONTEND noninteractive

# Not essential, but wise to set the lang
# Note: Users with other languages should set this in their derivative image
RUN \
     apt-get update && \
     apt-get install -y language-pack-en

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales



# Python binary dependencies, developer tools
RUN apt-get install -y -q \
    build-essential \
    make \
    gcc \
    zlib1g-dev \
    git \
    python \
    python-dev \
    python-pip \
    python3-dev \
    python3-pip \
    python-sphinx \
    python3-sphinx \
    libzmq3-dev \
    sqlite3 \
    libsqlite3-dev \
    pandoc \
    libcurl4-openssl-dev \
    nodejs \
    nodejs-legacy \
    npm

RUN pip2 install --upgrade setuptools pip
RUN pip3 install --upgrade setuptools pip

RUN pip2 install ipykernel
RUN pip3 install ipykernel

RUN mkdir -p /srv/
ADD . /srv/notebook
WORKDIR /srv/notebook/

RUN pip3 install --pre -e .

# install kernels
RUN python2 -m ipykernel.kernelspec
RUN python3 -m ipykernel.kernelspec

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


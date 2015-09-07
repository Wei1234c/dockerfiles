# Dockerfile for Oracle-Java8 and SSHD with Ubuntu on RPi2
# by: Wei Lin
# date: 2015/9/3

# Pull base image.
FROM armv7/armhf-ubuntu:14.04

MAINTAINER Wei Lin

# export TERM=linux
ENV TERM linux 

# Identity for excuting the script.
# sudo su
USER root


# Install Java _______________________________________________________________________________________________
RUN \
     echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
     apt-get update && \
     apt-get install -y software-properties-common && \
     add-apt-repository -y ppa:webupd8team/java && \
     apt-get update && \
     apt-get install -y oracle-java8-installer && \
     apt-get remove -y software-properties-common && \
     rm -rf /var/cache/oracle-jdk8-installer
	 
# Define commonly used JAVA_HOME variable.
# export JAVA_HOME="/usr/lib/jvm/java-8-oracle"
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Append PATH
# export PATH=${PATH}:${JAVA_HOME}/bin
# echo ${PATH}
ENV PATH ${PATH}:${JAVA_HOME}/bin
    

	
# Install SSH ________________________________________________________________________________________________
RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd

# root password and login permission / use user pi instead
# RUN echo 'root:raspberry' | chpasswd && \
    # sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Add user pi
RUN useradd -G adm,sudo,users -s /bin/bash -m pi && \
    echo 'pi:raspberry' | chpasswd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Expose port 22
EXPOSE 22

# Define default command.
CMD ["/usr/sbin/sshd", "-D"]



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

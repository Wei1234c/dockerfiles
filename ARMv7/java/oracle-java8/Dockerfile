# Oracle Java 8 Dockerfile
#
# https://github.com/dockerfile/java
# https://github.com/dockerfile/java/tree/master/oracle-java8
#
# origin: https://github.com/dockerfile/java/blob/master/oracle-java8/Dockerfile
# modified by: Wei Lin
# date: 2015/10/1

FROM	wei1234c/ubuntu_armv7

MAINTAINER	Wei Lin

ENV	TERM	linux 

USER	root


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
ENV	JAVA_HOME	/usr/lib/jvm/java-8-oracle
ENV	PATH	${PATH}:${JAVA_HOME}/bin
    
# Define default command.
CMD	["bash"]




# Misc. ______________________________________________________________________________________________________

# Upgrade and clean up
RUN \
	apt-get dist-upgrade -y && \
	apt-get autoremove -y && \
	apt-get autoclean -y && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/*

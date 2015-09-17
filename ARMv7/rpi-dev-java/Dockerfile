# http://openhome.cc/Gossip/CodeData/DockerLayman/DockerLayman3.html

FROM armv7/armhf-ubuntu:14.04

MAINTAINER Justin Lin <caterpillar@openhome.cc>

ENV TERM linux

# Basic tools
RUN apt-get -qq update && \
    apt-get -qqy install wget && \
    apt-get -qqy install vim && \
    apt-get -qqy install unzip && \
    apt-get -qqy install git

# Oracle Java 8
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y oracle-java8-installer

# Upgrade and clean up
RUN apt-get dist-upgrade -y && \
    apt-get remove -y software-properties-common && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Gradle
RUN wget https://downloads.gradle.org/distributions/gradle-2.6-bin.zip && \
    unzip gradle-2.6-bin.zip -d /opt && \
    rm gradle-2.6-bin.zip

ENV GRADLE_HOME /opt/gradle-2.6

# PATH
ENV PATH $PATH:$JAVA_HOME/bin:$GRADLE_HOME/bin

# javacomplete
RUN mkdir /root/.vim && \
    wget http://www.vim.org/scripts/download_script.php?src_id=14914 -O javacomplete.zip && \
    unzip javacomplete.zip -d /root/.vim && \
    rm javacomplete.zip && \
    echo "setlocal omnifunc=javacomplete#Complete" >> /root/.vimrc && \
    echo "inoremap <buffer> . .<C-X><C-O><C-P>" >> /root/.vimrc

# gradle-templates

RUN mkdir /data && \
    echo "buildscript {" >> /data/build.gradle && \
    echo "    repositories {" >> /data/build.gradle && \
    echo "        maven {" >> /data/build.gradle && \
    echo "            url 'http://dl.bintray.com/cjstehno/public'" >> /data/build.gradle && \
    echo "        }" >> /data/build.gradle && \
    echo "    }" >> /data/build.gradle && \
    echo "    dependencies {" >> /data/build.gradle && \
    echo "        classpath 'gradle-templates:gradle-templates:1.5'" >> /data/build.gradle && \
    echo "    }" >> /data/build.gradle && \
    echo "}" >> /data/build.gradle && \
    echo "apply plugin:'templates'" >> /data/build.gradle

VOLUME /data

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

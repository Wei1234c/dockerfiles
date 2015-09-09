# orgin: https://hub.docker.com/_/tomcat/
# modified by: Wei Lin
# date: 2015/9/4

# Pull base image.
FROM armv7/armhf-ubuntu:14.04

MAINTAINER Wei Lin

ENV TERM linux


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



# Install TomCat _____________________________________________________________________________________________

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

# see https://www.apache.org/dist/tomcat/tomcat-8/KEYS
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys \
	05AB33110949707C93A279E3D3EFE6B686867BA6 \
	07E48665A34DCAFAE522E5E6266191C37C037D42 \
	47309207D818FFD8DCD3F83F1931D684307A10A5 \
	541FBE7D8F78B25E055DDEE13C370389288584E7 \
	61B832AC2F1C5A90F0F9B00A1C506407564C17A3 \
	79F7026C690BAA50B92CD8B66A3AD3F4F22C4FED \
	9BA44C2621385CB966EBA586F72C284D731FABEE \
	A27677289986DB50844682F8ACB77FC2E86E29AC \
	A9C5DF4D22E99998D9875A5110C01C5A2F6059E7 \
	DCFD35E0BF8CA7344752DE8B6FB21E8933C60243 \
	F3A04C595DB5B6A5F1ECA43E3B7BBB100D811BBE \
	F7DA48BB64BCB84ECBA7EE6935CD23C10D498E23

ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.0.26
ENV TOMCAT_TGZ_URL https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz

RUN set -x && \
    apt-get update && \
    apt-get install -y curl && \
    curl -fSL "$TOMCAT_TGZ_URL" -o tomcat.tar.gz && \
    curl -fSL "$TOMCAT_TGZ_URL.asc" -o tomcat.tar.gz.asc && \
    gpg --verify tomcat.tar.gz.asc && \
    tar -xvf tomcat.tar.gz --strip-components=1 && \
	apt-get remove -y curl && \
    rm bin/*.bat && \
    rm tomcat.tar.gz*
    
EXPOSE 8080

CMD ["catalina.sh", "run"]




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

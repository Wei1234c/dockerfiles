# orgin: https://hub.docker.com/_/httpd/
# modified by: Wei Lin
# date: 2015/9/4

# Pull base image.
FROM armv7/armhf-ubuntu:14.04

MAINTAINER Wei Lin

ENV TERM linux

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
#RUN groupadd -r www-data && useradd -r --create-home -g www-data www-data

ENV HTTPD_PREFIX /usr/local/apache2
ENV PATH ${PATH}:${HTTPD_PREFIX}/bin
RUN mkdir -p "$HTTPD_PREFIX" && \
    chown www-data:www-data "$HTTPD_PREFIX"
    
WORKDIR ${HTTPD_PREFIX}

# install httpd runtime dependencies
# https://httpd.apache.org/docs/2.4/install.html#requirements
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
		libapr1 \
		libaprutil1 \
		libpcre++0 \
		libssl1.0.0 && \
    rm -r /var/lib/apt/lists/*

# see https://httpd.apache.org/download.cgi#verify
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys A93D62ECC3C8EA12DB220EC934EA76E6791485A8

ENV HTTPD_VERSION 2.4.16
ENV HTTPD_BZ2_URL https://www.apache.org/dist/httpd/httpd-${HTTPD_VERSION}.tar.bz2

RUN buildDeps=' \
		ca-certificates \
		curl \
		bzip2 \
		gcc \
		libapr1-dev \
		libaprutil1-dev \
		libc6-dev \
		libpcre++-dev \
		libssl-dev \
		make \
	' \
	set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends ${buildDeps} \
	&& rm -r /var/lib/apt/lists/* \
	&& curl -SL "$HTTPD_BZ2_URL" -o httpd.tar.bz2 \
	&& curl -SL "$HTTPD_BZ2_URL.asc" -o httpd.tar.bz2.asc \
	&& gpg --verify httpd.tar.bz2.asc \
	&& mkdir -p src/httpd \
	&& tar -xvf httpd.tar.bz2 -C src/httpd --strip-components=1 \
	&& rm httpd.tar.bz2* \
	&& cd src/httpd \
	&& ./configure --enable-so --enable-ssl --prefix=${HTTPD_PREFIX} \
	&& make -j"$(nproc)" \
	&& make install \
	&& cd ../../ \
	&& rm -r src/httpd \
	&& sed -ri ' \
		s!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g; \
		s!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g; \
		' /usr/local/apache2/conf/httpd.conf \
	&& apt-get purge -y --auto-remove ${buildDeps}

# COPY httpd-foreground /usr/local/bin/
RUN echo "#!/bin/bash" > /usr/local/bin/httpd-foreground && \
    echo "set -e" >> /usr/local/bin/httpd-foreground && \
    echo " " >> /usr/local/bin/httpd-foreground && \
    echo "# Apache gets grumpy about PID files pre-existing" >> /usr/local/bin/httpd-foreground && \
    echo "rm -f /usr/local/apache2/logs/httpd.pid" >> /usr/local/bin/httpd-foreground && \
    echo " " >> /usr/local/bin/httpd-foreground && \
    echo "exec httpd -DFOREGROUND" >> /usr/local/bin/httpd-foreground && \
    chmod +x /usr/local/bin/httpd-foreground
    
# Upgrade and clean up
RUN apt-get dist-upgrade -y && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

# 設定時區
RUN echo "Asia/Taipei" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata
    
# Environment variables
RUN echo " " >> /etc/bash.bashrc && \
    echo "#_____________________" >> /etc/bash.bashrc && \
    echo "force_color_prompt=yes" >> /etc/bash.bashrc && \
    echo "alias cls='clear'" >> /etc/bash.bashrc && \
    echo "export TERM=linux" >> /etc/bash.bashrc

EXPOSE 80

CMD ["httpd-foreground"]




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
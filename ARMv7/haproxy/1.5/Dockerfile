# origin: https://github.com/docker-library/haproxy

FROM armv7/armhf-ubuntu:14.04

ENV TERM linux

RUN \
     apt-get update && \
     apt-get install -y libssl1.0.0 libpcre3 --no-install-recommends

ENV HAPROXY_MAJOR 1.5
ENV HAPROXY_VERSION 1.5.14
ENV HAPROXY_MD5 ad9d7262b96ba85a0f8c6acc6cb9edde

# see http://sources.debian.net/src/haproxy/1.5.8-1/debian/rules/ for some helpful navigation of the possible "make" arguments
RUN buildDeps='curl gcc libc6-dev libpcre3-dev libssl-dev make' \
        && set -x \
        && apt-get update \
        && apt-get install -y ${buildDeps} --no-install-recommends \
        && rm -rf /var/lib/apt/lists/* \
        && curl -SL "http://www.haproxy.org/download/${HAPROXY_MAJOR}/src/haproxy-${HAPROXY_VERSION}.tar.gz" -o haproxy.tar.gz \
        && echo "${HAPROXY_MD5}  haproxy.tar.gz" | md5sum -c \
        && mkdir -p /usr/src/haproxy \
        && tar -xzf haproxy.tar.gz -C /usr/src/haproxy --strip-components=1 \
        && rm haproxy.tar.gz \
        && make -C /usr/src/haproxy \
                TARGET=linux2628 \
                USE_PCRE=1 PCREDIR= \
                USE_OPENSSL=1 \
                USE_ZLIB=1 \
                all \
                install-bin \
        && mkdir -p /usr/local/etc/haproxy \
        && cp -R /usr/src/haproxy/examples/errorfiles /usr/local/etc/haproxy/errors \
        && rm -rf /usr/src/haproxy \
        && apt-get purge -y --auto-remove ${buildDeps}

CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]





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

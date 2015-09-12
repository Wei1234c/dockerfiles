# Oracle Java 8 Dockerfile
# by: Wei Lin
# date: 2015/9/12

# Pull base image.
FROM armv7/armhf-ubuntu:14.04

MAINTAINER Wei Lin

ENV TERM linux 

# Install Java _______________________________________________________________________________________________
RUN  apt-get update
RUN  apt-get install -y php5 php5-cgi php5-cli php5-common php5-curl php5-dbg php5-dev php5-gd php5-gmp php5-json php5-ldap php5-mysql php5-odbc php5-pgsql php5-mongo php5-pspell php5-readline php5-recode php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-xdebug php5-oauth php5-redis php5-sybase
# RUN  apt-get install -y php5-snmp php5-adodb php5-apcu php5-enchant php5-exactimage php5-fpm php5-gdcm php5-gearman php5-geoip php5-gnupg php5-imagick php5-imap php5-interbase php5-intl php5-lasso php5-librdf php5-mapscript php5-mcrypt php5-memcache php5-memcached php5-midgard2 php5-ming php5-msgpack php5-mysqlnd php5-mysqlnd-ms php5-pinba php5-ps php5-radius php5-remctl php5-rrd php5-sasl php5-stomp php5-svn php5-tokyo-tyrant php5-vtkgdcm
RUN  apt-get install -y php-pear pkg-php-tools phpldapadmin phppgadmin phpreports phpsysinfo phpunit phpunit-mock-object phpunit-selenium phpunit-story phpqrcode
# RUN  DEBIAN_FRONTEND=noninteractive apt-get install -y phpgacl phpmyadmin phpbb3 phpbb3-l10n

	   
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

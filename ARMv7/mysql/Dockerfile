# MySQL Dockerfile
# https://github.com/dockerfile/mysql
#
# origin: https://raw.githubusercontent.com/dockerfile/mysql/master/Dockerfile
# modified by: Wei Lin
# date: 2015/9/3

FROM wei1234c/ubuntu_armv7

MAINTAINER Wei Lin

ENV TERM linux

# Install MySQL. _____________________________________________________________________________________________
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server-5.6 && \ 
    sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf && \
    sed -i 's/^\(log_error\s.*\)/# \1/' /etc/mysql/my.cnf && \
    echo "mysqld_safe &" > /tmp/config && \
    echo "mysqladmin --silent --wait=30 ping || exit 1" >> /tmp/config && \
    echo "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" WITH GRANT OPTION;'" >> /tmp/config && \
    bash /tmp/config && \
    rm -f /tmp/config

# Define mountable directories.
VOLUME ["/etc/mysql", "/var/lib/mysql"]

# Define working directory.
WORKDIR /data

# Expose ports.
EXPOSE 3306

# Define default command.
CMD ["mysqld_safe"]



# Misc. ______________________________________________________________________________________________________

# Upgrade and clean up
RUN \
     apt-get dist-upgrade -y && \
     apt-get autoremove -y && \
     apt-get autoclean -y && \
     apt-get clean -y && \
     rm -rf /var/lib/apt/lists/*

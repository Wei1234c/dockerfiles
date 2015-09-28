#!/bin/bash

docker pull armv7/armhf-ubuntu:14.04
docker tag armv7/armhf-ubuntu:14.04 ubuntu:14.04
docker tag ubuntu:14.04 ubuntu:latest

docker build -t oracle-java8 java/oracle-java8
# docker tag oracle-java8  wei1234c/oracle-java8_ARMv7

# docker build -t rpi-dev-java rpi-dev-java
# docker tag rpi-dev-java  caterpillar/rpi-dev-java

docker build -t sshd sshd
# docker tag sshd wei1234c/sshd_ARMv7

docker build -t oracle-java8_sshd java_sshd
# docker tag oracle-java8_sshd wei1234c/oracle-java8_sshd_ARMv7

docker build -t python python
# docker tag python wei1234c/python_ARMv7

docker build -t nodejs nodejs
# docker tag nodejs wei1234c/nodejs_ARMv7

docker build -t php:5 php/5
# docker tag php:5 wei1234c/php_ARMv7:5

docker build -t php:cli php/5.6
# docker tag php:cli wei1234c/php_ARMv7:cli

# docker build -t php:apache php/5.6/apache
# docker tag php:apache wei1234c/php_ARMv7:apache

docker build -t mysql mysql
# docker tag mysql wei1234c/mysql_ARMv7

docker build -t mongodb mongodb
# docker tag mongodb wei1234c/mongodb_ARMv7

docker build -t apache apache
# docker tag apache wei1234c/apache_ARMv7

docker build -t tomcat tomcat
# docker tag tomcat wei1234c/tomcat_ARMv7

docker build -t hadoop_pseudo-distributed hadoop/pseudo-distributed
# docker tag hadoop_pseudo-distributed wei1234c/hadoop_pseudo-distributed_ARMv7

# docker build -t hadoop_full-distributed hadoop/cluster/node
# docker tag hadoop_full-distributed wei1234c/hadoop_full-distributed_ARMv7

docker build -t hbase hbase
# docker tag hbase  wei1234c/hbase_ARMv7

docker build -t hive hive
# docker tag hive wei1234c/hive_ARMv7

docker build -t haproxy haproxy/1.5
# docker tag haproxy wei1234c/haproxy_ARMv7

docker build -t jupyter-notebook notebook
# docker tag jupyter-notebook wei1234c/jupyter-notebook_ARMv7

docker build -t lamp lamp
# docker tag lamp wei1234c/lamp_ARMv7

docker build -t lubuntu-desktop lubuntu-desktop
# docker tag lubuntu-desktop wei1234c/lubuntu-desktop_ARMv7
 
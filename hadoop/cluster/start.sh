#!/bin/bash
# Start containers
docker run -dit -P --name=master -v /data:/data hadoop_distributed
docker run -dit -P --name=slave1 -v /data:/data hadoop_distributed
docker run -dit -P --name=slave2 -v /data:/data hadoop_distributed

# Get containers' IP addresses
master_ip="$(docker inspect master | grep IPAddress | sed 's/["IPAddress",\:,\s,[:space:],\t,\",\,]//g')"
slave1_ip="$(docker inspect slave1 | grep IPAddress | sed 's/["IPAddress",\:,\s,[:space:],\t,\",\,]//g')"
slave2_ip="$(docker inspect slave2 | grep IPAddress | sed 's/["IPAddress",\:,\s,[:space:],\t,\",\,]//g')"

# Add hosts
# Make sure you have write permission to the /data/etc/hosts on host.
echo "${master_ip} master" >  /data/etc/hosts
echo "${slave1_ip} slave1" >> /data/etc/hosts
echo "${slave2_ip} slave2" >> /data/etc/hosts
cat /data/etc/hosts

docker exec master /bin/sh -c "cat /data/etc/hosts >> /etc/hosts"
docker exec slave1 /bin/sh -c "cat /data/etc/hosts >> /etc/hosts"
docker exec slave2 /bin/sh -c "cat /data/etc/hosts >> /etc/hosts"


# Test networking
docker exec master cat /etc/hosts
docker exec master ping -c 1 slave1
docker exec master ping -c 1 slave2

docker exec slave1 cat /etc/hosts
docker exec slave1 ping -c 1 master

docker exec slave2 cat /etc/hosts
docker exec slave2 ping -c 1 master



# Startup cluster
HADOOP_HOME=/usr/local/hadoop
docker exec master ${HADOOP_HOME}/bin/hdfs namenode -format
docker exec slave1 ${HADOOP_HOME}/bin/hdfs namenode -format
docker exec slave2 ${HADOOP_HOME}/bin/hdfs namenode -format
# docker exec master ${HADOOP_HOME}/sbin/start-all.sh
docker exec master /etc/bootstrap.sh
docker exec slave1 /etc/bootstrap.sh
docker exec slave2 /etc/bootstrap.sh


# Clean up
# docker stop $(docker ps -q)
# docker rm $(docker ps -aq)




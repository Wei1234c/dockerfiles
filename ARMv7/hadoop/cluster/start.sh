#!/bin/bash
# Start containers
docker run -dit -P --name=master -v /data:/data hadoop_distributed
docker run -dit -P --name=slave1 -v /data:/data hadoop_distributed
docker run -dit -P --name=slave2 -v /data:/data hadoop_distributed

# Get containers' IP addresses
master_ip="$(docker inspect master -f {{.NetworkSettings.IPAddress}})
slave1_ip="$(docker inspect slave1 -f {{.NetworkSettings.IPAddress}})
slave2_ip="$(docker inspect slave2 -f {{.NetworkSettings.IPAddress}})

# Add hosts
# Make sure you have write permission to the /data/etc/hosts on host.
echo "${master_ip} master" >  /data/etc/hosts
echo "${slave1_ip} slave1" >> /data/etc/hosts
echo "${slave2_ip} slave2" >> /data/etc/hosts
echo "/data/etc/hosts : "
cat /data/etc/hosts

# Since Docker version 1.8.1 will register and bridge each running containers automatically, in such case, you can comment out this part.
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




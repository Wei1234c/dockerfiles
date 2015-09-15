#!/bin/bash

# Start containers
docker run -dit -P --name=master -v /data:/data hadoop_full-distributed
docker run -dit -P --name=slave1 -v /data:/data hadoop_full-distributed
docker run -dit -P --name=slave2 -v /data:/data hadoop_full-distributed

# Get containers' IP addresses
master_ip="$(docker inspect -f {{.NetworkSettings.IPAddress}} master)"
slave1_ip="$(docker inspect -f {{.NetworkSettings.IPAddress}} slave1)"
slave2_ip="$(docker inspect -f {{.NetworkSettings.IPAddress}} slave2)"

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



# format namenode
HADOOP_HOME=/usr/local/hadoop
docker exec master ${HADOOP_HOME}/bin/hdfs namenode -format

# start sshd
docker exec master service ssh start
docker exec slave1 service ssh start
docker exec slave2 service ssh start

# Startup cluster
docker exec master /etc/bootstrap.sh
# docker exec master ${HADOOP_HOME}/sbin/start-all.sh
# docker exec master ${HADOOP_HOME}/sbin/start-dfs.sh
# docker exec master ${HADOOP_HOME}/sbin/start-yarn.sh





# Stop cluster
# HADOOP_HOME=/usr/local/hadoop
# docker exec master ${HADOOP_HOME}/sbin/stop-dfs.sh
# docker exec master ${HADOOP_HOME}/sbin/stop-yarn.sh

# Clean up
# docker stop $(docker ps -q)
# docker rm $(docker ps -aq)




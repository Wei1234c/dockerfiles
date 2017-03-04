#!/bin/bash


for node_name in "master" "slave1" "slave2"
do
	# Start containers
	docker run -dit -P --name=${node_name} -v /data:/data hadoop_full-distributed

	# Get containers' IP addresses
	${node_name}_ip="$(docker inspect -f {{.NetworkSettings.IPAddress}} ${node_name})"

	# Add hosts
	# Make sure you have write permission to the /data/etc/hosts on host.
	echo "${${node_name}_ip}  ${node_name}" >  /data/etc/hosts
done

echo "/data/etc/hosts : "
cat /data/etc/hosts



for node_name in "master" "slave1" "slave2"
do
	# Since Docker version 1.8.1 will register and bridge each running containers automatically, in such case, you can comment out this part.
	docker exec ${node_name} /bin/sh -c "cat /data/etc/hosts >> /etc/hosts"
	docker exec ${node_name} cat /etc/hosts
done




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


for node_name in "master" "slave1" "slave2"
do
	# start sshd
	docker exec ${node_name} service ssh start
done


# Startup cluster
docker exec master /etc/bootstrap.sh 





# Stop cluster
# HADOOP_HOME=/usr/local/hadoop
# docker exec master ${HADOOP_HOME}/sbin/stop-dfs.sh
# docker exec master ${HADOOP_HOME}/sbin/stop-yarn.sh

# Clean up
# docker stop $(docker ps -q)
# docker rm $(docker ps -aq)




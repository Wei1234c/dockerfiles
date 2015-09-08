# Start containers
docker run -dit -P --name=master hadoop_distributed
docker run -dit -P --name=slave1 --net=container:master hadoop_distributed
docker run -dit -P --name=slave2 --net=container:master hadoop_distributed

# Get IP addresses
export master_ip="$(docker inspect master | grep IPAddress | sed 's/["IPAddress",\:,\s,\",\,]//g')"
export slave1_ip="$(docker inspect slave1 | grep IPAddress | sed 's/["IPAddress",\:,\s,\",\,]//g')"
export slave2_ip="$(docker inspect slave2 | grep IPAddress | sed 's/["IPAddress",\:,\s,\",\,]//g')"

echo "${master_ip} master"
echo "${slave1_ip} slave1"
echo "${slave2_ip} slave2"

# Set Hosts
docker exec master echo "${master_ip} master" >> /etc/hosts
docker exec master echo "${slave1_ip} slave1" >> /etc/hosts
docker exec master echo "${slave2_ip} slave2" >> /etc/hosts

docker exec slave1 echo "${master_ip} master" >> /etc/hosts
docker exec slave1 echo "${slave1_ip} slave1" >> /etc/hosts
docker exec slave1 echo "${slave2_ip} slave2" >> /etc/hosts

docker exec slave2 echo "${master_ip} master" >> /etc/hosts
docker exec slave2 echo "${slave1_ip} slave1" >> /etc/hosts
docker exec slave2 echo "${slave2_ip} slave2" >> /etc/hosts

# Startup cluster
# HADOOP_HOME=/usr/local/hadoop
# docker exec master ${HADOOP_HOME}/bin/hdfs namenode -format
# docker exec master /etc/bootstrap.sh -d


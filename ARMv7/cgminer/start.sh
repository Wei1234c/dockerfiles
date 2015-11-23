#!/bin/bash

CGMiner_HOME=/usr/local/cgminer


INDEX=1

# Start containers
docker run -dit -P --name=miner_${INDEX} -v /data:/data wei1234c/cgminer_armv7 

# Get containers' IP addresses
miner_${INDEX}_ip="$(docker inspect -f {{.NetworkSettings.IPAddress}} miner_${INDEX})" 

# start sshd
docker exec miner_${INDEX} service ssh start

# start mining
POOL=stratum+tcp://stratum.bitcoin.cz:3333
USERNAME=WeiLin.worker1 
PASSWORD=1

docker exec miner_${INDEX} /bin/sh -c "/usr/local/cgminer/cgminer -o ${POOL} -u ${USERNAME} -p ${PASSWORD}"
# docker exec miner_${INDEX} /bin/sh -c "/usr/local/cgminer/cgminer --bmsc-options 115200:0.57 -o ${POOL} -u ${USERNAME} -p ${PASSWORD} --bmsc-voltage 0800 --bmsc-freq 1286"
# ./cgminer --userpass userID.workerID:any-password --url stratum+tcp://stratum.bitcoin.cz:3333

# Clean up
# docker stop $(docker ps -q)
# docker rm $(docker ps -aq)




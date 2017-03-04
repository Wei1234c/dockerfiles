#!/bin/bash

CGMiner_HOME=/usr/local/cgminer
POOL=stratum+tcp://stratum.bitcoin.cz:3333
USER=WeiLin

for ((INDEX=1; INDEX <= 1; INDEX++))
do

	# INDEX=1

	# Start containers
	echo "docker run -dit -p 3333:3333 --name=worker${INDEX} -v /data:/data wei1234c/cgminer_armv7"
	docker run -dit -p 3333:3333 --name=worker${INDEX} -v /data:/data wei1234c/cgminer_armv7 

	# start sshd
	docker exec worker${INDEX} service ssh start

	# start mining
	
	USERNAME=${USER}.worker${INDEX}  
	PASSWORD=${INDEX} 

	echo "/usr/local/cgminer/cgminer -o ${POOL} -u ${USERNAME} -p ${PASSWORD}"

	docker exec worker${INDEX} /bin/sh -c "/usr/local/cgminer/cgminer -o ${POOL} -u ${USERNAME} -p ${PASSWORD}"

	# docker exec worker${INDEX} /bin/sh -c "/usr/local/cgminer/cgminer --bmsc-options 115200:0.57 -o ${POOL} -u ${USERNAME} -p ${PASSWORD} --bmsc-voltage 0800 --bmsc-freq 1286"

done

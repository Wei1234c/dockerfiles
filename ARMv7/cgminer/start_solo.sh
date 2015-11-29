#!/bin/bash

CGMiner_HOME=/usr/local/cgminer
POOL='stratum+tcp://stratum.solo.nicehash.com:3334'

# stratum+tcp://stratum.bitsolo.net:3334
USER=191zcVYA2aaBgcxGpVB49em2LotbGgJgwb

for ((INDEX=1; INDEX <= 1; INDEX++))
do

	# Start containers
	docker run -dit -p 3333:3333 --name=miner_${INDEX} -v /data:/data wei1234c/cgminer_armv7 /bin/bash

	# start sshd
	docker exec miner_${INDEX} service ssh start

	# start mining	
	USERNAME=${USER}.worker${INDEX}  
	PASSWORD=${INDEX}
	docker exec miner_${INDEX} /bin/sh -c "/usr/local/cgminer/cgminer -o ${POOL} -u ${USERNAME} -p ${PASSWORD}"

	# docker exec miner_${INDEX} /bin/sh -c "/usr/local/cgminer/cgminer --bmsc-options 115200:0.57 -o ${POOL} -u ${USERNAME} -p ${PASSWORD} --bmsc-voltage 0800 --bmsc-freq 1286"

done

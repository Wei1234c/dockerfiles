#!/bin/bash

PocketMine_HOME=/usr/local/pocketmine
 
# Start containers
docker run -dit -p 19132:19132 -p 19132:19132/udp --name=pocketmine -v /data:/data wei1234c/pocketmine_armv7 /bin/bash

# docker run -it -p 19132:19132 --name=pocketmine -v /data:/data wei1234c/ubuntu_armv7 /bin/bash


# start pocketmine 
# docker exec pocketmine /bin/sh -c "nohup ${PocketMine_HOME}/start.sh 1>&2&> /dev/null &" 
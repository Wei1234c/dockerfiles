#!/bin/bash

docker build -t wei1234c/esp8266 /home/wei/Dropbox/Coding/Git/dockerfiles/amd64/esp8266
docker build -t wei1234c/micropython /home/wei/Dropbox/Coding/Git/dockerfiles/amd64/micropython

 
docker push wei1234c/esp8266
docker push wei1234c/micropython

call drmc
call dcleanup

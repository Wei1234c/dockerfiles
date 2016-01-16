# Set Docker hosts IPs
rpi201='192.168.0.109'
rpi202='192.168.0.114'
master01=${rpi202}
node01=${rpi201}
echo ${master01}
echo ${node01}

# Set up /etc/hosts
sudo echo "${rpi201} rpi201" >> /etc/hosts
sudo echo "${rpi202} rpi202" >> /etc/hosts

# SSH key login
ssh-copy-id root@master01
ssh-copy-id root@node01
ssh root@master01
ssh root@node01


# 初始化變數 _____________________
rpi201='192.168.0.109'
rpi202='192.168.0.114'
master01=${rpi202}
node01=${rpi201}
echo ${master01}
echo ${node01}

# 使用 Consul server ____________________________________________________________________________
# http://blog.hypriot.com/post/let-docker-swarm-all-over-your-raspberry-pi-cluster/ 

consul=${master01}
echo ${consul}
networkinterface=wlan0
echo ${networkinterface}

# Create Consul server
# docker-machine rm consul
# docker-machine -D create --driver=hypriot --hypriot-ip-address=${consul} consul
# docker $(docker-machine config consul) run -d --restart=always -p 8500:8500  --name=consul --hostname=consul nimblestratus/rpi-consul -server -bootstrap 
  docker                                 run -d --restart=always -p 8500:8500  --name=consul --hostname=consul nimblestratus/rpi-consul -server -bootstrap 

# https://gist.github.com/StefanScherer/c3890d8277455e6c257d
# https://docs.docker.com/engine/userguide/networking/get-started-overlay/

# Swarm Manager
docker-machine rm master01
docker-machine -D \
create \
--driver=hypriot \
--hypriot-ip-address=${master01} \
--swarm \
--swarm-master \
--swarm-image=hypriot/rpi-swarm \
--swarm-discovery="consul://${master01}:8500" \
--engine-opt="cluster-store=consul://${master01}:8500" \
--engine-opt="cluster-advertise=${master01}:2376" \
master01

# Swarm Node
docker-machine rm node01
docker-machine -D \
create \
--driver=hypriot \
--hypriot-ip-address=${node01} \
--swarm \
--swarm-image=hypriot/rpi-swarm \
--swarm-discovery="consul://${master01}:8500" \
--engine-opt="cluster-store=consul://${master01}:8500" \
--engine-opt="cluster-advertise=${node01}:2376" \
node01


docker-machine ls
docker $(docker-machine config --swarm master01) info




# Restart Swarm-Manager _____________________________________________________________________
eval $(docker-machine env master01)
docker run -d \
--restart=always \
--name swarm-agent-master \
-p 3376:3376 \
-v /etc/docker:/etc/docker \
hypriot/rpi-swarm \
manage \
--tlsverify \
--tlscacert=/etc/docker/ca.pem \
--tlscert=/etc/docker/server.pem \
--tlskey=/etc/docker/server-key.pem \
-H tcp://0.0.0.0:3376 \
--strategy spread  consul://${master01}:8500

 docker run -d \
--restart=always \
--name swarm-agent \
hypriot/rpi-swarm \
join --advertise ${master01}:2376 consul://${master01}:8500


eval $(docker-machine env node01)
docker run -d \
--restart=always \
--name swarm-agent \
hypriot/rpi-swarm \
join --advertise ${node01}:2376 consul://${master01}:8500




# DockerUI
# https://hub.docker.com/r/hypriot/rpi-dockerui/ 
# http://netbrain.noip.me:9000/#/ 

rpi202='192.168.0.114'
master01=${rpi202}
docker pull hypriot/rpi-dockerui
docker $(docker-machine config --swarm master01) run -d -p 9000:9000 --env="constraint:node==master01" --name=dockerui hypriot/rpi-dockerui -e http://${master01}:3376 
# docker run -d -p 9000:9000 --name=dockerui hypriot/rpi-dockerui -e http://${master01}:3376 

docker $(docker-machine config --swarm master01) ps




# Docker Network ____________________________________________________________________________________________________
# http://blog.hypriot.com/post/introducing-hypriot-cluster-lab-docker-clustering-as-easy-as-it-gets/
# https://docs.docker.com/engine/userguide/networking/get-started-overlay/
# Create Overlay Network
docker $(docker-machine config --swarm master01) network create --driver=overlay overlay-network
docker $(docker-machine config --swarm master01) network ls

# As you can see we now have successfully created our first Docker multi-node overlay network. This overlay network is really useful. Any container started in this network can talk to any other container in the network by default.
# In order to see how this works we are going to start two containers on different cluster nodes that will talk to each other.
# docker -H ${master01}:3376 run -itd --name=webserver --net=my-net --env="constraint:node==node01" hypriot/rpi-nano-httpd
docker $(docker-machine config --swarm master01) run -itd --name=webserver --net=overlay-network --env="constraint:node==node01" hypriot/rpi-nano-httpd

# Everything so far looks good. So let’s get the final piece working by starting a web client that talks to our webserver.
# docker -H ${master01}:3376 run -it --rm --net=my-net --env="contraint:node==master01" hypriot/armhf-busybox wget -O- http://webserver/index.html
docker $(docker-machine config --swarm master01) run -it --rm --net=overlay-network --env="contraint:node==master01" hypriot/armhf-busybox wget -O- http://webserver/index.html


 

# 其他測試 ___________________________________________________________________________________
# docker -H ${node01}:2376 info
# docker -H ${master01}:3376 info
# docker exec swarm-agent-master /swarm manage -H 0.0.0.0:3376 nodes://${node01}:2376,${master01}:2376
# docker run -d hypriot/rpi-swarm manage -H 0.0.0.0:3376 ${node01}:2376,${master01}:2376

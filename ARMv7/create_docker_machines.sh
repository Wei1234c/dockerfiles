
# Set Docker hosts IPs
rpi201='192.168.0.109'
rpi202='192.168.0.114'
sudo echo "${rpi201} rpi201" >> /etc/hosts
sudo echo "${rpi202} rpi202" >> /etc/hosts

# SSH key login
ssh-copy-id root@rpi201
ssh-copy-id root@rpi202
# ssh-copy-id root@192.168.0.109
# ssh-copy-id root@192.168.0.114
ssh root@rpi201
ssh root@rpi202

# 最終版本 ____________________________________________________________________________________________________
# 最終版本 ____________________________________________________________________________________________________

rpi201='192.168.0.109'
rpi202='192.168.0.114'
echo ${rpi201}
echo ${rpi202}


# docker-machine rm rpi202
# docker-machine -D create -d hypriot --swarm --swarm-image=hypriot/rpi-swarm --swarm-master --swarm-discovery nodes://rpi201:2376,rpi202:2376 --hypriot-ip-address rpi202 rpi202 

# docker-machine rm rpi201
# docker-machine -D create -d hypriot --swarm --swarm-image=hypriot/rpi-swarm                --swarm-discovery nodes://rpi201:2376,rpi202:2376 --hypriot-ip-address rpi201 rpi201


# on rpi201
# 清除 Docker daemon 的 key，以免有時候 Swarm manager 無法連線到 swarm node
# drmc
# sudo service docker stop
# sudo rm /etc/docker/key.json
# sudo service docker start

docker-machine rm rpi202
docker-machine -D create -d hypriot --swarm --swarm-image=hypriot/rpi-swarm --swarm-master --swarm-discovery nodes://${rpi201}:2376,${rpi202}:2376 --hypriot-ip-address ${rpi202} rpi202 

docker-machine rm rpi201
docker-machine -D create -d hypriot --swarm --swarm-image=hypriot/rpi-swarm                --swarm-discovery nodes://${rpi201}:2376,${rpi202}:2376 --hypriot-ip-address ${rpi201} rpi201


docker-machine ls
# eval $(docker-machine env rpi201)
# eval $(docker-machine env rpi202)
# eval $(docker-machine env --swarm rpi202)
# docker info
docker $(docker-machine config --swarm rpi202) info


# DockerUI
# http://netbrain.noip.me:9000/#/ 
rpi202='192.168.0.114'
docker $(docker-machine config --swarm rpi202) run -d -p 9000:9000 --env="constraint:node==rpi202" --name dockerui hypriot/rpi-dockerui -e http://${rpi202}:2376
docker $(docker-machine config --swarm rpi202) ps


# Docker Network ____________________________________________________________________________________________________
# http://blog.hypriot.com/post/introducing-hypriot-cluster-lab-docker-clustering-as-easy-as-it-gets/
# Create Overlay Network
docker $(docker-machine config --swarm rpi202) network create -d overlay my-net

# As you can see we now have successfully created our first Docker multi-node overlay network. This overlay network is really useful. Any container started in this network can talk to any other container in the network by default.
# In order to see how this works we are going to start two containers on different cluster nodes that will talk to each other.
# docker -H ${rpi202}:3376 run -itd --name=webserver --net=my-net --env="constraint:node==rpi201" hypriot/rpi-nano-httpd
docker $(docker-machine config --swarm rpi202) run -itd --name=webserver --net=my-net --env="constraint:node==rpi201" hypriot/rpi-nano-httpd

# Everything so far looks good. So let’s get the final piece working by starting a web client that talks to our webserver.
# docker -H ${rpi202}:3376 run -it --rm --net=my-net --env="contraint:node==rpi202" hypriot/armhf-busybox wget -O- http://webserver/index.html
docker $(docker-machine config --swarm rpi202) run -it --rm --net=my-net --env="contraint:node==rpi202" hypriot/armhf-busybox wget -O- http://webserver/index.html


# 最終版本 ____________________________________________________________________________________________________
# 最終版本 ____________________________________________________________________________________________________




# 使用 Consul server ____________________________________________________________________________

# http://blog.hypriot.com/post/let-docker-swarm-all-over-your-raspberry-pi-cluster/ 

# Create Consul server
docker-machine rm consul
docker-machine -D create -d hypriot --hypriot-ip-address=192.168.0.114 consul
docker $(docker-machine config consul) run -d --restart=always -p 8500:8500  --name=consul -h consul nimblestratus/rpi-consul -server -bootstrap


# 建立 Master
docker-machine rm rpi202
docker-machine -D \
create \
--driver=hypriot \
--hypriot-ip-address=192.168.0.114 \
--swarm \
--swarm-master \
--swarm-image=hypriot/rpi-swarm \
--swarm-discovery=consul://192.168.0.114:8500 \
rpi202

# docker-machine rm rpi202
# docker-machine -D \
# create \
# --driver=hypriot \
# --hypriot-ip-address=192.168.0.114 \
# --swarm \
# --swarm-master \
# --swarm-image=hypriot/rpi-swarm \
# --swarm-discovery="consul://$(docker-machine env consul):8500" \
# --engine-opt="cluster-store=consul://$(docker-machine env consul):8500" \
# --engine-opt="cluster-advertise=eth0:2376" \
# rpi202

# 節省資源：使用 master 當作 consul
# eval $(docker-machine env --swarm rpi202)  
# docker info  
# docker run -d --restart=always -p 8500:8500 -h consul nimblestratus/rpi-consul -server -bootstrap 

# 建立 Slaves
docker-machine rm rpi201
docker-machine -D \
create \
--driver=hypriot \
--hypriot-ip-address=192.168.0.109 \
--swarm  \
--swarm-image=hypriot/rpi-swarm \
--swarm-discovery=consul://192.168.0.114:8500 \
rpi201

# docker-machine rm rpi201
# docker-machine -D \
# create \
# --driver=hypriot \
# --hypriot-ip-address=192.168.0.109 \
# --swarm  \
# --swarm-image=hypriot/rpi-swarm \
# --swarm-discovery="consul://$(docker-machine env consul):8500" \
# --engine-opt="cluster-store=consul://$(docker-machine env consul):8500" \
# --engine-opt="cluster-advertise=eth0:2376" \
# rpi201

docker-machine ls
eval $(docker-machine env --swarm rpi202)
docker info






# 使用 Token service ____________________________________________________________________________
# Discovery: https://docs.docker.com/swarm/discovery/
# https://discovery-stage.hub.docker.com/v1/clusters/83cebce72c32987caf4c7b2c32487ae0

# Create Swarm Token
# If you already have a Docker swarm container up and running, you also can create a new Cluster ID with docker run --rm hypriot/rpi-swarm create
export TOKEN=$(docker run --rm hypriot/rpi-swarm create) 
echo ${TOKEN}

# Create the Swarm Master
docker-machine rm rpi202
docker-machine -D create -d hypriot --swarm --swarm-image=hypriot/rpi-swarm --swarm-master --swarm-discovery token://${TOKEN} --hypriot-ip-address 192.168.0.114 rpi202

# Create the Swarm nodes
docker-machine rm rpi201
docker-machine -D create -d hypriot --swarm --swarm-image=hypriot/rpi-swarm                --swarm-discovery token://${TOKEN} --hypriot-ip-address 192.168.0.109 rpi201 

docker-machine ls
eval $(docker-machine env --swarm rpi202)
docker info





# Restart Swarm-Manager _____________________________________________________________________
eval $(docker-machine env rpi202)
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
--strategy spread nodes://192.168.0.109:2376,192.168.0.114:2376


# Restart Swarm-Node
sudo docker run -d \
--restart=always \
--name swarm-agent \
hypriot/rpi-swarm \
join --advertise 192.168.0.114:2376 nodes://192.168.0.109:2376,192.168.0.114:2376

eval $(docker-machine env rpi201)
sudo docker run -d \
--restart=always \
--name swarm-agent \
hypriot/rpi-swarm \
join --advertise 192.168.0.109:2376 nodes://192.168.0.109:2376,192.168.0.114:2376


# 其他測試 ___________________________________________________________________________________
docker -H 192.168.0.109:2376 info
docker -H 192.168.0.114:3376 info
docker exec swarm-agent-master /swarm manage -H 0.0.0.0:3376 192.168.0.109:2376,192.168.0.114:2376
docker exec swarm-agent-master /swarm manage -H 0.0.0.0:3376 nodes://192.168.0.109:2376,192.168.0.114:2376
# docker run --rm hypriot/rpi-swarm manage -H 0.0.0.0:3376 nodes://192.168.0.109,192.168.0.114
docker run -d hypriot/rpi-swarm manage -H 0.0.0.0:3376 192.168.0.109:2376,192.168.0.114:2376

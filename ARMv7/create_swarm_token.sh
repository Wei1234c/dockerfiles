# 使用 Token service ____________________________________________________________________________
# Discovery: https://docs.docker.com/swarm/discovery/
# https://discovery-stage.hub.docker.com/v1/clusters/83cebce72c32987caf4c7b2c32487ae0

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
 

# Create Swarm Token
# If you already have a Docker swarm container up and running, you also can create a new Cluster ID with docker run --rm hypriot/rpi-swarm create
export TOKEN=$(docker run --rm hypriot/rpi-swarm create) 
echo ${TOKEN}

# Create the Swarm Master
docker-machine rm master01
docker-machine -D create -d hypriot --swarm --swarm-image=hypriot/rpi-swarm --swarm-master --swarm-discovery token://${TOKEN} --hypriot-ip-address ${master01} master01

# Create the Swarm nodes
docker-machine rm node01
docker-machine -D create -d hypriot --swarm --swarm-image=hypriot/rpi-swarm                --swarm-discovery token://${TOKEN} --hypriot-ip-address ${node01} node01 

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
--strategy spread token://${TOKEN}

# Restart Swarm-Node
docker run -d \
--restart=always \
--name swarm-agent \
hypriot/rpi-swarm \
join --advertise ${master01}:2376 token://${TOKEN}

eval $(docker-machine env node01)
sudo docker run -d \
--restart=always \
--name swarm-agent \
hypriot/rpi-swarm \
join --advertise ${node01}:2376 token://${TOKEN}



# 其他測試 ___________________________________________________________________________________
# docker -H ${node01}:2376 info
# docker -H ${master01}:3376 info
# docker exec swarm-agent-master /swarm manage -H 0.0.0.0:3376 nodes://${node01}:2376,${master01}:2376
# docker run -d hypriot/rpi-swarm manage -H 0.0.0.0:3376 ${node01}:2376,${master01}:2376
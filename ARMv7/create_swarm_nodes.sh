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


# on node01
# 清除 Docker daemon 的 key，以免有時候 Swarm manager 無法連線到 swarm node
# drmc
# sudo service docker stop
# sudo rm /etc/docker/key.json
# sudo service docker start

docker-machine rm master01
docker-machine -D create -d hypriot --swarm --swarm-image=hypriot/rpi-swarm --swarm-master --swarm-discovery nodes://${master01}:2376,${node01}:2376 --hypriot-ip-address ${master01} master01 

docker-machine rm node01
docker-machine -D create -d hypriot --swarm --swarm-image=hypriot/rpi-swarm                --swarm-discovery nodes://${master01}:2376,${node01}:2376 --hypriot-ip-address ${node01} node01

docker-machine ls
docker $(docker-machine config --swarm master01) info

# sudo service docker restart
# docker $(docker-machine config --swarm master01) info

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
--strategy spread nodes://${master01}:2376,${node01}:2376


# Restart Swarm-Node
sudo docker run -d \
--restart=always \
--name swarm-agent \
hypriot/rpi-swarm \
join --advertise ${master01}:2376 nodes://${master01}:2376,${node01}:2376


eval $(docker-machine env node01)
sudo docker run -d \
--restart=always \
--name swarm-agent \
hypriot/rpi-swarm \
join --advertise ${node01}:2376 nodes://${master01}:2376,${node01}:2376


# 其他測試 ___________________________________________________________________________________
# docker -H ${node01}:2376 info
# docker -H ${master01}:3376 info
# docker exec swarm-agent-master /swarm manage -H 0.0.0.0:3376 nodes://${node01}:2376,${master01}:2376
# docker run -d hypriot/rpi-swarm manage -H 0.0.0.0:3376 ${node01}:2376,${master01}:2376

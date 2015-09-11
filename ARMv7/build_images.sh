docker pull armv7/armhf-ubuntu:14.04
docker tag armv7/armhf-ubuntu:14.04 ubuntu:14.04
docker tag ubuntu:14.04 ubuntu:latest
docker build -t oracle-java8 java/oracle-java8
docker build -t sshd sshd
docker build -t oracle-java8_sshd java_sshd
docker build -t python python
docker build -t nodejs nodejs
docker build -t mysql mysql
docker build -t mongodb mongodb
docker build -t apache apache
docker build -t tomcat tomcat
docker build -t hadoop_pseudo-distributed hadoop/pseudo-distributed
docker tag hadoop_pseudo-distributed wei1234c/hadoop_pseudo-distributed_armv7
docker build -t hadoop_distributed hadoop/cluster/node

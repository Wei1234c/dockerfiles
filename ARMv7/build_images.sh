docker pull armv7/armhf-ubuntu:14.04
docker tag armv7/armhf-ubuntu:14.04 ubuntu:14.04
docker tag ubuntu:14.04 ubuntu:latest

docker build -t wei1234/oracle-java8 java/oracle-java8
docker tag wei1234/oracle-java8 oracle-java8

docker build -t wei1234/sshd sshd
docker tag wei1234/sshd sshd

docker build -t wei1234/oracle-java8_sshd java_sshd
docker tag wei1234/sshd sshd

docker build -t wei1234/python python
docker tag wei1234/python python

docker build -t wei1234/nodejs nodejs
docker tag wei1234/nodejs nodejs

docker build -t wei1234/php:5 php/5
docker tag wei1234/php:5 php:5

docker build -t wei1234/php:cli php/5.6
docker tag wei1234/php:cli php:cli

# docker build -t wei1234/php:apache php/5.6/apache

docker build -t wei1234/mysql mysql
docker tag wei1234/mysql mysql

docker build -t wei1234/mongodb mongodb
docker tag wei1234/mongodb mongodb

docker build -t wei1234/apache apache
docker tag wei1234/apache apache

docker build -t wei1234/tomcat tomcat
docker tag wei1234/tomcat tomcat

docker build -t wei1234/hadoop_pseudo-distributed hadoop/pseudo-distributed
docker tag wei1234/hadoop_pseudo-distributed hadoop_pseudo-distributed
docker tag wei1234/hadoop_pseudo-distributed wei1234c/hadoop_pseudo-distributed_armv7

docker build -t wei1234/hadoop_full-distributed hadoop/cluster/node
docker tag wei1234/hadoop_full-distributed hadoop_full-distributed

docker build -t wei1234/haproxy haproxy/1.5
docker tag wei1234/haproxy haproxy

docker build -t wei1234/jupyter-notebook notebook
docker tag wei1234/jupyter-notebook jupyter-notebook

docker build -t wei1234/lamp lamp
docker tag wei1234/lamp lamp





# Java ____________________________________________________________________________________________
# https://github.com/dockerfile/java
docker run -it --rm -P --name=java oracle-java8

# SSH _____________________________________________________________________________________________
# https://docs.docker.com/examples/running_ssh_service/
docker run -d -p 2222:22 --name=sshd sshd
# # Get port mapping
# docker port sshd 22
# # 0.0.0.0:2222
# # Test
# ssh localhost -p 2222
# # Clean up
# docker stop sshd
# docker rm sshd

# Java & SSH ______________________________________________________________________________________
docker run -d -p 2022:22 --name=java_sshd oracle-java8_sshd

# Python __________________________________________________________________________________________
# https://github.com/dockerfile/python
docker run -it --rm -P --name=python python python3

# NodeJS __________________________________________________________________________________________
# https://github.com/dockerfile/nodejs
docker run -it --rm -P --name=nodejs nodejs node

# MySQL ___________________________________________________________________________________________
# https://github.com/dockerfile/mysql
docker run -d -p 3306:3306 --name=mysql mysql

# Mongodb _________________________________________________________________________________________
# https://github.com/dockerfile/mongodb
docker run -d -p 27017:27017 --name=mongodb mongodb

# Apache __________________________________________________________________________________________
# https://hub.docker.com/_/httpd/
docker run -d -p 80:80 --name=apache apache

# Tomcat __________________________________________________________________________________________
# https://hub.docker.com/_/tomcat/
docker run -d -p 8080:8080 --name=tomcat tomcat

# Hadoop __________________________________________________________________________________________
# https://github.com/sequenceiq/hadoop-docker
# docker run -it --rm -P --name=hadoop_pseudo hadoop_pseudo-distributed /etc/bootstrap.sh -bash
docker run -d -P --name=hadoop_pseudo hadoop_pseudo-distributed
# # Testing
# cd ${HADOOP_PREFIX}
# # run the mapreduce
# bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar grep input output 'dfs[a-z.]+'
# # check the output
# bin/hdfs dfs -cat output/*
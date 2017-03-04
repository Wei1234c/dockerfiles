# Hadoop full-distributed dockerfile for ARMv7


by: [Wei Lin](mailto://wei1234c@gmail.com) / date: 2015/9/8


## To build image: ##

    cd /path/of/the/Dockerfile
    
    docker build -t hadoop_distributed .



##  To start a container: ##

    docker run -dit -P --name=hadoop_distributed hadoop_distributed

##  To start a cluster: ##

    start.sh


----------


- Ref 1: [Oracle-Java8 dockerfile](https://github.com/dockerfile/java/tree/master/oracle-java8 "Oracle-Java8 dockerfile")
- Ref 2: [SSHD dockerfile](https://docs.docker.com/examples/running_ssh_service/ "SSHD dockerfile")
- Ref 3: [Hadoop dockerfile](https://github.com/sequenceiq/hadoop-docker "Hadoop dockerfile")


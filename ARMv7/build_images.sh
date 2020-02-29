<<<<<<< HEAD
#!/bin/bash

docker pull armv7/armhf-ubuntu:14.04
docker tag armv7/armhf-ubuntu:14.04 ubuntu:14.04
docker pull nimblestratus/rpi-consul


docker build -t wei1234c/ubuntu_armv7 /dockerfiles/ARMv7/ubuntu
docker build -t wei1234c/sshd_armv7 /dockerfiles/ARMv7/sshd
docker build -t wei1234c/java_armv7 /dockerfiles/ARMv7/java/oracle-java8
docker build -t wei1234c/java_sshd_armv7 /dockerfiles/ARMv7/java_sshd
docker build -t wei1234c/php_armv7:5 /dockerfiles/ARMv7/php/5
docker build -t wei1234c/php_armv7:cli /dockerfiles/ARMv7/php/5.6
docker build -t wei1234c/python_armv7 /dockerfiles/ARMv7/python
docker build -t wei1234c/python_armv7_3.6.10 /dockerfiles/ARMv7/python/python3.6
docker build -t wei1234c/nodejs_armv7 /dockerfiles/ARMv7/nodejs
docker build -t wei1234c/jupyter-notebook_armv7 /dockerfiles/ARMv7/notebook
docker build -t wei1234c/haproxy_armv7 /dockerfiles/ARMv7/haproxy/1.5
docker build -t wei1234c/apache_armv7 /dockerfiles/ARMv7/apache
docker build -t wei1234c/tomcat_armv7 /dockerfiles/ARMv7/tomcat
docker build -t wei1234c/lamp_armv7 /dockerfiles/ARMv7/lamp
docker build -t wei1234c/mongodb_armv7 /dockerfiles/ARMv7/mongodb
docker build -t wei1234c/mysql_armv7 /dockerfiles/ARMv7/mysql
docker build -t wei1234c/lubuntu-desktop_armv7 /dockerfiles/ARMv7/lubuntu-desktop
docker build -t wei1234c/hadoop_pseudo-distributed_armv7 /dockerfiles/ARMv7/hadoop/pseudo-distributed
docker build -t wei1234c/hbase_armv7 /dockerfiles/ARMv7/hbase
docker build -t wei1234c/hive_armv7 /dockerfiles/ARMv7/hive
docker build -t wei1234c/hadoop_full-distributed_armv7 /dockerfiles/ARMv7/hadoop/cluster/node
docker build -t wei1234c/cgminer_armv7 /dockerfiles/ARMv7/cgminer
docker build -t wei1234c/pocketmine_armv7 /dockerfiles/ARMv7/pocketmine
docker build -t wei1234c/redis_armv7 /dockerfiles/ARMv7/redis
docker build -t wei1234c/celery_armv7 /dockerfiles/ARMv7/celery
docker build -t wei1234c/ipython_parallel_armv7 /dockerfiles/ARMv7/ipp
docker build -t wei1234c/alpine_armv7 /dockerfiles/ARMv7/alpine
docker build -t wei1234c/one_for_all_all_for_one_armv7 /dockerfiles/ARMv7/one_for_all_all_for_one
docker build -t wei1234c/rpitx /dockerfiles/ARMv7/rpitx
docker build -t wei1234c/ubuntu_armv7:16.04 /dockerfiles/ARMv7/ubuntu/16.04
docker tag wei1234c/ubuntu_armv7:16.04 ubuntu:latest  


docker push wei1234c/ubuntu_armv7
docker push wei1234c/sshd_armv7
docker push wei1234c/java_armv7
docker push wei1234c/java_sshd_armv7
docker push wei1234c/php_armv7:5
docker push wei1234c/php_armv7:cli
docker push wei1234c/python_armv7
docker push wei1234c/python_armv7_3.6.10 
docker push wei1234c/nodejs_armv7
docker push wei1234c/jupyter-notebook_armv7
docker push wei1234c/haproxy_armv7
docker push wei1234c/apache_armv7
docker push wei1234c/tomcat_armv7
docker push wei1234c/lamp_armv7
docker push wei1234c/mongodb_armv7
docker push wei1234c/mysql_armv7
docker push wei1234c/lubuntu-desktop_armv7
docker push wei1234c/hadoop_pseudo-distributed_armv7
docker push wei1234c/hbase_armv7
docker push wei1234c/hive_armv7
docker push wei1234c/hadoop_full-distributed_armv7
docker push wei1234c/cgminer_armv7
docker push wei1234c/pocketmine_armv7
docker push wei1234c/redis_armv7
docker push wei1234c/celery_armv7
docker push wei1234c/ipython_parallel_armv7
docker push wei1234c/alpine_armv7
docker push wei1234c/one_for_all_all_for_one_armv7
docker push wei1234c/esp8266_armv7

call drmc
call dcleanup
=======
#!/bin/bash

docker pull armv7/armhf-ubuntu:14.04
docker tag armv7/armhf-ubuntu:14.04 ubuntu:14.04
docker pull nimblestratus/rpi-consul


docker build -t wei1234c/ubuntu_armv7 /dockerfiles/ARMv7/ubuntu
docker build -t wei1234c/sshd_armv7 /dockerfiles/ARMv7/sshd
docker build -t wei1234c/java_armv7 /dockerfiles/ARMv7/java/oracle-java8
docker build -t wei1234c/java_sshd_armv7 /dockerfiles/ARMv7/java_sshd
docker build -t wei1234c/php_armv7:5 /dockerfiles/ARMv7/php/5
docker build -t wei1234c/php_armv7:cli /dockerfiles/ARMv7/php/5.6
docker build -t wei1234c/python_armv7 /dockerfiles/ARMv7/python
docker build -t wei1234c/nodejs_armv7 /dockerfiles/ARMv7/nodejs
docker build -t wei1234c/jupyter-notebook_armv7 /dockerfiles/ARMv7/notebook
docker build -t wei1234c/haproxy_armv7 /dockerfiles/ARMv7/haproxy/1.5
docker build -t wei1234c/apache_armv7 /dockerfiles/ARMv7/apache
docker build -t wei1234c/tomcat_armv7 /dockerfiles/ARMv7/tomcat
docker build -t wei1234c/lamp_armv7 /dockerfiles/ARMv7/lamp
docker build -t wei1234c/mongodb_armv7 /dockerfiles/ARMv7/mongodb
docker build -t wei1234c/mysql_armv7 /dockerfiles/ARMv7/mysql
docker build -t wei1234c/lubuntu-desktop_armv7 /dockerfiles/ARMv7/lubuntu-desktop
docker build -t wei1234c/hadoop_pseudo-distributed_armv7 /dockerfiles/ARMv7/hadoop/pseudo-distributed
docker build -t wei1234c/hbase_armv7 /dockerfiles/ARMv7/hbase
docker build -t wei1234c/hive_armv7 /dockerfiles/ARMv7/hive
docker build -t wei1234c/hadoop_full-distributed_armv7 /dockerfiles/ARMv7/hadoop/cluster/node
docker build -t wei1234c/cgminer_armv7 /dockerfiles/ARMv7/cgminer
docker build -t wei1234c/pocketmine_armv7 /dockerfiles/ARMv7/pocketmine
docker build -t wei1234c/redis_armv7 /dockerfiles/ARMv7/redis
docker build -t wei1234c/celery_armv7 /dockerfiles/ARMv7/celery
docker build -t wei1234c/ipython_parallel_armv7 /dockerfiles/ARMv7/ipp
docker build -t wei1234c/alpine_armv7 /dockerfiles/ARMv7/alpine
docker build -t wei1234c/one_for_all_all_for_one_armv7 /dockerfiles/ARMv7/one_for_all_all_for_one
docker build -t wei1234c/rpitx /dockerfiles/ARMv7/rpitx
docker build -t wei1234c/ubuntu_armv7:16.04 /dockerfiles/ARMv7/ubuntu/16.04
docker tag wei1234c/ubuntu_armv7:16.04 ubuntu:latest  


docker push wei1234c/ubuntu_armv7
docker push wei1234c/sshd_armv7
docker push wei1234c/java_armv7
docker push wei1234c/java_sshd_armv7
docker push wei1234c/php_armv7:5
docker push wei1234c/php_armv7:cli
docker push wei1234c/python_armv7
docker push wei1234c/nodejs_armv7
docker push wei1234c/jupyter-notebook_armv7
docker push wei1234c/haproxy_armv7
docker push wei1234c/apache_armv7
docker push wei1234c/tomcat_armv7
docker push wei1234c/lamp_armv7
docker push wei1234c/mongodb_armv7
docker push wei1234c/mysql_armv7
docker push wei1234c/lubuntu-desktop_armv7
docker push wei1234c/hadoop_pseudo-distributed_armv7
docker push wei1234c/hbase_armv7
docker push wei1234c/hive_armv7
docker push wei1234c/hadoop_full-distributed_armv7
docker push wei1234c/cgminer_armv7
docker push wei1234c/pocketmine_armv7
docker push wei1234c/redis_armv7
docker push wei1234c/celery_armv7
docker push wei1234c/ipython_parallel_armv7
docker push wei1234c/alpine_armv7
docker push wei1234c/one_for_all_all_for_one_armv7
docker push wei1234c/esp8266_armv7
docker push wei1234c/rpitx

call drmc
call dcleanup
>>>>>>> origin/master

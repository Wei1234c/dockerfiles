# Hadoop dockerfile for armv7
# Ref 1: https://github.com/dockerfile/java/tree/master/oracle-java8
# Ref 2: https://docs.docker.com/examples/running_ssh_service/
# Ref 3: https://github.com/sequenceiq/hadoop-docker
#
# by: Wei Lin
# date: 2015/9/4
# to build image: docker build -t hadoop_pseudo-distributed .
# to test: docker run -d -P --name=hadoop_pseudo hadoop_pseudo-distributed

# Pull base image.
FROM armv7/armhf-ubuntu:14.04
# FROM java8_sshd_root-login

MAINTAINER Wei Lin

# export TERM=linux
ENV TERM linux 

# Identity for excuting the script.
# sudo su
USER root


# Install Java _______________________________________________________________________________________________
RUN \
     echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
     apt-get update && \
     apt-get install -y software-properties-common && \
     add-apt-repository -y ppa:webupd8team/java && \
     apt-get update && \
     apt-get install -y oracle-java8-installer && \
     apt-get remove -y software-properties-common && \
     rm -rf /var/cache/oracle-jdk8-installer
	 
# Define commonly used JAVA_HOME variable.
# export JAVA_HOME="/usr/lib/jvm/java-8-oracle"
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Append PATH
# export PATH=${PATH}:${JAVA_HOME}/bin
# echo ${PATH}
# read -rsp $'Press any key or wait 15 seconds to continue...\n' -n 1 -t 15
ENV PATH ${PATH}:${JAVA_HOME}/bin



# Install SSH ________________________________________________________________________________________________
RUN \ 
     apt-get install -y openssh-server openssh-client rsync && \
     mkdir /var/run/sshd

# passwordless ssh
# RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
# RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
# RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
# RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
	 
	 
# root password and login permission
# Please set root's password as you like
RUN  echo 'root:hadoop' | chpasswd
# RUN  sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Add user pi
# Please set pi's password as you like, or just comment out this.
RUN \
     useradd -G adm,sudo,users -s /bin/bash -m pi && \
     echo 'pi:raspberry' | chpasswd	

# SSH login fix. Otherwise user is kicked off after login
RUN \
     sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# passwordless ssh
# RUN \
     # ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
	 # ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN \
	 ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa && \
	 cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

	 

# Install Hadoop _____________________________________________________________________________________________

# Hadoop environment constants
ENV HADOOP_VERSION 2.7.1
ENV HADOOP_HOME /usr/local/hadoop
ENV HADOOP_PREFIX ${HADOOP_HOME}
ENV HADOOP_INPUT_DIR ${HADOOP_HOME}/input
ENV HADOOP_CONF_DIR ${HADOOP_HOME}/etc/hadoop
ENV HADOOP_COMMON_HOME ${HADOOP_HOME}
ENV HADOOP_HDFS_HOME ${HADOOP_HOME}
ENV HADOOP_MAPRED_HOME ${HADOOP_HOME}
ENV HADOOP_YARN_HOME ${HADOOP_HOME}
ENV YARN_CONF_DIR ${HADOOP_CONF_DIR}

# RUN \
     # export HADOOP_HOME="/usr/local/hadoop" && \
	 # export HADOOP_PREFIX=${HADOOP_HOME} && \
	 # export HADOOP_INPUT_DIR=${HADOOP_HOME}/input && \
	 # export HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop && \
	 # export HADOOP_COMMON_HOME=${HADOOP_HOME} && \
	 # export HADOOP_HDFS_HOME=${HADOOP_HOME} && \
	 # export HADOOP_MAPRED_HOME=${HADOOP_HOME} && \
	 # export HADOOP_YARN_HOME=${HADOOP_HOME} && \
	 # export YARN_CONF_DIR=${HADOOP_CONF_DIR}

	 
# Download script and jars from remote.
# site: http://apache.stu.edu.tw/hadoop/common/hadoop-${HADOOP_VERSION}/
RUN \
     apt-get install -y curl && \
	 curl -s http://apache.stu.edu.tw/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar -zx -C /usr/local/ && \
	 cd /usr/local && \
	 ls -alF && \
	 ln -s ./hadoop-${HADOOP_VERSION} hadoop && \
	 apt-get remove -y curl
	 
# # Copy from local 	 
# COPY bin/hadoop-${HADOOP_VERSION}.tar.gz /usr/local/
# RUN \
     # tar -zx -f /usr/local/hadoop-${HADOOP_VERSION}.tar.gz -C /usr/local/ && \
     # rm -rf /usr/local/hadoop-${HADOOP_VERSION}.tar.gz && \
     # cd /usr/local && \
     # ls -alF && \
     # ln -s ./hadoop-${HADOOP_VERSION} hadoop

# download native support
# RUN mkdir -p /tmp/native
# RUN curl -Ls http://dl.bintray.com/sequenceiq/sequenceiq-bin/hadoop-native-64-${HADOOP_VERSION}.tar | tar -x -C /tmp/native

# fixing the libhadoop.so like a boss
RUN  rm -rf ${HADOOP_HOME}/lib/native
# RUN mv /tmp/native ${HADOOP_HOME}/lib
	 

# Modify hadoop-env.sh	 
RUN \
     env && \
     sed -i "/^export JAVA_HOME/ s:.*:export JAVA_HOME=${JAVA_HOME}\nexport HADOOP_HOME=/usr/local/hadoop\nexport HADOOP_PREFIX=${HADOOP_HOME}\n:" ${HADOOP_CONF_DIR}/hadoop-env.sh && \
     sed -i "/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop:" ${HADOOP_CONF_DIR}/hadoop-env.sh
     
# Backup *.xml	 
RUN \	 
     mkdir ${HADOOP_HOME}/input && \
     cp ${HADOOP_CONF_DIR}/*.xml ${HADOOP_INPUT_DIR}

# pseudo distributed
ADD  config/hdfs-site.xml ${HADOOP_CONF_DIR}/hdfs-site.xml
ADD  config/mapred-site.xml ${HADOOP_CONF_DIR}/mapred-site.xml
ADD  config/yarn-site.xml ${HADOOP_CONF_DIR}/yarn-site.xml
ADD  config/core-site.xml.template ${HADOOP_CONF_DIR}/core-site.xml.template
RUN  sed s/HOSTNAME/localhost/ ${HADOOP_CONF_DIR}/core-site.xml.template > ${HADOOP_CONF_DIR}/core-site.xml  

RUN  ${HADOOP_HOME}/bin/hdfs namenode -format

ADD  config/ssh_config /root/.ssh/config
RUN  chmod 600 /root/.ssh/config && \
     chown root:root /root/.ssh/config
	 
# fix the 254 error code
RUN \
     sed  -i "/^[^#]*UsePAM/ s/.*/#&/" /etc/ssh/sshd_config && \
     echo "UsePAM no" >> /etc/ssh/sshd_config && \
     echo "Port 2122" >> /etc/ssh/sshd_config
	 

# # installing supervisord
# RUN yum install -y python-setuptools
# RUN easy_install pip
# RUN curl https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -o - | python
# RUN pip install supervisor
#
# ADD config/supervisord.conf /etc/supervisord.conf

ADD  config/bootstrap.sh /etc/bootstrap.sh
RUN \
     chown root:root /etc/bootstrap.sh && \
     chmod 700 /etc/bootstrap.sh

# export BOOTSTRAP="/etc/bootstrap.sh"
ENV  BOOTSTRAP /etc/bootstrap.sh

# workingaround docker.io build error
RUN \
     ls -la ${HADOOP_CONF_DIR}/*-env.sh && \
     chmod +x ${HADOOP_CONF_DIR}/*-env.sh && \
     ls -la ${HADOOP_CONF_DIR}/*-env.sh


RUN service ssh start && ${HADOOP_CONF_DIR}/hadoop-env.sh && ${HADOOP_HOME}/sbin/start-dfs.sh && ${HADOOP_HOME}/bin/hdfs dfs -mkdir -p /user/root
RUN service ssh start && ${HADOOP_CONF_DIR}/hadoop-env.sh && ${HADOOP_HOME}/sbin/start-dfs.sh && ${HADOOP_HOME}/bin/hdfs dfs -put ${HADOOP_CONF_DIR} input

CMD ["/etc/bootstrap.sh", "-d"]

# Hdfs ports
EXPOSE 50010 50020 50030 50070 50075 50090
# Mapred ports
EXPOSE 19888
# Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
# Other ports
EXPOSE 49707 2122

# SSHD
EXPOSE 22



# Misc. ______________________________________________________________________________________________________

# Set time zone
RUN \
     echo "Asia/Taipei" > /etc/timezone && \
     dpkg-reconfigure -f noninteractive tzdata
	
# Environment variables
RUN \
     echo " " >> /etc/bash.bashrc && \
     echo "#_____________________" >> /etc/bash.bashrc && \
     echo "force_color_prompt=yes" >> /etc/bash.bashrc && \
     echo "alias cls='clear'" >> /etc/bash.bashrc && \
     echo "export TERM=linux" >> /etc/bash.bashrc 	

# Upgrade and clean up
RUN \
     apt-get dist-upgrade -y && \
     apt-get autoremove -y && \
     apt-get autoclean -y && \
     apt-get clean -y && \
     rm -rf /var/lib/apt/lists/*
# Hadoop distributed mode dockerfile for armv7
# Ref 1: https://github.com/dockerfile/java/tree/master/oracle-java8
# Ref 2: https://docs.docker.com/examples/running_ssh_service/
# Ref 3: https://github.com/sequenceiq/hadoop-docker
#
# by: Wei Lin
# date: 2015/9/7
# to build image: docker build -t hadoop_distributed .
# to test: docker run -dit -P --name=hadoop_distributed hadoop_distributed

FROM wei1234c/java_sshd_armv7

MAINTAINER Wei Lin

ENV TERM linux 

USER root


# Install Java _______________________________________________________________________________________________
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH ${PATH}:${JAVA_HOME}/bin


# Install SSH ________________________________________________________________________________________________
# passwordless ssh
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
ENV HADOOP_CLASSPATH=${JAVA_HOME}/lib/tools.jar
ENV YARN_CONF_DIR ${HADOOP_CONF_DIR}
	 
# Download script and jars from remote.
RUN \
   apt-get install -y curl && \
   curl -s http://apache.stu.edu.tw/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar -zx -C /usr/local/ && \
   cd /usr/local && \
   ln -s ./hadoop-${HADOOP_VERSION} hadoop && \
   ls -alF && \
   apt-get remove -y curl

# Discard native code
RUN rm -rf ${HADOOP_HOME}/lib/native

# Modify hadoop-env.sh	 
RUN \
   env && \
   sed -i "/^export JAVA_HOME/ s:.*:export JAVA_HOME=${JAVA_HOME}\nexport HADOOP_HOME=/usr/local/hadoop\nexport HADOOP_PREFIX=${HADOOP_HOME}\n:" ${HADOOP_CONF_DIR}/hadoop-env.sh && \
   sed -i "/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop:" ${HADOOP_CONF_DIR}/hadoop-env.sh && \
	 echo "export HADOOP_HEAPSIZE=512" >> ${HADOOP_CONF_DIR}/hadoop-env.sh

# Copy configuration files.
ADD config/hdfs-site.xml ${HADOOP_CONF_DIR}/hdfs-site.xml
ADD config/mapred-site.xml ${HADOOP_CONF_DIR}/mapred-site.xml
ADD config/yarn-site.xml ${HADOOP_CONF_DIR}/yarn-site.xml
ADD config/core-site.xml.template ${HADOOP_CONF_DIR}/core-site.xml.template
RUN sed s/HOSTNAME/master/ ${HADOOP_CONF_DIR}/core-site.xml.template > ${HADOOP_CONF_DIR}/core-site.xml 

# Prepare input
RUN \	 
   mkdir ${HADOOP_HOME}/input && \
   cp ${HADOOP_CONF_DIR}/*.xml ${HADOOP_INPUT_DIR}

# Set master and slaves names
RUN \
	echo "master" > ${HADOOP_CONF_DIR}/masters && \
	echo "slave1" > ${HADOOP_CONF_DIR}/slaves && \
	echo "slave2" >> ${HADOOP_CONF_DIR}/slaves

# Add volume
VOLUME /data

# Directory for hadoop.tmp.dir
RUN mkdir /hadoop.tmp.dir

# Format namenode
# RUN ${HADOOP_HOME}/bin/hdfs namenode -format

# Config SSH port and security.
ADD config/ssh_config /root/.ssh/config
RUN \
   chmod 600 /root/.ssh/config && \
   chown root:root /root/.ssh/config
	 
# fix the 254 error code
RUN \
   sed -i "/^[^#]*UsePAM/ s/.*/#&/" /etc/ssh/sshd_config && \
   echo "UsePAM no" >> /etc/ssh/sshd_config && \
   echo "Port 2122" >> /etc/ssh/sshd_config

# # installing supervisord
# RUN yum install -y python-setuptools
# RUN easy_install pip
# RUN curl https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -o - | python
# RUN pip install supervisor
#
# ADD config/supervisord.conf /etc/supervisord.conf

# Add bootstrap.sh
ADD config/bootstrap.sh /etc/bootstrap.sh
RUN \
   chown root:root /etc/bootstrap.sh && \
   chmod 700 /etc/bootstrap.sh

# export BOOTSTRAP="/etc/bootstrap.sh"
ENV BOOTSTRAP /etc/bootstrap.sh

# workingaround docker.io build error
RUN \
   ls -la ${HADOOP_CONF_DIR}/*-env.sh && \
   chmod +x ${HADOOP_CONF_DIR}/*-env.sh && \
   ls -la ${HADOOP_CONF_DIR}/*-env.sh

# 
# RUN service ssh start && ${HADOOP_CONF_DIR}/hadoop-env.sh && ${HADOOP_HOME}/sbin/start-dfs.sh && ${HADOOP_HOME}/bin/hdfs dfs -mkdir -p /user/root
# RUN service ssh start && ${HADOOP_CONF_DIR}/hadoop-env.sh && ${HADOOP_HOME}/sbin/start-dfs.sh && ${HADOOP_HOME}/bin/hdfs dfs -put ${HADOOP_CONF_DIR} input

# Boot up
# CMD ["/etc/bootstrap.sh", "-d"]
CMD ["bash"]

# Hdfs ports
EXPOSE 50010 50020 50030 50070 50075 50090
# Mapred ports
EXPOSE 19888 9000 9001
# Yarn ports
EXPOSE 8020 8021 8030 8031 8032 8033 8040 8042 8088
# Other ports
EXPOSE 49707 2122

# SSHD
EXPOSE 22




# Misc. ______________________________________________________________________________________________________

# Upgrade and clean up
RUN \
	apt-get dist-upgrade -y && \
	apt-get autoremove -y && \
	apt-get autoclean -y && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/*

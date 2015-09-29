# by: Wei Lin
# date: 2015/9/6 

FROM hadoop_pseudo-distributed

MAINTAINER Wei Lin

ENV TERM linux 

USER root


# Java _______________________________________________________________________________________________
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH ${PATH}:${JAVA_HOME}/bin
	 

# Hadoop & Hbase _____________________________________________________________________________________________

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
ENV BOOTSTRAP /etc/bootstrap.sh

# Hbase environment constants
ENV HBASE_VERSION 1.1.2
ENV HBASE_HOME /usr/local/hbase
ENV HBASE_CONF_DIR ${HBASE_HOME}/conf

ENV PATH ${PATH}:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:${HBASE_HOME}/bin
	 
# Download script and jars from remote.
RUN \
	apt-get update && \
	apt-get install -y curl htop && \
	curl -s http://apache.stu.edu.tw/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz | tar -zx -C /usr/local/ && \
	cd /usr/local && \
	ln -s ./hbase-${HBASE_VERSION} hbase && \
	ls -alF && \
	apt-get remove -y curl

# use Hadoop's version of L4J, that of HBase is bit old.
RUN	rm -rf ${HBASE_HOME}/lib/slf4j-log4j*.jar

# Sync *.jar version
ADD sync_jar_version.sh /tmp/
RUN  \
	chmod +x /tmp/sync_jar_version.sh && \
	/tmp/sync_jar_version.sh

# Import config files
ADD	conf/hadoop-env.sh ${HADOOP_CONF_DIR}/
ADD	conf/* ${HBASE_CONF_DIR}/

# Create default HBase folders (local and hdfs)
RUN \	
	service ssh start && \
	${HADOOP_CONF_DIR}/hadoop-env.sh && \
	${HADOOP_HOME}/sbin/start-dfs.sh && \
	${HADOOP_HOME}/bin/hdfs dfsadmin -safemode wait && \
	${HADOOP_HOME}/bin/hdfs dfs -mkdir /hbase && \
	mkdir /hbase

	
WORKDIR ${HBASE_HOME}/bin

# Expose ports
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

# Boot up
CMD ["/etc/bootstrap.sh", "-d"]




# # Misc. ______________________________________________________________________________________________________
# Upgrade and clean up
RUN \
	apt-get dist-upgrade -y && \
	apt-get autoremove -y && \
	apt-get autoclean -y && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/*
